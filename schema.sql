CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    name varchar(200) NOT NULL UNIQUE,
    description TEXT
);

CREATE TABLE publishers(
    publisher_id SERIAL PRIMARY KEY,
    name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);

CREATE TABLE books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    language VARCHAR(50),
    publish_year INT,
    total_copies INT NOT NULL CHECK (total_copies >= 0),
    available_copies INT NOT NULL CHECK (available_copies >= 0),
    category_id INT,
    publisher_id INT,
    CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES categories(category_id),
    CONSTRAINT fk_publisher FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id),
    CONSTRAINT chk_copies CHECK (available_copies <= total_copies)
);

CREATE TABLE authors (
    author_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    birth_date DATE,
    country VARCHAR(100)
);

CREATE TABLE book_authors (
    book_id INT NOT NULL,
    author_id INT NOT NULL,
    PRIMARY KEY (book_id, author_id),
    CONSTRAINT fk_books FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE CASCADE,
    CONSTRAINT fk_authors FOREIGN KEY (author_id) REFERENCES authors(author_id) ON DELETE CASCADE
);

CREATE TABLE members (
    member_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone VARCHAR(20),
    join_date DATE DEFAULT CURRENT_DATE,
    membership_status VARCHAR(20) DEFAULT 'Active' CHECK (
        membership_status IN ('Active', 'Inactive', 'Suspended')
    )
);

CREATE TABLE librarians (
    librarian_id SERIAL PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    hire_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE borrow_records (
    borrow_id SERIAL PRIMARY KEY,
    member_id INT NOT NULL,
    book_id INT NOT NULL,
    librarian_id INT,
    borrow_date DATE NOT NULL DEFAULT CURRENT_DATE,
    due_date DATE NOT NULL,
    return_date DATE,
    STATUS VARCHAR(20) DEFAULT 'Borrowed' CHECK (STATUS IN ('Borrowed', 'Returned', 'Overdue')),
    CONSTRAINT fk_br_member FOREIGN KEY (member_id) REFERENCES members(member_id) ON DELETE RESTRICT,
    CONSTRAINT fk_br_book FOREIGN KEY (book_id) REFERENCES books(book_id) ON DELETE RESTRICT,
    CONSTRAINT fk_br_librarian FOREIGN KEY (librarian_id) REFERENCES librarians(librarian_id) ON DELETE
    SET
        NULL,
        CONSTRAINT chk_return_date CHECK (
            return_date IS NULL
            OR return_date >= borrow_date
        )
);

CREATE TABLE fines (
    fine_id SERIAL PRIMARY KEY,
    borrow_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL CHECK (amount > 0),
    paid_status VARCHAR(20) DEFAULT 'Unpaid' CHECK (paid_status IN ('Paid', 'Unpaid', 'Waived')),
    issued_date DATE DEFAULT CURRENT_DATE,
    paid_date DATE,
    CONSTRAINT fk_fine_borrow FOREIGN KEY (borrow_id) REFERENCES borrow_records(borrow_id) ON DELETE CASCADE
);

CREATE TABLE audit_log (
    audit_id SERIAL PRIMARY KEY,
    table_name TEXT,
    operation TEXT,
    changed_by TEXT,
    change_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    old_data JSONB,
    new_data JSONB
)