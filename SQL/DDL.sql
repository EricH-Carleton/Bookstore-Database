CREATE TABLE user
	(U_ID 				SERIAL UNIQUE,
	 first_name		VARCHAR(20) NOT NULL,
	 surname			VARCHAR(20) NOT NULL,
	 email				VARCHAR(50) NOT NULL,
	 A_ID					INT NOT NULL,
	 PRIMARY KEY (U_ID),
	 FOREIGN KEY (A_ID) REFERENCES address
	);
	
CREATE TABLE cart
	(C_ID 				SERIAL UNIQUE,
	 U_ID					INT NOT NULL,
	 PRIMARY KEY (C_ID),
	 FOREIGN KEY (U_ID) REFERENCES user
	);
	
CREATE TABLE book
	(ISBN 							NUMERIC(13,0) UNIQUE NOT NULL,
	 title							VARCHAR(200) NOT NULL,
	 author							VARCHAR(50),
	 genre							VARCHAR(50),
	 price							NUMERIC(6,2) check (price >= 0) default 0,
	 page_number				NUMERIC(5,0) check (page_number >= 0) default 0,
	 stock							NUMERIC(5,0) check (stock >= 0) default 0,
	 commission					NUMERIC(3,2) check (commission >= 0) default 0,
	 expenditures				NUMERIC(5,2) check (expenditures >= 0) default 0,
	 restock_threshold	NUMERIC(3,0) check (price >= 0) default 0,
	 P_ID								INT NOT NULL,
	 PRIMARY KEY (ISBN),
	 FOREIGN KEY (P_ID) REFERENCES publisher
	);

CREATE TABLE publisher
	(P_ID 						SERIAL UNIQUE,
	 first_name				VARCHAR(20) NOT NULL,
	 surname					VARCHAR(20) NOT NULL,
	 email						VARCHAR(50) NOT NULL,
	 banking_account	NUMERIC(25,0) NOT NULL,
	 A_ID							INT NOT NULL,
	 PRIMARY KEY (P_ID),
	 FOREIGN KEY (A_ID) REFERENCES address
	);	
	
CREATE TABLE pub_phone
	(P_ID 						INT NOT NULL,
	 phone_number			VARCHAR(12) NOT NULL,
	 PRIMARY KEY (P_ID,phone_number),
	 FOREIGN KEY (P_ID) REFERENCES publisher
	);
	
CREATE TABLE order
	(O_ID 							SERIAL UNIQUE,
	 year								NUMERIC(4,0) default 2020,
	 month							NUMERIC(2,0) check (month >= 1 AND month <= 12 ) default 1,
	 day								NUMERIC(2,0) check (day >= 1 AND day <= 31 ) default 1,
	 shipping_status		VARCHAR(255),
	 C_ID								INT NOT NULL,
	 billing_A_ID				INT NOT NULL,
	 shipping_A_ID			INT NOT NULL,
	 PRIMARY KEY (O_ID),
	 FOREIGN KEY (billing_A_ID) REFERENCES address (P_ID),
	 FOREIGN KEY (shipping_A_ID) REFERENCES address (P_ID),
	);

CREATE TABLE address
	(A_ID							SERIAL UNIQUE,
	 street_number		NUMERIC(8,0) NOT NULL,
	 street_name			VARCHAR(100) NOT NULL,
	 apt_number				VARCHAR(6),
	 city							VARCHAR(50) NOT NULL,
	 province					VARCHAR(50) NOT NULL,
	 PRIMARY KEY (A_ID),
	);

CREATE TABLE postal
	(street_number		NUMERIC(8,0) NOT NULL,
	 street_name			VARCHAR(100) NOT NULL,
	 city							VARCHAR(50) NOT NULL,
	 province					VARCHAR(50) NOT NULL,
	 postal_code			VARCHAR(6) NOT NULL,
	 PRIMARY KEY (street_number, street_name, city, province),
	);
	
CREATE TABLE add_to_cart
	(C_ID 			INT NOT NULL,
	 ISBN				NUMERIC(13,0) NOT NULL,
	 quantity 	NUMERIC(3,0) check (quantity >= 1) default 1,
	 PRIMARY KEY (C_ID, ISBN),
	 FOREIGN KEY (C_ID) REFERENCES cart,
	 FOREIGN KEY (ISBN) REFERENCES book,