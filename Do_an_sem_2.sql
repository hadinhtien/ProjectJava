﻿CREATE DATABASE Do_an_sem_2
GO
USE Do_an_sem_2

GO
CREATE TABLE Categories (
	CateId INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(255) UNIQUE NOT NULL,
	Status BIT DEFAULT 1,
	CreatedAt DATETIME DEFAULT GETDATE()
)

GO
CREATE TABLE Brands (
	BrandId INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(255) UNIQUE NOT NULL,
	ImageUrl VARCHAR(255) NOT NULL,
	Status BIT DEFAULT 1,
	CreatedAt DATETIME DEFAULT GETDATE()
)

GO
CREATE TABLE Products (
	ProId INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(255) NOT NULL,
	ImageUrl VARCHAR(255) NOT NULL,
	Price MONEY NOT NULL,
	Discount MONEY DEFAULT(0),
	CateId INT FOREIGN KEY REFERENCES Categories(CateId),
	BrandId INT FOREIGN KEY REFERENCES Brands(BrandId),
	ShortDescription NTEXT NOT NULL,
	Description NTEXT NOT NULL,
	Quantity INT NOT NULL,
	Status TINYINT DEFAULT 1,
	CreatedAt DATETIME DEFAULT GETDATE()
)

GO
CREATE TABLE Product_images (
	Id INT PRIMARY KEY IDENTITY(1,1),
	ProId INT FOREIGN KEY REFERENCES Products(ProId) NOT NULL,
	ImageUrl VARCHAR(255) NOT NULL
)

GO
CREATE TABLE Accounts (
	AccId INT PRIMARY KEY IDENTITY(1,1),
	Email VARCHAR(255) UNIQUE NOT NULL,
	FullName NVARCHAR(255) NOT NULL,
	Phone VARCHAR(20) NOT NULL,
	Address NVARCHAR(255) NOT NULL,
	Password VARCHAR(255) NOT NULL,
	Status BIT DEFAULT 1,
	CreatedAt DATETIME DEFAULT GETDATE()
)

GO
CREATE TABLE Roles (
	RoleId INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(255) UNIQUE NOT NULL,
	Status BIT DEFAULT 1
)

GO
CREATE TABLE Account_Roles (
	Id INT PRIMARY KEY IDENTITY(1,1),
	AccId INT FOREIGN KEY REFERENCES Accounts(AccId),
	RoleId INT FOREIGN KEY REFERENCES Roles(RoleId)
)

GO
CREATE TABLE Contacts (
	Id INT PRIMARY KEY IDENTITY(1,1),
	AccId INT NULL,
	FullName NVARCHAR(255) NOT NULL,
	Email NVARCHAR(255) NOT NULL,
	Phone VARCHAR(20) NOT NULL,
	Message NTEXT NOT NULL,
	Status BIT DEFAULT 1,
	CreatedAt DATETIME DEFAULT GETDATE()
)

GO
CREATE TABLE Configs (
	Id INT PRIMARY KEY IDENTITY(1,1),
	LogoImage NVARCHAR(255) NOT NULL,
	BannerImage NVARCHAR(255) NOT NULL,
	Address NVARCHAR(255) NOT NULL,
	Map TEXT NOT NULL,
	Phone VARCHAR(20) NOT NULL,
	Email NVARCHAR(255) NOT NULL,
	UpdatedAt DATETIME NULL
)

GO
CREATE TABLE Carts (
	CartId INT PRIMARY KEY IDENTITY(1,1),
	AccId INT FOREIGN KEY REFERENCES Accounts(AccId),
	ProId INT FOREIGN KEY REFERENCES Products(ProId),
	Quantity INT NOT NULL
)

GO
CREATE TABLE Orders (
	OrderId INT PRIMARY KEY IDENTITY(1,1),
	AccId INT FOREIGN KEY REFERENCES Accounts(AccId),
	FullName NVARCHAR(255) NOT NULL,
	Address NVARCHAR(255) NOT NULL,
	Phone VARCHAR(20) NOT NULL,
	Note NTEXT NULL,
	TotalPrice MONEY NOT NULL,
	Status TINYINT DEFAULT 1,
	CreatedAt DATE DEFAULT GETDATE(),
	UpdatedAt DATE NULL
)

GO
CREATE TABLE OrderDetails (
	Id INT PRIMARY KEY IDENTITY(1,1),
	OrderId INT FOREIGN KEY REFERENCES Orders(OrderId),
	ProId INT FOREIGN KEY REFERENCES Products(ProId),
	Quantity INT NOT NULL,
	Price MONEY NOT NULL
)

GO
CREATE TABLE Blogs (
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NTEXT NOT NULL,
	Title NTEXT NOT NULL,
	MainImageUrl VARCHAR(255) NOT NULL,
	Content_1 NTEXT NOT NULL,
	SecondImageUrl VARCHAR(255) NOT NULL,
	Content_2 NTEXT NOT NULL,
	ThirdImageUrl VARCHAR(255) NULL,
	Content_3 NTEXT NULL,
	Status BIT DEFAULT 1,
	CreatedAt DATETIME DEFAULT GETDATE(),
)

GO
CREATE TRIGGER tg_CheckTotalBookOfAuthor
ON Accounts
FOR INSERT
AS
BEGIN
	INSERT Account_Roles VALUES ((SELECT TOP 1 AccId FROM Accounts ORDER BY AccId DESC), 2)
END

GO
INSERT INTO Roles(Name) VALUES ('ROLE_ADMIN'), ('ROLE_USER')
GO
INSERT INTO Configs VALUES ('logoImage.png', 'service-center-5.jpg', N'Số 238 Hoàng Quốc Việt, Cầu Giấy, Hà nội.', 
'<iframe src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d1455.0111587501103!2d105.78426245540275!3d21.046832990622818!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ab3b4220c2bd%3A0x1c9e359e2a4f618c!2sB%C3%A1ch%20Khoa%20Aptech!5e1!3m2!1svi!2s!4v1652431210865!5m2!1svi!2s" width="100%" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>'
, '024 3755 4010', 'Eiser@gmail.com', '2022-05-13')

select * from Categories
select * from Account_Roles
--insert into Account_Roles values(1,1)

