CREATE OR REPLACE PROCEDURE borrow_book(
    p_member_id INT,
    p_book_id INT,
    p_librarian_id INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_available INT;
BEGIN
    -- Validate member
    IF NOT EXISTS (
        SELECT 1 FROM members 
        WHERE member_id = p_member_id 
        AND membership_status = 'Active'
    ) THEN
        RAISE EXCEPTION 'Member % is not active', p_member_id;
    END IF;

    -- Get and check availability
    SELECT available_copies INTO v_available
    FROM books
    WHERE book_id = p_book_id;

    IF v_available <= 0 THEN
        RAISE EXCEPTION 'Book % not available', p_book_id;
    END IF;

    -- Atomic operations
    INSERT INTO borrow_records 
        (member_id, book_id, librarian_id, borrow_date, due_date)
    VALUES 
        (p_member_id, p_book_id, p_librarian_id, CURRENT_DATE, CURRENT_DATE + 14);

    UPDATE books 
    SET available_copies = available_copies - 1 
    WHERE book_id = p_book_id;

    RAISE NOTICE 'Book % borrowed by member %', p_book_id, p_member_id;
END;
$$;

CREATE OR REPLACE PROCEDURE return_book(
    p_borrow_id INT,
    p_librarian_id INT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_book_id INT;
    v_due_date DATE;
    v_return_date DATE := CURRENT_DATE;
    v_days_overdue INT;
    v_fine_amount DECIMAL(10,2);
    v_fine_exists BOOLEAN;
BEGIN
    -- 1. Check if borrow record exists and is not already returned
    IF NOT EXISTS (
        SELECT 1 FROM borrow_records
        WHERE borrow_id = p_borrow_id
          AND return_date IS NULL
    ) THEN
        RAISE EXCEPTION 'Borrow record % does not exist or is already returned', p_borrow_id;
    END IF;

    -- 2. Get book_id and due_date
    SELECT book_id, due_date
    INTO v_book_id, v_due_date
    FROM borrow_records
    WHERE borrow_id = p_borrow_id;

    -- 3. Update borrow record: set return date, status, and optionally librarian
    UPDATE borrow_records
    SET return_date = v_return_date,
        status = 'Returned',
        librarian_id = COALESCE(p_librarian_id, librarian_id)  -- keep original if NULL
    WHERE borrow_id = p_borrow_id;

    -- 4. Increase available copies of the book
    UPDATE books
    SET available_copies = available_copies + 1
    WHERE book_id = v_book_id;

    -- 5. Check if the book is overdue and issue a fine if needed
    IF v_due_date < v_return_date THEN
        v_days_overdue := v_return_date - v_due_date;
        v_fine_amount := v_days_overdue * 0.50;   -- $0.50 per day, adjust as you like

        -- Avoid duplicate fines for the same borrow
        SELECT EXISTS(
            SELECT 1 FROM fines WHERE borrow_id = p_borrow_id
        ) INTO v_fine_exists;

        IF NOT v_fine_exists THEN
            INSERT INTO fines (borrow_id, amount, paid_status, issued_date)
            VALUES (p_borrow_id, v_fine_amount, 'Unpaid', CURRENT_DATE);

            RAISE NOTICE 'Fine of $% issued for borrow % (overdue by % days)',
                v_fine_amount, p_borrow_id, v_days_overdue;
        END IF;
    END IF;

    RAISE NOTICE 'Book returned successfully. Borrow ID: %', p_borrow_id;
END;
$$;

CREATE OR REPLACE PROCEDURE pay_fine(
    p_fine_id INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_paid_status VARCHAR(20);
BEGIN
    -- 1. Check if fine exists
    SELECT paid_status INTO v_paid_status
    FROM fines
    WHERE fine_id = p_fine_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Fine % does not exist', p_fine_id;
    END IF;

    -- 2. Only unpaid fines can be paid
    IF v_paid_status IN ('Paid', 'Waived') THEN
        RAISE EXCEPTION 'Fine % is already marked as %', p_fine_id, v_paid_status;
    END IF;

    -- 3. Mark as paid and set payment date
    UPDATE fines
    SET paid_status = 'Paid',
        paid_date   = CURRENT_DATE
    WHERE fine_id = p_fine_id;

    RAISE NOTICE 'Fine % has been paid', p_fine_id;
END;
$$;

CREATE OR REPLACE PROCEDURE waive_fine(
    p_fine_id INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_paid_status VARCHAR(20);
BEGIN
    -- 1. Check if fine exists
    SELECT paid_status INTO v_paid_status
    FROM fines
    WHERE fine_id = p_fine_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Fine % does not exist', p_fine_id;
    END IF;

    -- 2. Only unpaid fines can be waived
    IF v_paid_status IN ('Paid', 'Waived') THEN
        RAISE EXCEPTION 'Fine % is already marked as %', p_fine_id, v_paid_status;
    END IF;

    -- 3. Mark as paid and set payment date
    UPDATE fines
    SET paid_status = 'Waived',
        paid_date   = CURRENT_DATE
    WHERE fine_id = p_fine_id;

    RAISE NOTICE 'Fine % has been waived', p_fine_id;
END;
$$;

CREATE OR REPLACE PROCEDURE suspend_member(p_member_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Lock the member row to prevent concurrent borrows
    PERFORM 1 FROM members WHERE member_id = p_member_id FOR UPDATE;
    
    IF NOT FOUND THEN
        RAISE EXCEPTION 'Member % does not exist', p_member_id;
    END IF;
    
    -- Check if active
    IF (SELECT membership_status FROM members WHERE member_id = p_member_id) != 'Active' THEN
        RAISE EXCEPTION 'Member % is not active, cannot suspend', p_member_id;
    END IF;
    
    -- Check for active borrows
    IF EXISTS (SELECT 1 FROM borrow_records WHERE member_id = p_member_id AND return_date IS NULL) THEN
        RAISE EXCEPTION 'Member % has active borrows and cannot be suspended', p_member_id;
    END IF;
    
    UPDATE members SET membership_status = 'Suspended' WHERE member_id = p_member_id;
    
    RAISE NOTICE 'Member % suspended', p_member_id;
END;
$$;

CREATE OR REPLACE PROCEDURE activate_member(
    p_member_id INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_current_status VARCHAR(20);
    v_unpaid_fines DECIMAL(10,2);
BEGIN
    -- 1. Lock member row to prevent concurrent status changes
    SELECT membership_status INTO v_current_status
    FROM members
    WHERE member_id = p_member_id
    FOR UPDATE;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Member % does not exist', p_member_id;
    END IF;

    -- 2. Cannot activate an already active member
    IF v_current_status = 'Active' THEN
        RAISE EXCEPTION 'Member % is already active', p_member_id;
    END IF;

    -- 3. Check for unpaid fines (business rule: no activation with outstanding debt)
    SELECT COALESCE(SUM(f.amount), 0) INTO v_unpaid_fines
    FROM borrow_records br
    JOIN fines f ON br.borrow_id = f.borrow_id
    WHERE br.member_id = p_member_id
      AND f.paid_status = 'Unpaid';

    IF v_unpaid_fines > 0 THEN
        RAISE EXCEPTION 'Member % has $% in unpaid fines – cannot activate', 
            p_member_id, v_unpaid_fines;
    END IF;

    -- 4. Activate the member
    UPDATE members
    SET membership_status = 'Active'
    WHERE member_id = p_member_id;

    RAISE NOTICE 'Member % is now active', p_member_id;
END;
$$;