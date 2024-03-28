CREATE TABLE salesperson (            -- Makes the Salesperson Table
    salesperson_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    phone VARCHAR(20)
);

CREATE TABLE mechanic (               -- Makes the Mechanic Table
    mechanic_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    specialization VARCHAR(100)
);

CREATE TABLE customer (                  -- Makes the Customer Table
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    phone VARCHAR(20)
);


CREATE TABLE car (                      -- Makes the Car Table    
    car_id SERIAL PRIMARY KEY,
    make VARCHAR(50),
    model VARCHAR(50),
    year INT,
    type VARCHAR(20)                  --'new' or 'used'
);


CREATE TABLE invoice (                -- Makes the Invoice TABLE, which links all of the others together
    invoice_id SERIAL PRIMARY KEY,
    date DATE,
    amount DECIMAL(10, 2),
    salesperson_id INT,
    customer_id INT,
    car_id INT,
    service_flag BOOLEAN,
    mechanic_id INT,
    FOREIGN KEY (salesperson_id) REFERENCES salesperson(salesperson_id),  -- FOREIGN KEY TO salesperson table
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),           -- FOREIGN KEY TO customer table
    FOREIGN KEY (car_id) REFERENCES car(car_id),                          -- FOREIGN KEY TO car table
    FOREIGN KEY (mechanic_id) REFERENCES mechanic(mechanic_id)            -- FOREIGN KEY TO mechanic table
);
