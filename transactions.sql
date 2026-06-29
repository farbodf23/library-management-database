--BORROWING A BOOK
BEGIN;
INSERT INTO borrow_records (member_id, book_id, librarian_id, borrow_date, due_date)
    VALUES (1, 5, 2, CURRENT_DATE, CURRENT_DATE + INTERVAL '14 days');

UPDATE books
SET available_copies=available_copies+1
where book_id = 5;
COMMIT;


BEGIN;
UPDATE borrow_records
SET return_date = CURRENT_DATE , status ='Returned'
WHERE book_id =3 AND member_id=3;

UPDATE books
SET available_copies= available_copies +1
Where book_id=3;


COMMIT;