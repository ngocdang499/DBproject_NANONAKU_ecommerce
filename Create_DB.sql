--USE Ass
--GO

CREATE TABLE author
(
	id			VARCHAR(10) PRIMARY KEY,
	_name		VARCHAR(30) NOT NULL,
	bdate		DATE,
	intro		VARCHAR(100),
	country		VARCHAR(20)
);

CREATE TABLE write
(
	id_author	VARCHAR(10),
	id_book		VARCHAR(10),
	PRIMARY KEY (id_author, id_book)
);

CREATE TABLE book
(
	id			VARCHAR(10) PRIMARY KEY,
	_name		VARCHAR(30) NOT NULL,
	num_page	INT,
	page_size	VARCHAR(30),
	intro		VARCHAR(100),
	sale_price	DECIMAL(10,2),
	kind		INT		
);



CREATE TABLE publish
(
	id_publisher	VARCHAR(10),
	id_book			VARCHAR(10),
	edition			INT,
	PRIMARY KEY (id_publisher, id_book)
);



CREATE TABLE Publisher
(
	id			VARCHAR(10) PRIMARY KEY,
	_name	VARCHAR(30) NOT NULL,
	phone		VARCHAR(15) NOT NULL,
	intro		VARCHAR(100),
	pub_address VARCHAR(30)
);

CREATE TABLE Product
(
	id			VARCHAR(10) PRIMARY KEY,
	price		DECIMAL(10,2) NOT NULL
);

CREATE TABLE image_prod
(
	id_product	VARCHAR(10),
	image_pro	VARCHAR(200),
	PRIMARY KEY (id_product, image_pro)
);



CREATE TABLE otherProduct
(
	id_product	VARCHAR(10) PRIMARY KEY,
	_name		VARCHAR(30) NOT NULL,
	id_type		VARCHAR(10) NOT NULL,
	id_producer	VARCHAR(10)
);



CREATE TABLE typeProduct
(
	id			VARCHAR(10) PRIMARY KEY,
	name_type	VARCHAR(30) NOT NULL
);

CREATE TABLE producer
(
	id				VARCHAR(10) PRIMARY KEY,
	name_producer	VARCHAR(30) NOT NULL
);

CREATE TABLE supplier
(
	id			VARCHAR(10) PRIMARY KEY,
	_name	VARCHAR(30) NOT NULL,
	phone		VARCHAR(15) NOT NULL,
	sup_address	VARCHAR(30) NOT NULL,
	email		VARCHAR(30)
);

CREATE TABLE warehouse
(
	id				VARCHAR(10) PRIMARY KEY,
	_name		VARCHAR(30) NOT NULL,
	ware_address	VARCHAR(30) NOT NULL,
	phone			VARCHAR(15) NOT NULL,
);


CREATE TABLE supply
(
	id_product		VARCHAR(10),
	id_warehouse	VARCHAR(10),
	id_supplier		VARCHAR(10),
	amount			INT NOT NULL,
	price			INT NOT NULL,
	PRIMARY KEY (id_product, id_warehouse, id_supplier)
);


CREATE TABLE trans_company
(
	id			VARCHAR(10) PRIMARY KEY,
	_name		VARCHAR(20) NOT NULL,
	_address	VARCHAR(30) NOT NULL,
	phone		VARCHAR(15) NOT NULL,
);

CREATE TABLE order_product
(
	id_product	VARCHAR(10),
	id_order	VARCHAR(10),
	amount		INT NOT NULL,
	price		DECIMAL(10,2) NOT NULL,
	PRIMARY KEY (id_product, id_order)
);




CREATE TABLE _order
(
	id					VARCHAR(10) PRIMARY KEY,
	_address			VARCHAR(30),
	id_employ			VARCHAR(10) NOT NULL,
	id_trans_company	VARCHAR(10) NOT NULL,
	id_cart				VARCHAR(10) NOT NULL,
	delivery_date		DATE NOT NULL,
	order_date			DATE NOT NULL,
	payment				VARCHAR(20) NOT NULL,
	der_status			VARCHAR(1) NOT NULL,
	stt					INT NOT NULL
);




CREATE TABLE _apply
(
	id_service	VARCHAR(10),
	id_order	VARCHAR(10),
	PRIMARY KEY (id_service, id_order)
);



CREATE TABLE _service
(
	id			VARCHAR(10) PRIMARY KEY,
	price		INT NOT NULL,
	duration	DATE NOT NULL
);

CREATE TABLE refund
(
	id_service		VARCHAR(10) PRIMARY KEY,
	return_percent	INT NOT NULL
);



CREATE TABLE fast_deliver
(
	id_service	VARCHAR(10) PRIMARY KEY,
	_address	VARCHAR(30) NOT NULL
);



CREATE TABLE book_care
(
	id_service	VARCHAR(10) PRIMARY KEY,
	amount		INT NOT NULL
);



CREATE TABLE employee
(
	id			VARCHAR(10) PRIMARY KEY,
	_name		VARCHAR(30) NOT NULL,
	_address	VARCHAR(30) NOT NULL,
	email		VARCHAR(30),
	phone		VARCHAR(15) NOT NULL,
	mgrid		VARCHAR(10) NOT NULL,
);




CREATE TABLE account
(
	id			VARCHAR(10) PRIMARY KEY,
	name		VARCHAR(30) NOT NULL,
	password	VARCHAR(30) NOT NULL
);

CREATE TABLE cart
(
	u_id		VARCHAR(10), 
	stt			INT,
	PRIMARY KEY (u_id, stt)
);




CREATE TABLE cart_product
(
	id_product		VARCHAR(10),
	u_id			VARCHAR(10),
	stt				INT,
	amount			INT NOT NULL,
	PRIMARY KEY (id_product, u_id, stt)
);



CREATE TABLE member
(
	u_id		VARCHAR(10) PRIMARY KEY
);


				
CREATE TABLE vip
(
	u_id			VARCHAR(10) PRIMARY KEY,
	percent_sale	INT,
	duration		DATE
);



CREATE TABLE customer
(	id			VARCHAR(10) PRIMARY KEY,
	fname		VARCHAR(15)	NOT NULL,						
	lname		VARCHAR(15)	NOT NULL,
	phone		VARCHAR(15),
	email		VARCHAR(50),
	bdate		DATE,
	facebook	VARCHAR(50),
	col_point	INT
);

				
CREATE TABLE address_user
(	
	id_customer			VARCHAR(10)		NOT NULL,
	address_first		VARCHAR(100)	NOT NULL,
	address_province	VARCHAR(100)	NOT NULL,
	PRIMARY KEY	(id_customer, address_first, address_province)
);

CREATE TABLE book_type
(
	id_book	VARCHAR(10) PRIMARY KEY,
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


