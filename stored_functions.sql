-- add a salesperson

CREATE OR REPLACE FUNCTION add_salesperson(p_salesperson_id INT, p_Name VARCHAR, p_phone VARCHAR)
RETURNS VOID AS $$
BEGIN
    INSERT INTO salesperson (salesperson_id, Name, phone) VALUES (p_salesperson_id, p_Name, p_phone);
END;
$$ LANGUAGE plpgsql;

SELECT add_salesperson(2, 'Alexander Hamilton', '555-6789');

SELECT *
FROM salesperson;

--add a customer

CREATE OR REPLACE FUNCTION add_customer(p_customer_id INT, p_Name VARCHAR, p_phone VARCHAR)
RETURNS VOID AS $$
BEGIN
    INSERT INTO customer (customer_id, Name, phone) VALUES (p_customer_id, p_Name, p_phone);
END;
$$ LANGUAGE plpgsql;

SELECT add_customer(2, 'James Madison', '555-7890');


SELECT *
FROM customer;

-- add a car

CREATE OR REPLACE FUNCTION add_car(
    p_car_id INT, 
    p_make VARCHAR, 
    p_model VARCHAR, 
    p_Year INT, 
    p_Type VARCHAR  -- 'New' or 'Used'
)
RETURNS VOID AS $$
BEGIN
    INSERT INTO car (car_id, make, model, Year, Type) 
    VALUES (p_car_id, p_make, p_model, p_Year, p_Type);
END;
$$ LANGUAGE plpgsql;

SELECT add_car(2, 'Honda', 'Civic', 2022, 'New');

SELECT *
FROM car;


