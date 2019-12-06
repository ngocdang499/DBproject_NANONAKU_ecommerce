--USE Ass
--GO

CREATE TABLE author
(
	id			INT PRIMARY KEY,
	_name		VARCHAR(30) NOT NULL,
	bdate		DATE,
	intro		VARCHAR(100),
	country		VARCHAR(20)
);

CREATE TABLE write
(
	id_author	INT,
	id_book		INT,
	PRIMARY KEY (id_author, id_book)
);

CREATE TABLE book
(
	id			INT PRIMARY KEY,
	_name		VARCHAR(30) NOT NULL,
	num_page	INT,
	page_size	VARCHAR(30),
	intro		VARCHAR(100),
	sale_price	DECIMAL(10,2),
	kind		INT		
);



CREATE TABLE publish
(
	id_publisher	INT,
	id_book			INT,
	edition			INT,
	PRIMARY KEY (id_publisher, id_book)
);



CREATE TABLE Publisher
(
	id			INT PRIMARY KEY,
	_name	VARCHAR(30) NOT NULL,
	phone		VARCHAR(11) NOT NULL,
	intro		VARCHAR(100),
	pub_address VARCHAR(30)
);

CREATE TABLE Product
(
	id			INT PRIMARY KEY,
	price		DECIMAL(10,2) NOT NULL
);

CREATE TABLE image_prod
(
	id_product	INT,
	image_pro	VARCHAR,
	PRIMARY KEY (id_product, image_pro)
);



CREATE TABLE otherProduct
(
	id_product	INT PRIMARY KEY,
	_name		VARCHAR(30) NOT NULL,
	id_type		INT NOT NULL,
	id_producer	INT
);



CREATE TABLE typeProduct
(
	id			INT PRIMARY KEY,
	name_type	VARCHAR(30) NOT NULL
);

CREATE TABLE producer
(
	id				INT PRIMARY KEY,
	name_producer	VARCHAR(30) NOT NULL
);

CREATE TABLE supplier
(
	id			INT PRIMARY KEY,
	_name	VARCHAR(30) NOT NULL,
	phone		VARCHAR(10) NOT NULL,
	sup_address	VARCHAR(30) NOT NULL,
	email		VARCHAR(30)
);

CREATE TABLE warehouse
(
	id				INT PRIMARY KEY,
	_name		VARCHAR(30) NOT NULL,
	ware_address	VARCHAR(30) NOT NULL,
	phone			VARCHAR(10) NOT NULL,
);


CREATE TABLE supply
(
	id_product		INT,
	id_warehouse	INT,
	id_supplier		INT,
	amount			INT NOT NULL,
	price			INT NOT NULL,
	PRIMARY KEY (id_product, id_warehouse, id_supplier)
);


CREATE TABLE trans_company
(
	id			INT PRIMARY KEY,
	_name		VARCHAR(20) NOT NULL,
	_address	VARCHAR(30) NOT NULL,
	phone		VARCHAR(10) NOT NULL,
);

CREATE TABLE order_product
(
	id_product	INT,
	id_order	INT,
	amount		INT NOT NULL,
	price		DECIMAL(10,2) NOT NULL,
	PRIMARY KEY (id_product, id_order)
);




CREATE TABLE _order
(
	id					INT PRIMARY KEY,
	_address			VARCHAR(30),
	id_employ			INT NOT NULL,
	id_trans_company	INT NOT NULL,
	id_cart				INT NOT NULL,
	delivery_date		DATE NOT NULL,
	order_date			DATE NOT NULL,
	payment				VARCHAR(20) NOT NULL,
	der_status			VARCHAR(1) NOT NULL,
	stt					INT NOT NULL
);




CREATE TABLE _apply
(
	id_service	INT,
	id_order	INT,
	PRIMARY KEY (id_service, id_order)
);



CREATE TABLE _service
(
	id			INT PRIMARY KEY,
	price		INT NOT NULL,
	duration	DATE NOT NULL
);

CREATE TABLE refund
(
	id_service		INT PRIMARY KEY,
	return_percent	INT NOT NULL
);



CREATE TABLE fast_deliver
(
	id_service	INT PRIMARY KEY,
	_address	VARCHAR(30) NOT NULL
);



CREATE TABLE book_care
(
	id_service	INT PRIMARY KEY,
	amount		INT NOT NULL
);



CREATE TABLE employee
(
	id			INT PRIMARY KEY,
	_name		VARCHAR(30) NOT NULL,
	_address	VARCHAR(30) NOT NULL,
	email		VARCHAR(30),
	phone		VARCHAR(10) NOT NULL,
	mgrid		INT NOT NULL,
);




CREATE TABLE account
(
	id		INT PRIMARY KEY,
	name		VARCHAR(30) NOT NULL,
	password	VARCHAR(30) NOT NULL
);

CREATE TABLE cart
(
	u_id		INT, 
	stt			INT,
	PRIMARY KEY (u_id, stt)
);




CREATE TABLE cart_product
(
	id_product		INT,
	u_id			INT,
	stt				INT,
	amount			INT NOT NULL,
	PRIMARY KEY (id_product, u_id, stt)
);



CREATE TABLE member
(
	u_id		INT PRIMARY KEY
);


				
CREATE TABLE vip
(
	u_id			INT PRIMARY KEY,
	percent_sale	INT,
	duration		DATE
);



CREATE TABLE customer
(	id			INT PRIMARY KEY,
	fname		VARCHAR(15)	NOT NULL,						
	lname		VARCHAR(15)	NOT NULL,
	phone		VARCHAR(11),
	email		VARCHAR(50),
	bdate		DATE,
	facebook	VARCHAR(50),
	col_point	INT
);

				
CREATE TABLE address_user
(	
	id_customer	INT			NOT NULL,
	address_cus	VARCHAR(15)	NOT NULL,
	PRIMARY KEY	(id_customer, address_cus)
);

CREATE TABLE book_type
(
	id_book	INT PRIMARY KEY,
	type	VARCHAR(20)
);

-----constraint------
ALTER TABLE write
ADD CONSTRAINT fk_idauthor_author FOREIGN KEY (id_author)
			   REFERENCES author(id),
	CONSTRAINT fk_id_book_write_book FOREIGN KEY (id_book)
				REFERENCES book(id)

-----constraint------
ALTER TABLE book
ADD CONSTRAINT fk_id_product FOREIGN KEY (id)
				REFERENCES product(id)

-----constraint------
ALTER TABLE publish	
ADD CONSTRAINT fk_id_publisher_publisher FOREIGN KEY (id_publisher)
				REFERENCES publisher(id),
	CONSTRAINT fk_id_book_publish_book FOREIGN KEY (id_book)
				REFERENCES book(id)

-----constraint------
ALTER TABLE image_prod
ADD CONSTRAINT fk_id_image_product_product FOREIGN KEY (id_product)
				REFERENCES product(id)

-----constraint------
ALTER TABLE otherProduct
ADD CONSTRAINT fk_id_other_product_product FOREIGN KEY (id_product)
				REFERENCES Product(id),
	CONSTRAINT fk_id_type_typeProduct FOREIGN KEY (id_type)
				REFERENCES typeProduct(id),
	CONSTRAINT fk_id_producer_producer FOREIGN KEY (id_producer)
				REFERENCES producer(id)

-----constraint------
ALTER TABLE supply
ADD CONSTRAINT fk_id_product_supply_product FOREIGN KEY (id_product)
				REFERENCES product(id),
	CONSTRAINT fk_id_warehouse_warehouse FOREIGN KEY (id_warehouse)
				REFERENCES warehouse(id),
	CONSTRAINT fk_id_supplier_supplier FOREIGN KEY (id_supplier)
				REFERENCES supplier(id)

-----constraint------
ALTER TABLE order_product
ADD CONSTRAINT fk_id_product_order_product_product FOREIGN KEY (id_product)
				REFERENCES product(id),
	CONSTRAINT fk_id_order_order_product_product FOREIGN KEY (id_order)
				REFERENCES _order(id)

-----constraint------
ALTER TABLE _order
ADD CONSTRAINT fk_id_trans_company_trans_company FOREIGN KEY (id_trans_company)
				REFERENCES trans_company(id),
	CONSTRAINT fk_id_employ_order_employee FOREIGN KEY (id_employ)
				REFERENCES employee(id),
	CONSTRAINT fk_id_cart_order_cart FOREIGN KEY (id_cart, stt)
				REFERENCES cart(u_id, stt)
--	CONSTRAINT fk_stt_order_cart FOREIGN KEY (stt)
--				REFERENCES cart(stt)

-----constraint------
ALTER TABLE _apply
ADD CONSTRAINT fk_id_service_service FOREIGN KEY (id_service)
				REFERENCES _service(id),
	CONSTRAINT fk_id_order_order FOREIGN KEY (id_order)
				REFERENCES _order(id)

-----constraint------
ALTER TABLE refund
ADD CONSTRAINT fk_id_service_refund_service FOREIGN KEY (id_service)
				REFERENCES _service(id)

-----constraint------
ALTER TABLE fast_deliver 
ADD CONSTRAINT fk_id_service_fast_deliver_service FOREIGN KEY (id_service)
				REFERENCES _service(id)

-----constraint------
ALTER TABLE book_care
ADD CONSTRAINT fk_id_service_book_care_service FOREIGN KEY (id_service)
				REFERENCES _service(id)

-----constraint------
ALTER TABLE employee
ADD CONSTRAINT fk_mgrid_employee_employee FOREIGN KEY (mgrid)
				REFERENCES employee(id),
	CONSTRAINT fk_id_employee_account FOREIGN KEY (id)
				REFERENCES account(id)

-----constraint------
ALTER TABLE cart
ADD CONSTRAINT fk_u_id_cart_customer FOREIGN KEY (u_id)
				REFERENCES customer(id)

-----constraint------
ALTER TABLE cart_product
ADD CONSTRAINT fk_id_product_product FOREIGN KEY (id_product)
				REFERENCES product(id),
	CONSTRAINT fk_u_id_cart_product_cart FOREIGN KEY (u_id, stt)
				REFERENCES cart(u_id, stt)
	--CONSTRAINT fk_stt_cart_product_cart FOREIGN KEY (stt)
		--		REFERENCES cart(stt)

-----constraint------
ALTER TABLE member
ADD CONSTRAINT fk_u_id_member_customer FOREIGN KEY (u_id)
				REFERENCES customer(id)

-----constraint------
ALTER TABLE vip
ADD CONSTRAINT fk_u_id_vip_customer FOREIGN KEY (u_id)
				REFERENCES customer(id)

-----constraint------
ALTER TABLE customer
ADD CONSTRAINT fk_id_customer_account FOREIGN KEY(id)
				REFERENCES account(id)

-----constraint------
ALTER TABLE address_user
ADD CONSTRAINT fk_id_customer_customer FOREIGN KEY (id_customer)
				REFERENCES customer(id)

-----constraint------
ALTER TABLE book_type
ADD CONSTRAINT fk_id_book_book FOREIGN KEY (id_book)
				REFERENCES book(id)


