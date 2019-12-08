CREATE TABLE account
(
	id					VARCHAR(10)			PRIMARY KEY,
	name				VARCHAR(30)			NOT NULL,
	password			VARCHAR(30)			NOT NULL
);

CREATE TABLE order_product
(
	id_product			VARCHAR(10),
	id_order			VARCHAR(10),
	amount				INT					NOT NULL,
	price				DECIMAL(10,2)		NOT NULL,
	PRIMARY KEY			(id_product, id_order)
);

CREATE TABLE _order
(
	id					VARCHAR(10)			PRIMARY KEY,
	_address			VARCHAR(100)		NOT NULL,
	id_employ			VARCHAR(10),
	id_trans_company	VARCHAR(10)			NOT NULL,
	id_cart				VARCHAR(10)			NOT NULL,
	order_date			DATETIME			NOT NULL,
	check_date			DATETIME,			
	delivery_date		DATETIME,
	payment				VARCHAR(20)			NOT NULL,
	del_status			VARCHAR(1)			NOT NULL,
	stt					INT					NOT NULL
);

CREATE TABLE employee
(
	id					VARCHAR(10)			PRIMARY KEY,
	_name				VARCHAR(30)			NOT NULL,
	_address			VARCHAR(50)			NOT NULL,
	email				VARCHAR(30)			NOT NULL,
	phone				VARCHAR(10)			NOT NULL,
	bdate				DATE				NOT NULL,
	salary				DECIMAL(10,2)		DEFAULT 120,
	mgrid				VARCHAR(10)
);

CREATE PROCEDURE dbo.InsertEmployee
@id			VARCHAR(10),
@username	VARCHAR(30),
@pass		VARCHAR(50),
@name		VARCHAR(30),
@address	VARCHAR(100),
@email		VARCHAR(50),
@phone		VARCHAR(10),
@bdate		DATE,
@salary		DECIMAL(10,2) = 120,
@mgrid		VARCHAR(10)
AS
BEGIN
	IF EXISTS(SELECT 1 FROM employee WHERE id = @id)
		RAISERROR ('ID da ton tai', 10, 1)
	ELSE IF (@mgrid IS NOT NULL) AND (NOT EXISTS(SELECT 1 FROM employee WHERE id = @mgrid))
		RAISERROR ('Khong tim thay nguoi quan ly', 10, 1)
	ELSE IF @email NOT LIKE '%@%'
		RAISERROR ('Email khong hop le', 10, 1)
	ELSE IF @bdate > CAST(GETDATE() AS DATE)
		RAISERROR ('Ngay sinh khong hop le', 10, 1)
	ELSE IF DATEDIFF(DAY, @bdate, GETDATE()) / 365 < 18
		RAISERROR ('Nhan vien chua du 18 tuoi', 10, 1)
	ELSE
		BEGIN
			INSERT INTO dbo.account(id, name, password)
			VALUES (@id, @username, @pass)
			INSERT INTO dbo.employee(id, _name, _address, email, phone, bdate, salary, mgrid) 
			VALUES(@id, @name, @address, @email, @phone, @bdate, @salary, @mgrid)
		END
END


EXECUTE InsertEmployee
@id		= '1111111111',
@username='conan1321',
@pass	='5678',
@name	= 'Edogawa Conan',
@address= '121B, Beika, Tokyo, Japan',
@email	= 'edokona@gmail.com',
@phone	= '0982714024',
@bdate	= '1999-12-22',
@salary = 220,
@mgrid	= NULL

EXECUTE InsertEmployee
@id		= '9999999999',
@username='ranran',
@pass	='1234',
@name	= 'Mouri Ran',
@address= '121B, Beika, Tokyo, Japan',
@email	= 'rara@gmail.com',
@phone	= '0985236214',
@bdate	= '1991-06-13',
@mgrid	= NULL

EXECUTE InsertEmployee
@id		= '1311311311',
@username='nemurukogoro',
@pass	='7852',
@name	= 'Mouri Kogoro',
@address= '121B, Beika, Tokyo, Japan',
@email	= 'kogoro5545@gmail.com',
@phone	= '0912362325',
@bdate	= '1971-06-25',
@mgrid	= NULL

EXECUTE InsertEmployee
@id		= '5241363252',
@username='eri',
@pass	='7552',
@name	= 'Kisaki Eri',
@address= '121B, Toaki, Tokyo, Japan',
@email	= 'eri456@gmail.com',
@phone	= '0912521325',
@bdate	= '1972-09-27',
@salary = 130,
@mgrid	= NULL

EXECUTE InsertEmployee
@id		= '2222222222',
@username='shinshin',
@pass	='4869',
@name	= 'Kudou Shinichi',
@address= '142B, Beika, Tokyo, Japan',
@email	= 'kudou@gmail.com',
@phone	= '0912521658',
@bdate	= '1991-05-04',
@mgrid	= '1111111111'

EXECUTE InsertEmployee
@id		= '3333333333',
@username='heden',
@pass	='7586',
@name	= 'Hattori Heiji',
@address= '145H, Osaka, Japan',
@email	= 'heiji@gmail.com',
@phone	= '0825452123',
@bdate	= '1991-10-04',
@mgrid	= '1111111111'

EXECUTE InsertEmployee
@id		= '4444444444',
@username='ayuyu',
@pass	='77754',
@name	= 'Yoshida Ayumi',
@address= '120H, Beika, Tokyo, Japan',
@email	= 'ayuyu@gmail.com',
@phone	= '0145236125',
@bdate	= '2000-10-04',
@mgrid	= '1111111111'

EXECUTE InsertEmployee
@id		= '5555555555',
@username='mitsu54',
@pass	='1425',
@name	= 'Tsuburaya Mitsuhiko',
@address= '452B, Beika, Tokyo, Japan',
@email	= 'mitsuko@gmail.com',
@phone	= '0452145236',
@bdate	= '2000-11-11',
@mgrid	= '1111111111'

EXECUTE InsertEmployee
@id		= '666666666',
@username='genta23',
@pass	='2455',
@name	= 'Kojima Genta',
@address= '777G, Beika, Tokyo, Japan',
@email	= 'genbuta@gmail.com',
@phone	= '0352626325',
@bdate	= '2000-01-11',
@salary = 100,
@mgrid	= '1111111111'

EXECUTE InsertEmployee
@id		= '7777777777',
@username='sono23',
@pass	='4521',
@name	= 'Suzuki Sonoko',
@address= '124I, Beika, Tokyo, Japan',
@email	= 'sonokoto@gmail.com',
@phone	= '0100000000',
@bdate	= '1991-04-11',
@salary = 200,
@mgrid	= '9999999999'


EXECUTE InsertEmployee
@id		= '1234554321',
@username='aihai',
@pass	='4125',
@name	= 'Haibara Ai',
@address= '256F, Beika, Tokyo, Japan',
@email	= 'aihai@gmail.com',
@phone	= '0123456543',
@bdate	= '1999-08-11',
@salary = 150,
@mgrid	= NULL

EXECUTE InsertEmployee
@id		= '1452362589',
@username='kazuzu',
@pass	='14253',
@name	= 'Toyama Kazuha',
@address= '145G, Nanako, Osaka, Japan',
@email	= 'happa1991@gmail.com',
@phone	= '0425362586',
@bdate	= '1991-04-12',
@mgrid	= '9999999999'

EXECUTE InsertEmployee
@id		= '4521452362',
@username='takasato',
@pass	='1425',
@name	= 'Wataru Takagi',
@address= '452F, Nana, Tokyo, Japan',
@email	= 'takasa@gmail.com',
@phone	= '0142532562',
@bdate	= '1988-02-12',
@mgrid	= '2222222222'

EXECUTE InsertEmployee
@id		= '4452145236',
@username='sato',
@pass	='4753',
@name	= 'Sato Miwako',
@address= '46H, Roku, Tokyo, Japan',
@email	= 'sato@gmail.com',
@phone	= '0142532563',
@bdate	= '1987-10-22',
@mgrid	= '2222222222'

INSERT INTO dbo._order(id, _address, id_employ, id_trans_company, id_cart, order_date, check_date, delivery_date, payment, del_status, stt)
VALUES('1111', '145G, Nakano, Japan', '1111111111', '123', '1', '2019-11-25 17:10:56', '2019-12-01 15:42:12', '2019-12-12', 'Cash', 'N', 2)

INSERT INTO dbo._order(id, _address, id_employ, id_trans_company, id_cart, order_date, check_date, delivery_date, payment, del_status, stt)
VALUES('1112', '174F, Nakashima, Japan', '2222222222', '456', '2', '2019-11-20 15:01:56', '2019-11-21 00:42:12', '2019-11-25 12:45:14', 'Cash', 'Y', 3)

INSERT INTO dbo._order(id, _address, id_employ, id_trans_company, id_cart, order_date, check_date, delivery_date, payment, del_status, stt)
VALUES('1113', '245K, Hiroshima, Japan', '9999999999', '123', '45', '2019-12-05 07:01:56', '2019-12-07 10:01:18', '2019-12-12', 'Cash', 'N', 2)

INSERT INTO dbo._order(id, _address, id_employ, id_trans_company, id_cart, order_date, check_date, delivery_date, payment, del_status, stt)
VALUES('1114', '142H, Okinawa, Japan', '4444444444', 'ABC', '142', '2019-11-01 13:54:56', '2019-11-01 13:59:36', '2019-11-06 12:44:26', 'Cash', 'Y', 3)

INSERT INTO dbo._order(id, _address, id_employ, id_trans_company, id_cart, order_date, check_date, delivery_date, payment, del_status, stt)
VALUES('1115', '214K, Kawasaki, Japan', '4444444444', '123', '55', '2019-11-11 00:01:56', '2019-11-12 13:51:31', '2019-11-16 11:41:26', 'Banking', 'Y', 3)

INSERT INTO dbo._order(id, _address, id_employ, id_trans_company, id_cart, order_date, check_date, delivery_date, payment, del_status, stt)
VALUES('1116', '278K, Osaka, Japan', '5555555555', '456', '75', '2019-12-08 07:01:56', '2019-12-08 10:01:56', '2019-12-15', 'Cash', 'N', 2)

INSERT INTO dbo._order(id, _address, id_employ, id_trans_company, id_cart, order_date, check_date, delivery_date, payment, del_status, stt)
VALUES('1117', '221C, Shiba, Japan', '6666666666', '123', '15', '2019-12-05 07:01:56', '2019-12-07 07:01:56', '2019-12-08 10:11:22', 'Banking', 'Y', 1)

INSERT INTO dbo._order(id, _address, id_employ, id_trans_company, id_cart, order_date, check_date, delivery_date, payment, del_status, stt)
VALUES('1118', '412D, Aomori, Japan', NULL, '123', '45', '2019-12-08 12:01:56', NULL, NULL, 'Cash', 'P', 1)

INSERT INTO dbo._order(id, _address, id_employ, id_trans_company, id_cart, order_date, check_date, delivery_date, payment, del_status, stt)
VALUES('1119', '134D, Kyoto, Japan', '5555555555', '456', '77', '2019-12-01 06:01:26', '2019-12-02 00:01:00', '2019-12-08 10:00:11', 'Cash', 'Y', 1)

INSERT INTO dbo._order(id, _address, id_employ, id_trans_company, id_cart, order_date, check_date, delivery_date, payment, del_status, stt)
VALUES('1120', '77F, Shizuoka, Japan', '9999999999', '123', '57', '2019-12-04 11:01:44', '2019-12-04 11:02:00', '2019-12-08 13:22:14', 'Cash', 'Y', 1)

INSERT INTO dbo._order(id, _address, id_employ, id_trans_company, id_cart, order_date, check_date, delivery_date, payment, del_status, stt)
VALUES('1120', '77F, Shizuoka, Japan', '9999999999', '123', '57', '2019-12-04 11:01:44', '2019-12-04 11:02:00', '2019-12-08 13:22:14', 'Cash', 'Y', 1)

INSERT INTO dbo._order(id, _address, id_employ, id_trans_company, id_cart, order_date, check_date, delivery_date, payment, del_status, stt)
VALUES('1121', '78D, Kanagawa, Japan', '5555555555', '123', '49', '2019-12-04 11:01:46', '2019-12-05 11:02:00', '2019-12-12', 'Cash', 'N', 1)

INSERT INTO dbo._order(id, _address, id_employ, id_trans_company, id_cart, order_date, check_date, delivery_date, payment, del_status, stt)
VALUES('1125', '78D, Kanagawa, Japan', '9999999999', '123', '49', '2019-12-04 11:01:46', '2019-12-05 11:02:00', '2019-12-12', 'Cash', 'N', 1)

INSERT INTO dbo.order_product(id_product, id_order, amount, price)
VALUES('1', '1111', 5, 15)

INSERT INTO dbo.order_product(id_product, id_order, amount, price)
VALUES('2', '1111', 2, 5)

INSERT INTO dbo.order_product(id_product, id_order, amount, price)
VALUES('2', '1112', 20, 5)

INSERT INTO dbo.order_product(id_product, id_order, amount, price)
VALUES('5', '1125', 20, 5)


INSERT INTO dbo.order_product(id_product, id_order, amount, price)
VALUES('1', '1113', 10, 15)

INSERT INTO dbo.order_product(id_product, id_order, amount, price)
VALUES('1', '1115', 10, 15)

INSERT INTO dbo.order_product(id_product, id_order, amount, price)
VALUES('4', '1111', 5, 5)

INSERT INTO dbo.order_product(id_product, id_order, amount, price)
VALUES('1', '1114', 15, 10)

INSERT INTO dbo.order_product(id_product, id_order, amount, price)
VALUES('3', '1115', 50, 2.5)

INSERT INTO dbo.order_product(id_product, id_order, amount, price)
VALUES('1', '1115', 2, 5)

INSERT INTO dbo.order_product(id_product, id_order, amount, price)
VALUES('2', '1116', 2, 15)

INSERT INTO dbo.order_product(id_product, id_order, amount, price)
VALUES('2', '1117', 3, 15)

INSERT INTO dbo.order_product(id_product, id_order, amount, price)
VALUES('1', '1118', 1, 20)

INSERT INTO dbo.order_product(id_product, id_order, amount, price)
VALUES('3', '1118', 5, 2.5)

INSERT INTO dbo.order_product(id_product, id_order, amount, price)
VALUES('1', '1119', 1, 50)

INSERT INTO dbo.order_product(id_product, id_order, amount, price)
VALUES('1', '1120', 1, 50)