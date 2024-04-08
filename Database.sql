CREATE DATABASE BookHaven;
USE BookHaven;

CREATE TABLE Book (
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    genre VARCHAR(255),
    price DECIMAL(10, 2),
    quantity INT DEFAULT 0
);

CREATE TABLE Customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address VARCHAR(255)
);

CREATE TABLE Transaction (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    total_amount DECIMAL(10, 2),
    transaction_date DATE,
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE BookTransaction (
    book_id INT,
    transaction_id INT,
    quantity INT,
    PRIMARY KEY (book_id, transaction_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id),
    FOREIGN KEY (transaction_id) REFERENCES Transaction(transaction_id)
);

INSERT INTO Book (title, author, genre, price, quantity) VALUES
('The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 10.99, 50),
('To Kill a Mockingbird', 'Harper Lee', 'Classic', 12.50, 30),
('Harry Potter and the Sorcerer''s Stone', 'J.K. Rowling', 'Fantasy', 15.99, 40);

INSERT INTO Customer (first_name, last_name, email, phone, address) VALUES
('John', 'Doe', 'johndoe@example.com', '123-456-7890', '123 Main St'),
('Jane', 'Smith', 'janesmith@example.com', '987-654-3210', '456 Elm St');

INSERT INTO Transaction (customer_id, total_amount, transaction_date) VALUES
(1, 32.97, '2024-04-10'),
(2, 15.99, '2024-04-11');

INSERT INTO BookTransaction (book_id, transaction_id, quantity) VALUES
(1, 1, 2),
(2, 1, 1),
(3, 2, 1);

-- Select querieq

-- Display the list of ALL Books in the system
SELECT * FROM Book;

-- Display the list of ALL Customers in the system
SELECT * FROM Customer;

-- Display the list of ALL Transactions
SELECT * FROM `Transaction`;

-- Display the list of ALL Book-Transaction entries
SELECT * FROM BookTransaction;

-- Display the list of ALL Transactions with the associated Customer information
SELECT t.transaction_id, c.first_name, c.last_name, t.total_amount, t.transaction_date
FROM Transaction t
JOIN Customer c ON t.customer_id = c.customer_id;

-- Display the list of ALL Books purchased in a specific Transaction
SELECT b.title, b.author, b.genre, bt.quantity
FROM BookTransaction bt
JOIN Book b ON bt.book_id = b.book_id
WHERE bt.transaction_id = 1; -- Change the transaction_id as needed

-- Display the list of ALL Transactions for a specific Customer
SELECT t.transaction_id, t.total_amount, t.transaction_date
FROM Transaction t
WHERE t.customer_id = 1; -- Change the customer_id as needed

-- Display the list of ALL Customers who have made Transactions
SELECT c.customer_id, c.first_name, c.last_name, COUNT(t.transaction_id) AS transaction_count
FROM Customer c
LEFT JOIN Transaction t ON c.customer_id = t.customer_id
GROUP BY c.customer_id;

-- Display the list of ALL Books with their remaining quantity
SELECT b.title, b.author, b.genre, b.quantity
FROM Book b;

-- Display the list of ALL Books in a specific genre
SELECT * FROM Book WHERE genre = 'Fantasy'; -- Change the genre as needed
