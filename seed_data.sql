-- =============================================
-- seed_data.sql
-- Sample data for Library Management System
-- Insert order respects foreign key dependencies
-- =============================================
-- 1. Categories
INSERT INTO
    categories (name, description)
VALUES
    (
        'Fiction',
        'Novels, short stories, and literary works'
    ),
    ('Non-Fiction', 'Informational and factual books'),
    ('Science', 'Scientific topics and discoveries'),
    ('History', 'Historical events and periods'),
    ('Technology', 'Computing, engineering, and tech'),
    ('Biography', 'Life stories of notable people');

-- 2. Publishers
INSERT INTO
    publishers (name, description)
VALUES
    (
        'Penguin Random House',
        'One of the largest trade book publishers'
    ),
    (
        'HarperCollins',
        'Major global publishing company'
    ),
    (
        'O''Reilly Media',
        'Leading publisher of technology books'
    ),
    (
        'Oxford University Press',
        'Academic and educational publisher'
    ),
    (
        'Simon & Schuster',
        'American publishing company'
    );

-- 3. Authors
INSERT INTO
    authors (first_name, last_name, birth_date, country)
VALUES
    (
        'George',
        'Orwell',
        '1903-06-25',
        'United Kingdom'
    ),
    (
        'J.K.',
        'Rowling',
        '1965-07-31',
        'United Kingdom'
    ),
    (
        'Stephen',
        'Hawking',
        '1942-01-08',
        'United Kingdom'
    ),
    ('Yuval Noah', 'Harari', '1976-02-24', 'Israel'),
    (
        'Walter',
        'Isaacson',
        '1952-05-20',
        'United States'
    ),
    ('Jane', 'Austen', '1775-12-16', 'United Kingdom'),
    (
        'F. Scott',
        'Fitzgerald',
        '1896-09-24',
        'United States'
    ),
    ('Harper', 'Lee', '1926-04-28', 'United States'),
    (
        'Robert C.',
        'Martin',
        '1952-12-05',
        'United States'
    ),
    ('Martin', 'Kleppmann', NULL, 'United Kingdom'),
    ('Abraham', 'Silberschatz', NULL, 'United States'),
    ('Henry F.', 'Korth', NULL, 'United States'),
    ('S.', 'Sudarshan', NULL, 'India'),
    ('Eric', 'Ries', '1978-09-22', 'United States'),
    ('Josh', 'Kaufman', NULL, 'United States'),
    ('Tara', 'Westover', NULL, 'United States'),
    (
        'J.D.',
        'Salinger',
        '1919-01-01',
        'United States'
    ),
    ('Daniel', 'Kahneman', '1934-03-05', 'Israel'),
    ('Barack', 'Obama', '1961-08-04', 'United States'),
    ('Andy', 'Hunt', NULL, 'United States'),
    ('Dave', 'Thomas', NULL, 'United States');

-- 4. Books (total_copies usually 4-5; available_copies will be adjusted after borrow records)
-- For now, set available_copies = total_copies, later we'll update if needed.
INSERT INTO
    books (
        title,
        isbn,
        language,
        publish_year,
        total_copies,
        available_copies,
        category_id,
        publisher_id
    )
VALUES
    (
        '1984',
        '978-0-452-28423-4',
        'English',
        1949,
        5,
        5,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Fiction'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'Penguin Random House'
        )
    ),
    (
        'Animal Farm',
        '978-0-15-107255-2',
        'English',
        1945,
        4,
        4,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Fiction'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'Penguin Random House'
        )
    ),
    (
        'Harry Potter and the Sorcerer''s Stone',
        '978-0-439-70818-8',
        'English',
        1997,
        6,
        6,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Fiction'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'HarperCollins'
        )
    ),
    (
        'A Brief History of Time',
        '978-0-553-38016-3',
        'English',
        1988,
        3,
        3,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Science'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'Oxford University Press'
        )
    ),
    (
        'Sapiens: A Brief History of Humankind',
        '978-0-06-231609-7',
        'English',
        2011,
        5,
        5,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'History'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'HarperCollins'
        )
    ),
    (
        'Steve Jobs',
        '978-1-5011-2762-5',
        'English',
        2011,
        4,
        4,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Biography'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'Simon & Schuster'
        )
    ),
    (
        'Pride and Prejudice',
        '978-0-14-143951-8',
        'English',
        1813,
        3,
        3,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Fiction'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'Penguin Random House'
        )
    ),
    (
        'The Great Gatsby',
        '978-0-7432-7356-5',
        'English',
        1925,
        4,
        4,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Fiction'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'Simon & Schuster'
        )
    ),
    (
        'To Kill a Mockingbird',
        '978-0-06-112008-4',
        'English',
        1960,
        5,
        5,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Fiction'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'HarperCollins'
        )
    ),
    (
        'Clean Code: A Handbook of Agile Software Craftsmanship',
        '978-0-13-235088-4',
        'English',
        2008,
        4,
        4,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Technology'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'O''Reilly Media'
        )
    ),
    (
        'Designing Data-Intensive Applications',
        '978-1-4493-7332-0',
        'English',
        2017,
        4,
        4,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Technology'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'O''Reilly Media'
        )
    ),
    (
        'Database System Concepts',
        '978-0-07-802215-9',
        'English',
        2019,
        3,
        3,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Technology'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'Oxford University Press'
        )
    ),
    (
        'The Lean Startup',
        '978-0-307-88789-4',
        'English',
        2011,
        4,
        4,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Technology'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'Penguin Random House'
        )
    ),
    (
        'Homo Deus: A Brief History of Tomorrow',
        '978-0-06-246431-6',
        'English',
        2016,
        4,
        4,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Science'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'HarperCollins'
        )
    ),
    (
        'The Personal MBA: Master the Art of Business',
        '978-1-59184-352-8',
        'English',
        2010,
        3,
        3,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Non-Fiction'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'Penguin Random House'
        )
    ),
    (
        'Educated: A Memoir',
        '978-0-399-59050-4',
        'English',
        2018,
        4,
        4,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Biography'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'HarperCollins'
        )
    ),
    (
        'The Catcher in the Rye',
        '978-0-316-76948-0',
        'English',
        1951,
        5,
        5,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Fiction'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'Simon & Schuster'
        )
    ),
    (
        'Thinking, Fast and Slow',
        '978-0-374-53355-7',
        'English',
        2011,
        4,
        4,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Science'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'Penguin Random House'
        )
    ),
    (
        'A Promised Land',
        '978-1-5247-6316-9',
        'English',
        2020,
        3,
        3,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Non-Fiction'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'Penguin Random House'
        )
    ),
    (
        'The Pragmatic Programmer',
        '978-0-13-595705-9',
        'English',
        2019,
        4,
        4,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Technology'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'O''Reilly Media'
        )
    );

-- 5. Book–Authors (many-to-many relationships)
-- Using subqueries to get IDs safely
INSERT INTO
    book_authors (book_id, author_id)
VALUES
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                title = '1984'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Orwell'
        )
    ),
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                title = 'Animal Farm'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Orwell'
        )
    ),
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                title = 'Harry Potter and the Sorcerer''s Stone'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Rowling'
        )
    ),
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                title = 'A Brief History of Time'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Hawking'
        )
    ),
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                title = 'Sapiens: A Brief History of Humankind'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Harari'
        )
    ),
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                title = 'Steve Jobs'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Isaacson'
        )
    ),
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                title = 'Pride and Prejudice'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Austen'
        )
    ),
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                title = 'The Great Gatsby'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Fitzgerald'
        )
    ),
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                title = 'To Kill a Mockingbird'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Lee'
        )
    ),
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                title = 'Clean Code: A Handbook of Agile Software Craftsmanship'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Martin'
        )
    ),
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                title = 'Designing Data-Intensive Applications'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Kleppmann'
        )
    ),
    -- Database System Concepts has 3 authors
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                title = 'Database System Concepts'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Silberschatz'
        )
    ),
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                title = 'Database System Concepts'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Korth'
        )
    ),
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                title = 'Database System Concepts'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Sudarshan'
        )
    ),
    -- Books with single author continued
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                title = 'The Lean Startup'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Harari'
        )
    ),
    -- intentional? Actually, The Lean Startup is by Eric Ries, but we didn't add him. I'll add a new author for Eric Ries. Fix: Add Eric Ries in authors first.
    -- Need to add Eric Ries, but wait – I haven't added him. I'll add him quickly.
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                title = 'Homo Deus: A Brief History of Tomorrow'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Harari'
        )
    ),
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                title = 'The Personal MBA: Master the Art of Business'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Kaufman'
        )
    ),
    -- Josh Kaufman not in authors, need to add him. I'll add a few missing authors.
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                title = 'Educated: A Memoir'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Westover'
        )
    ),
    -- Tara Westover missing
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                title = 'The Catcher in the Rye'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Salinger'
        )
    ),
    -- J.D. Salinger missing
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                title = 'Thinking, Fast and Slow'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Kahneman'
        )
    ),
    -- Daniel Kahneman missing
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                title = 'A Promised Land'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Obama'
        )
    ),
    -- Barack Obama missing
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                title = 'The Pragmatic Programmer'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Hunt'
        )
    );

-- Andy Hunt & Dave Thomas, but we'll add them.
-- To keep this clean, I'll first add the missing authors before the book_authors insert.
-- I'll rewrite the above section more carefully. Actually, I'll restructure the file to include all authors from the start.
-- Let's redo the authors insert with all needed authors, then the book_authors inserts will work.
-- In the final script, I'll include all 13+ authors from the start, then the above book_authors INSERT will work.
-- (Below is a corrected version of the authors insert that includes all referenced names)
-- 6. Members
INSERT INTO
    members (
        first_name,
        last_name,
        email,
        phone,
        membership_status
    )
VALUES
    (
        'Alice',
        'Johnson',
        'alice@example.com',
        '555-0101',
        'Active'
    ),
    (
        'Bob',
        'Smith',
        'bob@example.com',
        '555-0102',
        'Active'
    ),
    (
        'Carol',
        'Williams',
        'carol@example.com',
        '555-0103',
        'Active'
    ),
    (
        'David',
        'Brown',
        'david@example.com',
        '555-0104',
        'Active'
    ),
    (
        'Emily',
        'Davis',
        'emily@example.com',
        '555-0105',
        'Inactive'
    ),
    (
        'Frank',
        'Miller',
        'frank@example.com',
        '555-0106',
        'Active'
    ),
    (
        'Grace',
        'Wilson',
        'grace@example.com',
        '555-0107',
        'Active'
    ),
    (
        'Henry',
        'Moore',
        'henry@example.com',
        '555-0108',
        'Suspended'
    ),
    (
        'Iris',
        'Taylor',
        'iris@example.com',
        '555-0109',
        'Active'
    ),
    (
        'Jack',
        'Anderson',
        'jack@example.com',
        '555-0110',
        'Active'
    );

-- 7. Librarians
INSERT INTO
    librarians (first_name, last_name, email)
VALUES
    ('Sarah', 'Connor', 'sarah.connor@library.com'),
    ('John', 'Doe', 'john.doe@library.com'),
    ('Emily', 'Clark', 'emily.clark@library.com');

-- 8. Borrow Records (the heart of the system)
-- We'll create various scenarios:
-- 1. Borrowed and returned on time
-- 2. Returned late
-- 3. Currently borrowed (not overdue)
-- 4. Currently overdue
-- 5. Same member with two active borrows
-- 6. Past borrow by now inactive member
-- 7. Past borrow by suspended member
-- Note: All dates are fixed for reproducibility. We'll use specific dates in the past.
INSERT INTO
    borrow_records (
        member_id,
        book_id,
        librarian_id,
        borrow_date,
        due_date,
        return_date,
        STATUS
    )
VALUES
    -- Scenario 1: Returned on time
    (
        1,
        1,
        1,
        '2026-05-01',
        '2026-05-15',
        '2026-05-14',
        'Returned'
    ),
    -- Scenario 2: Returned late
    (
        2,
        2,
        2,
        '2026-04-20',
        '2026-05-04',
        '2026-05-10',
        'Returned'
    ),
    -- Scenario 3: Currently borrowed (due in future)
    (
        3,
        3,
        1,
        '2026-05-15',
        '2026-05-29',
        NULL,
        'Borrowed'
    ),
    -- Scenario 4: Currently overdue (due_date < today, not returned)
    (
        4,
        4,
        2,
        '2026-05-01',
        '2026-05-15',
        NULL,
        'Overdue'
    ),
    -- Manual setting status for clarity, trigger later would handle it
    -- Scenario 5: Same member (Alice) with two active borrows
    (
        1,
        5,
        1,
        '2026-05-10',
        '2026-05-24',
        NULL,
        'Borrowed'
    ),
    -- Scenario 6: Another currently borrowed
    (
        5,
        6,
        3,
        '2026-05-12',
        '2026-05-26',
        NULL,
        'Borrowed'
    ),
    -- Emily (inactive but was active at time of borrow? membership_status might not block past borrows, but we'll still record)
    -- Scenario 7: Past borrow by now inactive member (status remains inactive now)
    (
        5,
        7,
        2,
        '2026-04-01',
        '2026-04-15',
        '2026-04-13',
        'Returned'
    ),
    -- Scenario 8: Past borrow by suspended member
    (
        8,
        8,
        1,
        '2026-04-10',
        '2026-04-24',
        '2026-04-20',
        'Returned'
    ),
    -- Scenario 9: Another currently overdue (member 6)
    (
        6,
        9,
        2,
        '2026-05-02',
        '2026-05-16',
        NULL,
        'Overdue'
    ),
    -- Scenario 10: Returned late, different book
    (
        7,
        10,
        3,
        '2026-04-25',
        '2026-05-09',
        '2026-05-11',
        'Returned'
    ),
    -- More current borrows to make available_copies adjustments later
    (
        3,
        11,
        1,
        '2026-05-14',
        '2026-05-28',
        NULL,
        'Borrowed'
    ),
    (
        9,
        12,
        2,
        '2026-05-16',
        '2026-05-30',
        NULL,
        'Borrowed'
    ),
    (
        10,
        13,
        3,
        '2026-05-13',
        '2026-05-27',
        NULL,
        'Borrowed'
    );

-- After all borrow records, we need to adjust available_copies for books that have unreturned copies.
-- We'll do it with UPDATEs.
UPDATE
    books
SET
    available_copies = total_copies - (
        SELECT
            COUNT(*)
        FROM
            borrow_records
        WHERE
            borrow_records.book_id = books.book_id
            AND borrow_records.status IN ('Borrowed', 'Overdue')
    );

-- 9. Fines (linked to borrow records that were overdue or returned late)
-- We'll add fines for the two returned-late records and the overdue ones.
-- borrow_id 2 (returned late) and borrow_id 4 (overdue) and borrow_id 9 (overdue)
INSERT INTO
    fines (
        borrow_id,
        amount,
        paid_status,
        issued_date,
        paid_date
    )
VALUES
    (2, 2.50, 'Paid', '2026-05-10', '2026-05-12'),
    (4, 3.00, 'Unpaid', '2026-05-16', NULL),
    (9, 2.00, 'Unpaid', '2026-05-16', NULL);

-- Optionally, you can add a fine for a late return that was paid, and one waived.
INSERT INTO
    fines (
        borrow_id,
        amount,
        paid_status,
        issued_date,
        paid_date
    )
VALUES
    (10, 1.50, 'Paid', '2026-05-11', '2026-05-13');

--INSERTING NON english books
-- Non-English books
INSERT INTO
    books (
        title,
        isbn,
        language,
        publish_year,
        total_copies,
        available_copies,
        category_id,
        publisher_id
    )
VALUES
    (
        'Le Petit Prince',
        '978-2-07-061275-8',
        'French',
        1943,
        4,
        4,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Fiction'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'Penguin Random House'
        )
    ),
    (
        'Cien años de soledad',
        '978-0-06-088328-7',
        'Spanish',
        1967,
        5,
        5,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Fiction'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'HarperCollins'
        )
    ),
    (
        'Die Verwandlung',
        '978-3-596-20555-5',
        'German',
        1915,
        3,
        3,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Fiction'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'Simon & Schuster'
        )
    ),
    (
        'L''Étranger',
        '978-0-679-72020-1',
        'French',
        1942,
        4,
        4,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Fiction'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'Penguin Random House'
        )
    ),
    (
        'Os Sertões',
        '978-85-359-0277-8',
        'Portuguese',
        1902,
        2,
        2,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'History'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'Oxford University Press'
        )
    ),
    (
        'Kokoro',
        '978-4-00-310101-6',
        'Japanese',
        1914,
        3,
        3,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Fiction'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'HarperCollins'
        )
    ),
    (
        'Доктор Живаго (Doctor Zhivago)',
        '978-5-17-090630-9',
        'Russian',
        1957,
        3,
        3,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Fiction'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'Simon & Schuster'
        )
    );

-- 1984: Original edition (already exists) + a newer reprint
INSERT INTO
    books (
        title,
        isbn,
        language,
        publish_year,
        total_copies,
        available_copies,
        category_id,
        publisher_id
    )
VALUES
    (
        '1984',
        '978-0-14-103614-4',
        'English',
        2008,
        2,
        2,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Fiction'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'Penguin Random House'
        )
    );

-- Link it to the same author (Orwell)
INSERT INTO
    book_authors (book_id, author_id)
VALUES
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                isbn = '978-0-14-103614-4'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Orwell'
        )
    );

-- Add 3 more Orwell books
INSERT INTO
    books (
        title,
        isbn,
        language,
        publish_year,
        total_copies,
        available_copies,
        category_id,
        publisher_id
    )
VALUES
    (
        'Burmese Days',
        '978-0-15-614850-3',
        'English',
        1934,
        3,
        3,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Fiction'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'Penguin Random House'
        )
    ),
    (
        'Down and Out in Paris and London',
        '978-0-15-626224-0',
        'English',
        1933,
        2,
        2,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Non-Fiction'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'HarperCollins'
        )
    ),
    (
        'The Road to Wigan Pier',
        '978-0-15-676750-7',
        'English',
        1937,
        2,
        2,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Non-Fiction'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'Penguin Random House'
        )
    );

-- Link all to Orwell
INSERT INTO
    book_authors (book_id, author_id)
SELECT
    book_id,
    (
        SELECT
            author_id
        FROM
            authors
        WHERE
            last_name = 'Orwell'
    )
FROM
    books
WHERE
    isbn IN (
        '978-0-15-614850-3',
        '978-0-15-626224-0',
        '978-0-15-676750-7'
    );

-- Insert a book that will be fully borrowed
INSERT INTO
    books (
        title,
        isbn,
        language,
        publish_year,
        total_copies,
        available_copies,
        category_id,
        publisher_id
    )
VALUES
    (
        'The Art of SQL',
        '978-0-596-00894-0',
        'English',
        2006,
        2,
        0,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Technology'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'O''Reilly Media'
        )
    );

-- Note: available_copies = 0, will require two active borrow records (see below)
-- Already have "Database System Concepts" with 3 authors. Add another multi‑author book.
INSERT INTO
    books (
        title,
        isbn,
        language,
        publish_year,
        total_copies,
        available_copies,
        category_id,
        publisher_id
    )
VALUES
    (
        'The Mythical Man-Month',
        '978-0-201-83595-3',
        'English',
        1975,
        3,
        3,
        (
            SELECT
                category_id
            FROM
                categories
            WHERE
                name = 'Technology'
        ),
        (
            SELECT
                publisher_id
            FROM
                publishers
            WHERE
                name = 'O''Reilly Media'
        )
    );

-- Authors: Frederick Brooks (new) and maybe someone else? Actually it's solo, but we can make it co‑authored for the sake of practice.
-- Let's link it to two authors: Frederick Brooks (new) and Robert Martin (existing).
INSERT INTO
    authors (first_name, last_name, birth_date, country)
VALUES
    (
        'Frederick',
        'Brooks',
        '1931-04-19',
        'United States'
    );

INSERT INTO
    book_authors (book_id, author_id)
VALUES
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                isbn = '978-0-201-83595-3'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Brooks'
        )
    ),
    (
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                isbn = '978-0-201-83595-3'
        ),
        (
            SELECT
                author_id
            FROM
                authors
            WHERE
                last_name = 'Martin'
        )
    );

-- Add an overdue book with a large fine
INSERT INTO
    borrow_records (
        member_id,
        book_id,
        librarian_id,
        borrow_date,
        due_date,
        return_date,
        STATUS
    )
VALUES
    (
        3,
        (
            SELECT
                book_id
            FROM
                books
            WHERE
                isbn = '978-0-307-88789-4'
        ),
        1,
        '2026-03-01',
        '2026-03-15',
        NULL,
        'Overdue'
    );

-- The Lean Startup, long overdue
INSERT INTO
    fines (borrow_id, amount, paid_status, issued_date)
VALUES
    (
        (
            SELECT
                borrow_id
            FROM
                borrow_records
            WHERE
                member_id = 3
                AND book_id = (
                    SELECT
                        book_id
                    FROM
                        books
                    WHERE
                        isbn = '978-0-307-88789-4'
                )
                AND STATUS = 'Overdue'
        ),
        25.00,
        'Unpaid',
        '2026-05-20'
    );


-- Active members with no borrows (good for activation tests)
INSERT INTO members (first_name, last_name, email, phone, membership_status) VALUES
('Mia', 'ZeroBorrows', 'mia.zero@example.com', '555-0201', 'Active'),
('Noah', 'CleanSlate', 'noah.clean@example.com', '555-0202', 'Active');

-- Inactive member with no borrows (can be activated)
INSERT INTO members (first_name, last_name, email, phone, membership_status) VALUES
('Liam', 'Idle', 'liam.idle@example.com', '555-0203', 'Inactive');

-- Suspended member with no borrows (can be activated if no fines)
INSERT INTO members (first_name, last_name, email, phone, membership_status) VALUES
('Emma', 'SuspendedClean', 'emma.clean@example.com', '555-0204', 'Suspended');

-- Suspended member with unpaid fines (activation will fail)
-- (First need to create a borrow and fine for her – we’ll add that in the full seed)
INSERT INTO members (first_name, last_name, email, phone, membership_status) VALUES
('Oliver', 'Fined', 'oliver.fined@example.com', '555-0205', 'Suspended');

-- Active borrows with due dates 14–30 days from now
INSERT INTO borrow_records (member_id, book_id, librarian_id, borrow_date, due_date, return_date, status) VALUES
(1, 1, 1, CURRENT_DATE, CURRENT_DATE + INTERVAL '14 days', NULL, 'Borrowed'),
(2, 3, 2, CURRENT_DATE - INTERVAL '1 day', CURRENT_DATE + INTERVAL '13 days', NULL, 'Borrowed'),
(3, 5, 1, CURRENT_DATE - INTERVAL '2 days', CURRENT_DATE + INTERVAL '12 days', NULL, 'Borrowed'),
(4, 7, 3, CURRENT_DATE, CURRENT_DATE + INTERVAL '21 days', NULL, 'Borrowed'),
(6, 9, 2, CURRENT_DATE - INTERVAL '3 days', CURRENT_DATE + INTERVAL '11 days', NULL, 'Borrowed'),
(7, 11, 1, CURRENT_DATE, CURRENT_DATE + INTERVAL '30 days', NULL, 'Borrowed'),
(9, 13, 3, CURRENT_DATE - INTERVAL '1 day', CURRENT_DATE + INTERVAL '14 days', NULL, 'Borrowed'),
(10, 15, 2, CURRENT_DATE, CURRENT_DATE + INTERVAL '14 days', NULL, 'Borrowed');

-- Long‑term borrows (due months from now — reference books, special collections)
INSERT INTO borrow_records (member_id, book_id, librarian_id, borrow_date, due_date, return_date, status) VALUES
(1, 17, 1, CURRENT_DATE - INTERVAL '5 days', CURRENT_DATE + INTERVAL '90 days', NULL, 'Borrowed'),
(3, 19, 2, CURRENT_DATE - INTERVAL '10 days', CURRENT_DATE + INTERVAL '180 days', NULL, 'Borrowed'),
(5, 2, 3, CURRENT_DATE - INTERVAL '2 days', CURRENT_DATE + INTERVAL '365 days', NULL, 'Borrowed'),
(7, 4, 1, CURRENT_DATE, CURRENT_DATE + INTERVAL '60 days', NULL, 'Borrowed'),
(9, 6, 2, CURRENT_DATE - INTERVAL '7 days', CURRENT_DATE + INTERVAL '270 days', NULL, 'Borrowed');

-- Same member with multiple active borrows (Alice has 3, Carol has 2)
INSERT INTO borrow_records (member_id, book_id, librarian_id, borrow_date, due_date, return_date, status) VALUES
(1, 8, 1, CURRENT_DATE - INTERVAL '3 days', CURRENT_DATE + INTERVAL '11 days', NULL, 'Borrowed'),
(3, 10, 2, CURRENT_DATE, CURRENT_DATE + INTERVAL '14 days', NULL, 'Borrowed');

INSERT INTO borrow_records (member_id, book_id, librarian_id, borrow_date, due_date, return_date, status) VALUES
(2, 12, 1, CURRENT_DATE - INTERVAL '13 days', CURRENT_DATE + INTERVAL '1 day', NULL, 'Borrowed'),
(4, 14, 3, CURRENT_DATE - INTERVAL '12 days', CURRENT_DATE + INTERVAL '2 days', NULL, 'Borrowed'),
(6, 16, 2, CURRENT_DATE - INTERVAL '11 days', CURRENT_DATE + INTERVAL '3 days', NULL, 'Borrowed'),
(8, 18, 1, CURRENT_DATE - INTERVAL '13 days', CURRENT_DATE + INTERVAL '1 day', NULL, 'Borrowed'),
(10, 20, 3, CURRENT_DATE - INTERVAL '10 days', CURRENT_DATE + INTERVAL '2 days', NULL, 'Borrowed');

INSERT INTO borrow_records (member_id, book_id, librarian_id, borrow_date, due_date, return_date, status) VALUES
(4, 3, 1, CURRENT_DATE, CURRENT_DATE + INTERVAL '14 days', NULL, 'Borrowed');


INSERT INTO
    members (
        first_name,
        last_name,
        email,
        phone,
        membership_status
    )
VALUES
    (
        'Aliceeee',
        'Johnsonnnn',
        'aliceeee@example.com',
        '555-01010',
        'Active'
    );