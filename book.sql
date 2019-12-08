USE ASS4
go

CREATE OR ALTER PROCEDURE Insert_book
	@id VARCHAR(10),
	@price DECIMAL(10,2),
	@_name VARCHAR(30),
	@num_page INT,
	@page_size VARCHAR(30),
	@intro VARCHAR(100),
	@sale_price DECIMAL(10,2),
	@kind INT,
	@import_date DATE	
AS
BEGIN
	IF(@id IN (SELECT id
	FROM dbo.Product))
	BEGIN
		PRINT(N'Existed ID - Book have already inserted before!')
		RETURN 1
	END
	ELSE IF (@price <= 0 OR @sale_price <= 0) 
	BEGIN
		PRINT(N'Price is invalid!')
		RETURN 2
	END
	ELSE IF (@num_page <= 0) 
	BEGIN
		PRINT(N'Number of pages is invalid!')
		RETURN 3
	END
	ELSE
	BEGIN TRY
		INSERT INTO dbo.Product
		(id,price)
		VALUES
		(@id,@price)
		
		INSERT INTO dbo.book 
		(id,_name,num_page,page_size,intro,sale_price,kind,import_date)
		VALUES
		(@id,@_name,@num_page,@page_size,@intro,@sale_price,@kind, @import_date)
		PRINT(N'Successfully Inserted')
	END TRY
	BEGIN CATCH
		PRINT(N'Insert Failed. Please check your inserted data')
	END CATCH
END

go

CREATE OR ALTER TRIGGER Insert_book_trigger
ON dbo.book
INSTEAD OF INSERT
AS 
BEGIN
	DECLARE @id VARCHAR(10)
	DECLARE @name VARCHAR(30)
	DECLARE @num_page	INT
	DECLARE @page_size	VARCHAR(30)
	DECLARE @intro	VARCHAR(100)
	DECLARE @sale_price DECIMAL(10,2)
	DECLARE @kind	INT
	DECLARE @import_date	DATE
	SELECT @id = i.id, @name = i._name, @num_page = i.num_page, @page_size = i.page_size, @intro = i.intro,
			@sale_price = i.sale_price, @kind = i.kind, @import_date = i.import_date
	from inserted as i
	---------------------------------
	DECLARE @id_same_pattern_book VARCHAR(10)
	SELECT top 1 @id_same_pattern_book = id
	from book AS i
	where @name = i._name AND @num_page = i.num_page AND @page_size = i.page_size AND @intro = i.intro AND
			@sale_price = i.sale_price AND @kind = i.kind 
	----------------------------------
	print(@id_same_pattern_book )
	IF (@id_same_pattern_book is NULL)
	BEGIN
		INSERT INTO Product(id,price)
		VALUES(@id, 0)
		INSERT INTO book(id, _name, num_page, page_size, intro, sale_price, kind, import_date)
		VALUES (@id, @name,@num_page,@page_size,@intro,@sale_price,@kind,@import_date );
		PRINT('Automatically create the corresponding product, similar pattern existed book not found. THE PRICE WILL BE SET TO 0. PLEASE REMEMBER TO SET IT AGAIN! ')
		RETURN 
	END
	ELSE 
	BEGIN
		DECLARE @price DECIMAL(10,2)
		SELECT @price = price
		from Product
		where id = @id_same_pattern_book
		INSERT INTO Product(id,price)
		VALUES(@id, @price)
		INSERT INTO book(id, _name, num_page, page_size, intro, sale_price, kind, import_date)
		VALUES (@id, @name,@num_page,@page_size,@intro,@sale_price,@kind,@import_date );
		PRINT('Successfully inserted! You can reupdate the price later!')
		RETURN 
	END
END


INSERT INTO author(id,_name) VALUES ('17101','Vladimir Nabokov')
INSERT INTO author(id,_name) VALUES ('17111','F. Scott Fitzgerald')
INSERT INTO author(id,_name) VALUES ('17121','Marcel Proust')
INSERT INTO author(id,_name) VALUES ('17131','James Joyce')
INSERT INTO author(id,_name) VALUES ('17141','Gabriel Garcia Marquez')
INSERT INTO author(id,_name) VALUES ('17151','William Faulkner')
INSERT INTO author(id,_name) VALUES ('17161','Virginia Woolf')
INSERT INTO author(id,_name) VALUES ('17171','Mark Twain')
INSERT INTO author(id,_name) VALUES ('17181','Henry James ')
INSERT INTO author(id,_name) VALUES ('17191','Ernest Hemingway ')


EXEC Insert_book 'A00001', 100000, 'Lolita', 1250, 'A5', 'Romantic', 3000, 1, '2019-12-07'
INSERT INTO write (id_author,id_book) VALUES ('17101','A00001')
EXEC Insert_book 'A00002', 100000, 'Lolita', 1250, 'A5', 'Romantic', 3000, 1, '2019-12-07'
INSERT INTO write (id_author,id_book) VALUES ('17101','A00002')
EXEC Insert_book 'A00003', 100000, 'Lolita', 1250, 'A5', 'Romantic', 3000, 1, '2019-12-07'
INSERT INTO write (id_author,id_book) VALUES ('17101','A00003')
EXEC Insert_book 'A00004', 100000, 'Lolita', 1250, 'A5', 'Romantic', 3000, 1, '2019-12-07'
INSERT INTO write (id_author,id_book) VALUES ('17101','A00004')
EXEC Insert_book 'A00005', 150000, 'The Great Gatsby', 2365, 'A5', 'Politic', 3000, 1, '2019-12-07'
INSERT INTO write (id_author,id_book) VALUES ('17111','A00005')
EXEC Insert_book 'A00006', 150000, 'The Great Gatsby', 2365, 'A5', 'Politic', 3000, 1, '2019-12-07'
INSERT INTO write (id_author,id_book) VALUES ('17111','A00006')
EXEC Insert_book 'A00007', 180000, 'Ulysses', 10960, 'A5', 'Scientific', 3000, 1, '2019-12-07'
INSERT INTO write (id_author,id_book) VALUES ('17131','A00007')
EXEC Insert_book 'A00008', 180000, 'Ulysses', 10960, 'A5', 'Scientific', 3000, 1, '2019-02-08'
INSERT INTO write (id_author,id_book) VALUES ('17131','A00008')
EXEC Insert_book 'A00009', 180000, 'Ulysses', 10960, 'A5', 'Scientific', 3000, 1, '2019-30-03'
INSERT INTO write (id_author,id_book) VALUES ('17131','A00009')
EXEC Insert_book 'A00010', 100000, 'Ulysses', 10960, 'A5', 'Scientific', 3000, 1, '2019-12-22'
INSERT INTO write (id_author,id_book) VALUES ('17131','A00010')
EXEC Insert_book 'A00011', 100000, 'Dubliners', 12250, 'A5', 'Romantic', 3000, 1, GETDATE
INSERT INTO write (id_author,id_book) VALUES ('17131','A00011')
EXEC Insert_book 'A00012', 100000, 'Dubliners', 12250, 'A5', 'Romantic', 3000, 1, '2019-04-04'
INSERT INTO write (id_author,id_book) VALUES ('17131','A00012')
EXEC Insert_book 'A00013', 100000, 'Dubliners', 12250, 'A5', 'Romantic', 3000, 1, '2019-12-17'
INSERT INTO write (id_author,id_book) VALUES ('17131','A00013')
EXEC Insert_book 'A00014', 100000, 'One Hundred Years of Solitude', 1250, 'A5', 'Romantic', 3000, 1, GETDATE
INSERT INTO write (id_author,id_book) VALUES ('17141','A00014')
EXEC Insert_book 'A00015', 100000, 'One Hundred Years of Solitude', 1250, 'A5', 'Romantic', 3000, 1, '2019-10-01'
INSERT INTO write (id_author,id_book) VALUES ('17141','A00015')
EXEC Insert_book 'A00016', 100000, 'One Hundred Years of Solitude', 1250, 'A5', 'Romantic', 3000, 1, '2019-10-01'
INSERT INTO write (id_author,id_book) VALUES ('17141','A00016')
EXEC Insert_book 'A00017', 200000, 'The Sound and the Fury ', 1050, 'A5', 'Thriller', 3000, 1, '2018-01-01'
INSERT INTO write (id_author,id_book) VALUES ('17151','A00017')
EXEC Insert_book 'A00018', 350000, 'To The Lighthouse', 11250, 'A5', 'Romantic', 3000, 1, GETDATE
INSERT INTO write (id_author,id_book) VALUES ('17161','A00018')
EXEC Insert_book 'A00019', 350000, 'To The Lighthouse', 11250, 'A5', 'Romantic', 3000, 1, '2018-11-07'
INSERT INTO write (id_author,id_book) VALUES ('17161','A00019')
EXEC Insert_book 'A00020', 350000, 'To The Lighthouse', 11250, 'A5', 'Romantic', 3000, 1, '2018-11-07'
INSERT INTO write (id_author,id_book) VALUES ('17161','A00020')
EXEC Insert_book 'A00021', 100000, 'The Adventures of Huckleberry Finn', 12505, 'A5', 'Adventure', 3000, 1, '2019-03-02'
INSERT INTO write (id_author,id_book) VALUES ('17171','A00021')
EXEC Insert_book 'A00022', 100000, 'The Adventures of Huckleberry Finn', 12505, 'A5', 'Adventure', 3000, 1, '2019-03-02'
INSERT INTO write (id_author,id_book) VALUES ('17171','A00022')
EXEC Insert_book 'A00023', 100000, 'The Adventures of Huckleberry Finn', 12505, 'A5', 'Adventure', 3000, 1, '2019-03-02'
INSERT INTO write (id_author,id_book) VALUES ('17171','A00023')
EXEC Insert_book 'A00024', 100000, 'Daisy Miller', 1250, 'A5', 'Romantic', 3000, 1, '2019-12-07'
INSERT INTO write (id_author,id_book) VALUES ('17181','A00024')
EXEC Insert_book 'A00025', 100000, 'Daisy Miller', 1250, 'A5', 'Romantic', 3000, 1, GETDATE
INSERT INTO write (id_author,id_book) VALUES ('17181','A00025')
EXEC Insert_book 'A00026', 250000, 'Daisy Miller', 1250, 'A5', 'Romantic', 3000, 1, GETDATE
INSERT INTO write (id_author,id_book) VALUES ('17181','A00026')
EXEC Insert_book 'A00027', 700000, 'The Sun Also Rises', 3125, 'A5', 'Religion', 3000, 1, '2019-12-07'
INSERT INTO write (id_author,id_book) VALUES ('17191','A00027')
EXEC Insert_book 'A00028', 700000, 'The Sun Also Rises', 3125, 'A5', 'Religion', 3000, 1, '2019-12-07'
INSERT INTO write (id_author,id_book) VALUES ('17191','A00028')
EXEC Insert_book 'A00029', 700000, 'The Sun Also Rises', 3125, 'A5', 'Religion', 3000, 1, '2019-12-07'
INSERT INTO write (id_author,id_book) VALUES ('17191','A00029')
EXEC Insert_book 'A00030', 100000, 'The Old Man and the Sea', 3030, 'A5', 'Politics', 3000, 1, '2019-12-07'
INSERT INTO write (id_author,id_book) VALUES ('17191','A00030')
EXEC Insert_book 'A00031', 100000, 'The Old Man and the Sea', 3030, 'A5', 'Politics', 3000, 1, '2019-12-07'
INSERT INTO write (id_author,id_book) VALUES ('17191','A00031')
EXEC Insert_book 'A00032', 100000, 'The Old Man and the Sea', 3030, 'A5', 'Politics', 3000, 1, '2019-12-07'
INSERT INTO write (id_author,id_book) VALUES ('17191','A00032')


