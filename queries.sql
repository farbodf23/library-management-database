--BEGINNER LEVEL QUERIES
SELECT
    *
FROM
    members
WHERE
    membership_status = 'Active';

SELECT
    *
FROM
    authors
WHERE
    country LIKE '%United%';

SELECT
    b.title,
    c.name
FROM
    books b
    JOIN categories c ON b.category_id = c.category_id;

SELECT
    DISTINCT language
FROM
    books --INTERMEDIATE LEVEL QUERIES
SELECT
    b.title,
    a.first_name,
    a.last_name
FROM
    books b
    JOIN book_authors ba ON ba.book_id = b.book_id
    JOIN authors a ON a.author_id = ba.author_id;

SELECT
    m.first_name,
    m.last_name,
    bc.due_date,
    b.title
FROM
    borrow_records br
    JOIN books b ON br.book_id = b.book_id
    JOIN members m ON br.member_id = m.member_id;

SELECT
    m.first_name,
    m.last_name,
    br.*
FROM
    borrow_records br
    JOIN members m ON br.member_id = m.member_id
WHERE
    br.due_date < br.return_date;

SELECT
    m.first_name,
    m.last_name,
    count(*) AS number_of_books
FROM
    borrow_records br
    JOIN members m ON br.member_id = m.member_id
GROUP BY
    m.member_id;

SELECT
    b.title,
    count(br.borrow_date)
FROM
    borrow_records br
    JOIN books b ON br.book_id = b.book_id
GROUP BY
    br.book_id,
    b.title
ORDER BY
    count(br.borrow_date) DESC
LIMIT
    5;

SELECT
    AVG(return_date - borrow_date)
FROM
    borrow_records
WHERE
    return_date IS NOT NULL;

--ADVANCED LEVEL QUERIES
SELECT
    *
FROM
    members
WHERE
    EXISTS (
        SELECT
            1
        FROM
            borrow_records br
        WHERE
            members.member_id = br.member_id
            AND br.status = 'Borrowed'
    )
    AND EXISTS (
        SELECT
            1
        FROM
            borrow_records br2
            JOIN fines f ON f.borrow_id = br2.borrow_id
        WHERE
            br2.member_id = members.member_id
    );

SELECT
    b.title,
    STRING_AGG(a.first_name || ' ' || a.last_name, ', ') AS authors,
    b.available_copies
FROM
    books b
    JOIN book_authors ba ON b.book_id = ba.book_id
    JOIN authors a ON ba.author_id = a.author_id
WHERE
    b.available_copies < 4
GROUP BY
    b.book_id,
    b.title,
    b.available_copies;

SELECT
    m.member_id,
    m.last_name,
    COUNT(br.borrow_id) AS total_borrows
FROM
    borrow_records br
    JOIN members m ON br.member_id = m.member_id
GROUP BY
    m.member_id,
    m.last_name
HAVING
    COUNT(br.borrow_id) > (
        -- Subquery to find the average number of books per member
        SELECT
            AVG(count_per_member)
        FROM
            (
                SELECT
                    COUNT(borrow_id) AS count_per_member
                FROM
                    borrow_records
                GROUP BY
                    member_id
            ) AS sub
    );

SELECT
    a.last_name,
    count(*) AS numberofbooks
FROM
    authors a
    JOIN book_authors ba ON a.author_id = ba.author_id
GROUP BY
    a.author_id,
    a.last_name
ORDER BY
    numberofbooks DESC
LIMIT
    1
SELECT
    *


FROM
    authors a
    JOIN book_authors ba ON a.author_id = ba.author_id
    JOIN books b ON ba.book_id = b.book_id


