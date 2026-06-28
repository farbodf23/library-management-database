# Library Management Database

A relational database project developed in PostgreSQL that simulates a real-world library management system.

The project was created to practice advanced database concepts including schema design, normalization, stored procedures, transactions, triggers, indexing, and query optimization.

---

## Features

- Relational database design
- Third Normal Form (3NF)
- Primary and Foreign Keys
- Data validation using CHECK constraints
- Stored Procedures
- Transactions
- Triggers
- Indexing
- Borrowing and returning books
- Fine management
- Member activation and suspension
- Audit logging

---

## Technologies

- PostgreSQL
- SQL
- PL/pgSQL

---

## Project Structure

```
Library-Management-Database/

│── schema.sql
│── seed_data.sql
│── queries.sql
│── procedures.sql
│── transactions.sql
│── triggers.sql
│── indexes.sql
│── README.md
```

---

## Database Schema

The database contains the following entities:

- Categories
- Publishers
- Books
- Authors
- Book Authors (Many-to-Many)
- Members
- Librarians
- Borrow Records
- Fines
- Audit Log

Relationships include:

- One category → Many books
- One publisher → Many books
- Many books ↔ Many authors
- One member → Many borrow records
- One librarian → Many borrow records
- One borrow record → Zero or one fine

---

## Database Concepts Demonstrated

### Relational Design

The project uses normalized tables connected through foreign keys to eliminate redundancy and maintain data integrity.

### Constraints

Examples include:

- PRIMARY KEY
- FOREIGN KEY
- UNIQUE
- NOT NULL
- CHECK

These constraints ensure invalid data cannot be inserted into the database.

---

## Stored Procedures

The project implements business logic using PostgreSQL stored procedures.

### borrow_book()

- Validates member status
- Checks book availability
- Creates borrow record
- Updates available copies

### return_book()

- Returns a borrowed book
- Updates book inventory
- Calculates overdue fines
- Prevents duplicate fines

### pay_fine()

Marks an unpaid fine as paid.

### waive_fine()

Marks an unpaid fine as waived.

### suspend_member()

Suspends members only when:

- they exist
- they are active
- they have no active borrow records

### activate_member()

Reactivates suspended members only if all outstanding fines have been resolved.

---

## Transactions

The project demonstrates ACID transactions.

Examples include:

- Borrowing a book
- Returning a book

Each transaction updates multiple tables while preserving database consistency.

---

## Triggers

### Automatic Overdue Detection

A trigger automatically updates the borrow status to **Overdue** whenever a borrow record passes its due date without being returned.

### Audit Logging

Changes to the Members table are automatically recorded in the Audit Log.

The following operations are logged:

- INSERT
- UPDATE
- DELETE

Stored information includes:

- timestamp
- current database user
- previous values
- updated values

---

## Indexes

Several indexes have been created to improve query performance.

### idx_borrow_member_active

Optimizes:

- Active borrow lookups
- Borrow history
- Current loans

### idx_books_isbn

Optimizes:

- ISBN searches
- Duplicate ISBN validation

### idx_members_email

Optimizes:

- Member lookup by email

(Note: PostgreSQL automatically creates an index for UNIQUE columns. This index is included for educational purposes.)

---

## Learning Objectives

This project demonstrates practical knowledge of:

- Relational database design
- SQL
- PL/pgSQL
- Database normalization
- Transaction management
- Business logic implementation
- Database automation using triggers
- Query optimization using indexes

---

## Future Improvements

Possible extensions include:

- Reservation system
- Multi-branch library support
- Role-based permissions
- Full-text search
- REST API integration
- Web interface
- Reporting dashboard

---

## License

This project is intended for educational purposes.
