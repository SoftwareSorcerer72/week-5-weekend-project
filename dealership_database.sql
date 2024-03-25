-- create salesperson table
CREATE TABLE salesperson (
    salesperson_id INT PRIMARY KEY,
    Name VARCHAR(100),
    phone VARCHAR(20)
);

-- create customer table
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    Name VARCHAR(100),
    phone VARCHAR(20)
);

-- create car table
CREATE TABLE car (
    car_id INT PRIMARY KEY,
    make VARCHAR(50),
    model VARCHAR(50),
    Year INT,
    Type VARCHAR(20)  -- new or used
);

-- create invoice table
CREATE TABLE invoice (
    invoice_id INT PRIMARY KEY,
    Date DATE,
    amount DECIMAL(10, 2),
    salesperson_id INT,
    customer_id INT,
    car_id INT,
    service_flag BOOLEAN,  -- FALSE for sale & TRUE for service
    FOREIGN KEY (salesperson_id) REFERENCES salesperson(salesperson_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (car_id) REFERENCES car(car_id)
);


-- add a salesperson
INSERT INTO salesperson (salesperson_id, Name, phone) 
VALUES (1, 'George Washington', '555-1234');

SELECT *
FROM salesperson;

-- add a Customer
INSERT INTO customer (customer_id, Name, Phone) 
VALUES (1, 'John Jameson', '555-5678');

SELECT *
FROM customer;
-- Add a Car
INSERT INTO car (car_id, make, model, Year, Type) 
VALUES (1, 'Toyota', 'Camry', 2021, 'New');

SELECT * 
FROM car;
-- Add an Invoice for a Car Sale
INSERT INTO invoice (invoice_id, Date, amount, salesperson_id, customer_id, car_id, service_flag) 
VALUES (1, '2024-03-25', 30000, 1, 1, 1, FALSE);

-- Add an Invoice for a Car Service
INSERT INTO invoice (invoice_id, Date, amount, salesperson_id, customer_id, car_id, service_flag) 
VALUES (2, '2024-03-26', 500, 1, 1, 1, TRUE);

SELECT *
FROM invoice;