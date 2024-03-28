CREATE OR REPLACE PROCEDURE add_salesperson(   -- ADD a salesperson TO the salesperson table
    p_name VARCHAR(50),
    p_phone VARCHAR(20)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO salesperson (name, phone) VALUES (p_name, p_phone);
END;
$$;


CALL add_salesperson('Alice Johnson', '555-0101');       -- Calls the Procedure

CALL add_salesperson('John Cena', '456-2105');

CALL add_salesperson('Eric Bumgardner', '456-2105');



CREATE OR REPLACE PROCEDURE add_mechanic(        -- ADD a mechanic TO the mechanic table
    p_name VARCHAR(50),
    p_specialization VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO mechanic (name, specialization) VALUES (p_name, p_specialization);
END;
$$;

CALL add_mechanic('Bob Smith', 'Engine Repair');

CALL add_mechanic('Sob Bmith', 'Engine Dis-repair');

CALL add_mechanic('Steve Shmidt', 'Tire Rotation');




CREATE OR REPLACE PROCEDURE add_sales_invoice(   -- Adds a n invoice WITH a salesperson TO the TABLE AND flags service boolean FALSE 
    p_salesperson_id INT,
    p_customer_name VARCHAR(50),
    p_customer_phone VARCHAR(20),
    p_car_make VARCHAR(50),
    p_car_model VARCHAR(50),
    p_car_year INT,
    p_car_type VARCHAR(20),
    p_invoice_date DATE,
    p_invoice_amount DECIMAL(10, 2)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_customer_id INT;
    v_car_id INT;
BEGIN
    -- Check if customer exists, if not, insert a new customer
    SELECT customer_id INTO v_customer_id FROM customer WHERE name = p_customer_name AND phone = p_customer_phone;
    IF v_customer_id IS NULL THEN
        INSERT INTO customer (name, phone) VALUES (p_customer_name, p_customer_phone) RETURNING customer_id INTO v_customer_id;
    END IF;
    
    -- Check if car exists, if not, insert a new car
    SELECT car_id INTO v_car_id FROM car WHERE make = p_car_make AND model = p_car_model AND year = p_car_year AND type = p_car_type;
    IF v_car_id IS NULL THEN
        INSERT INTO car (make, model, year, type) VALUES (p_car_make, p_car_model, p_car_year, p_car_type) RETURNING car_id INTO v_car_id;
    END IF;
    
    -- Insert a new sales invoice
    INSERT INTO invoice (date, amount, salesperson_id, customer_id, car_id, service_flag)
    VALUES (p_invoice_date, p_invoice_amount, p_salesperson_id, v_customer_id, v_car_id, FALSE);
END;
$$;



CALL add_sales_invoice(          -- Calls the ADD invoice procedure associated WITH a salesperson
    1,                  -- Salesperson ID
    'John Doe',         -- Customer Name
    '555-6789',         -- Customer Phone
    'Toyota',           -- Car Make
    'Camry',            -- Car Model
    2022,               -- Car Year
    'New',              -- Car Type
    '2024-03-30',       -- Invoice Date
    25000.00            -- Invoice Amount
);






CREATE OR REPLACE PROCEDURE add_service_invoice(  --Adds an invoice assoicated WITH a mechanic AND flags the service boolean AS TRUE 
    p_mechanic_id INT,
    p_customer_name VARCHAR(50),
    p_customer_phone VARCHAR(20),
    p_car_make VARCHAR(50),
    p_car_model VARCHAR(50),
    p_car_year INT,
    p_car_type VARCHAR(20),
    p_invoice_date DATE,
    p_invoice_amount DECIMAL(10, 2)
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_customer_id INT;
    v_car_id INT;
BEGIN
    -- Check if customer exists, if not, insert a new customer
    SELECT customer_id INTO v_customer_id FROM customer WHERE name = p_customer_name AND phone = p_customer_phone;
    IF v_customer_id IS NULL THEN
        INSERT INTO customer (name, phone) VALUES (p_customer_name, p_customer_phone) RETURNING customer_id INTO v_customer_id;
    END IF;
    
    -- Check if car exists, if not, insert a new car
    SELECT car_id INTO v_car_id FROM car WHERE make = p_car_make AND model = p_car_model AND year = p_car_year AND type = p_car_type;
    IF v_car_id IS NULL THEN
        INSERT INTO car (make, model, year, type) VALUES (p_car_make, p_car_model, p_car_year, p_car_type) RETURNING car_id INTO v_car_id;
    END IF;
    
    -- Insert a new service invoice
    INSERT INTO invoice (date, amount, mechanic_id, customer_id, car_id, service_flag)
    VALUES (p_invoice_date, p_invoice_amount, p_mechanic_id, v_customer_id, v_car_id, TRUE);
END;
$$;




CALL add_service_invoice(            -- Calls the ADD invoice PROCEDURE associated WITH the mechanic table
    1,                  -- Mechanic ID
    'Jane Smith',       -- Customer Name
    '555-1234',         -- Customer Phone
    'Honda',            -- Car Make
    'Civic',            -- Car Model
    2021,               -- Car Year
    'Used',             -- Car Type
    '2024-03-30',       -- Invoice Date
    500.00              -- Invoice Amount
);


select *
FROM invoice;

SELECT *
FROM mechanic;


CREATE OR REPLACE PROCEDURE update_mechanic(  -- UPDATE mechanic info
    p_mechanic_id INT,
    p_name VARCHAR(50),
    p_specialization VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE mechanic
    SET name = p_name, specialization = p_specialization
    WHERE mechanic_id = p_mechanic_id;
END;
$$;

CALL update_mechanic(
    1,                  -- Mechanic ID to update
    'John Doe',         -- New Name for the Mechanic
    'Transmission Specialist'  -- New Specialization for the Mechanic
);



CREATE OR REPLACE PROCEDURE update_salesperson(  -- UPDATE sales person info
    p_salesperson_id INT,
    p_name VARCHAR(50),
    p_phone VARCHAR(20)
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE salesperson
    SET name = p_name, phone = p_phone
    WHERE salesperson_id = p_salesperson_id;
END;
$$;


CALL update_salesperson(
    1,                  -- Salesperson ID to update
    'Jane Doe',         -- New Name for the Salesperson
    '555-9999'          -- New Phone Number for the Salesperson
);



CREATE OR REPLACE PROCEDURE update_car(  -- UPDATE Car info
    p_car_id INT,
    p_make VARCHAR(50),
    p_model VARCHAR(50),
    p_year INT,
    p_type VARCHAR(20)
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE car
    SET make = p_make, model = p_model, year = p_year, type = p_type
    WHERE car_id = p_car_id;
END;
$$;



CALL update_car(
    1,                  -- Car ID to update
    'Toyota',           -- New Make for the Car
    'Corolla',          -- New Model for the Car
    2022,               -- New Year for the Car
    'Used'              -- New Type for the Car ('New' or 'Used')
);



CREATE OR REPLACE PROCEDURE update_customer( -- UPDATE Customer Info
    p_customer_id INT,
    p_name VARCHAR(50),
    p_phone VARCHAR(20)
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE customer
    SET name = p_name, phone = p_phone
    WHERE customer_id = p_customer_id;
END;
$$;


CALL update_customer(
    1,                  -- Customer ID to update
    'Alice Johnson',    -- New Name for the Customer
    '555-0101'          -- New Phone Number for the Customer
);




CREATE OR REPLACE PROCEDURE update_invoice( -- UPDATE Cnvoice info
    p_invoice_id INT,
    p_date DATE,
    p_amount DECIMAL(10, 2)
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE invoice
    SET date = p_date, amount = p_amount
    WHERE invoice_id = p_invoice_id;
END;
$$;



CALL update_invoice(
    1,                  -- Invoice ID to update
    '2024-04-01',       -- New Date for the Invoice
    1500.00             -- New Amount for the Invoice
);
