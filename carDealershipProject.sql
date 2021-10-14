-- Salesperson table
CREATE TABLE salesperson(
	employee_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);

-- Customer table
CREATE TABLE customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100),
	last_name VARCHAR(100)
);

-- Vehicles table
CREATE TABLE vehicles(
	vehicle_id SERIAL PRIMARY KEY,
	make VARCHAR(50),
	model VARCHAR(50)
);

-- Mechanics table
CREATE TABLE mechanics(
	mechanic_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50)
);

-- Sales Invoice table
CREATE TABLE sales_invoice(
	sales_id SERIAL PRIMARY KEY,
	amount NUMERIC(8,2),
	employee_id INTEGER NOT NULL,
	customer_id INTEGER NOT NULL,
	vehicle_id INTEGER NOT NULL,
	FOREIGN KEY(employee_id) REFERENCES salesperson(employee_id),
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY(vehicle_id) REFERENCES vehicles(vehicle_id)
);

-- Service Ticket table
CREATE TABLE service_ticket(
	service_id SERIAL PRIMARY KEY,
	amount NUMERIC(8,2),
	customer_id INTEGER NOT NULL,
	mechanic_id INTEGER NOT NULL,
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id),
	FOREIGN KEY(mechanic_id) REFERENCES mechanics(mechanic_id)
);

-- Parts table
CREATE TABLE parts(
	part_id SERIAL PRIMARY KEY,
	part_name VARCHAR(100),
	part_price NUMERIC(8,2),
	service_id INTEGER NOT NULL,
	FOREIGN KEY(service_id) REFERENCES service_ticket(service_id)
);

-- Car Dealership table
CREATE TABLE car_dealership(
	service_id INTEGER,
	sales_id INTEGER,
	FOREIGN KEY(service_id) REFERENCES service_ticket(service_id),
	FOREIGN KEY(sales_id) REFERENCES sales_invoice(sales_id)
);


-- SALESPERSON data
INSERT INTO salesperson(
	employee_id,
	first_name,
	last_name
)VALUES(
	1,
	'Aaron',
	'Wieldraayer'
);
INSERT INTO salesperson(
	employee_id,
	first_name,
	last_name
)VALUES(
	2,
	'Max',
	'Verstappen'
);
INSERT INTO salesperson(
	employee_id,
	first_name,
	last_name
)VALUES(
	3,
	'Lewis',
	'Hamilton'
);

-- CUSTOMER data
INSERT INTO customer(
	customer_id,
	first_name,
	last_name
)VALUES(
	1,
	'Floyd',
	'Mayweather'
);
INSERT INTO customer(
	customer_id,
	first_name,
	last_name
)VALUES(
	2,
	'The',
	'Rock'
);
INSERT INTO customer(
	customer_id,
	first_name,
	last_name
)VALUES(
	3,
	'Hillary',
	'Clinton'
);

-- VEHICLES data
INSERT INTO vehicles(
	vehicle_id,
	make,
	model
)VALUES(
	1,
	'Honda',
	'CRV'
);
INSERT INTO vehicles(
	vehicle_id,
	make,
	model
)VALUES(
	2,
	'Toyota',
	'Corolla'
);
INSERT INTO vehicles(
	vehicle_id,
	make,
	model
)VALUES(
	3,
	'Chevrolet',
	'Blazer'
);

-- MECHANICS data
INSERT INTO mechanics(
	mechanic_id,
	first_name,
	last_name
)VALUES(
	1,
	'Lionel',
	'Maradona'
);
INSERT INTO mechanics(
	mechanic_id,
	first_name,
	last_name
)VALUES(
	2,
	'James',
	'Cameron'
);

-- SALES INVOICE data
INSERT INTO sales_invoice(
	sales_id,
	amount,
	employee_id,
	customer_id,
	vehicle_id
)VALUES(
	1,
	25000.00,
	2,
	1,
	2
);
INSERT INTO sales_invoice(
	sales_id,
	amount,
	employee_id,
	customer_id,
	vehicle_id
)VALUES(
	2,
	3000.00,
	1,
	2,
	1
);
INSERT INTO sales_invoice(
	sales_id,
	amount,
	employee_id,
	customer_id,
	vehicle_id
)VALUES(
	3,
	14999.99,
	1,
	3,
	3
);


-- SERVICE TICKET data
INSERT INTO service_ticket(
	service_id,
	amount,
	customer_id,
	mechanic_id
)VALUES(
	1,
	147.68,
	1,
	1
);
INSERT INTO service_ticket(
	service_id,
	amount,
	customer_id,
	mechanic_id
)VALUES(
	2,
	65.00,
	2,
	2
);
INSERT INTO service_ticket(
	service_id,
	amount,
	customer_id,
	mechanic_id
)VALUES(
	3,
	4987.56,
	3,
	1
);

-- PARTS data
INSERT INTO parts(
	part_id,
	part_name,
	part_price,
	service_id
)VALUES(
	1,
	'Spark Plugs',
	99.99,
	1
);
INSERT INTO parts(
	part_id,
	part_name,
	part_price,
	service_id
)VALUES(
	2,
	'New Engine',
	4000.00,
	3
);

-- CAR DEALERSHIP data
INSERT INTO car_dealership(
	service_id,
	sales_id
)VALUES(
	1,
	1
);
INSERT INTO car_dealership(
	service_id,
	sales_id
)VALUES(
	2,
	2
);
INSERT INTO car_dealership(
	service_id,
	sales_id
)VALUES(
	3,
	3
);

-- Add data with STORED FUNCTIONS
CREATE OR REPLACE FUNCTION add_vehicle(_vehicle_id INTEGER, _make VARCHAR, _model VARCHAR)
RETURNS void 
AS $MAIN$
BEGIN
	INSERT INTO vehicles(vehicle_id, make, model)
	VALUES(_vehicle_id, _make, _model);
END;
$MAIN$
LANGUAGE plpgsql;
SELECT add_vehicle(4, 'Ford', 'Mustang');

CREATE OR REPLACE FUNCTION add_customer(_customer_id INTEGER, _first_name VARCHAR, _last_name VARCHAR)
RETURNS void 
AS $MAIN$
BEGIN
	INSERT INTO customer(customer_id, first_name, last_name)
	VALUES(_customer_id, _first_name, _last_name);
END;
$MAIN$
LANGUAGE plpgsql;
SELECT add_customer(4, 'Jeff', 'Bezos');
SELECT add_customer(5, 'Danny', 'DeVito');
