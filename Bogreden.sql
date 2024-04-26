CREATE DATABASE Bogreden;
USE Bogreden;

-- Creating a user for Kunde;
CREATE USER IF NOT exists Kunde identified by 'AmazingPassword';
GRANT select ON *.* TO Kunde;

-- Creating Tables:
CREATE TABLE Cities (
	PostalCode VARCHAR(50) NOT NULL,
	CityName VARCHAR(100) NOT NULL
);

-- Bulk INSERT to Cities
LOAD DATA INFILE 'C:/postnumre.csv'
INTO TABLE Cities
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

-- Alter City to get an ID
ALTER TABLE Cities
ADD CityID INT auto_increment NOT NULL PRIMARY KEY;

CREATE TABLE Authors (
	AuthorID INT auto_increment NOT NULL PRIMARY KEY,
	AuthorName VARCHAR(100) NOT NULL,
	DateOfBirth DATE,
	Nationality VARCHAR(50)
);

CREATE TABLE Addresses (
    AddressID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    AddressName VARCHAR(100),
    CityID INT NOT NULL,
    Country VARCHAR(100),
    FOREIGN KEY (CityID) REFERENCES Cities(CityID)
);

CREATE TABLE Customers (
	CustomerID INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
	CustomerName VARCHAR(100) NOT NULL,
	DateOfBirth DATE,
	Email VARCHAR(255) NOT NULL,
	AddressID INT,
	Password VARCHAR(255) NOT NULL,
	FOREIGN KEY (AddressID) REFERENCES Addresses(AddressID),
    UNIQUE (Email)
);

CREATE TABLE Prices (
	PriceID INT auto_increment NOT NULL PRIMARY KEY,
	Price DECIMAL(5,2) NOT NULL
);

CREATE TABLE Books (
	BookID INT auto_increment NOT NULL PRIMARY KEY,
	Title VARCHAR(100) NOT NULL,
	AuthorID INT NOT NULL,
	PriceID INT NOT NULL,
	ReleaseDate DATE,
    foreign key (AuthorID) references Authors(AuthorID),
    FOREIGN KEY (PriceID) REFERENCES Prices(PriceID)
);

CREATE TABLE Orders (
	OrderID INT auto_increment NOT NULL PRIMARY KEY,
	BookID INT NOT NULL,
	CustomerID INT NOT NULL,
	FOREIGN KEY (BookID) REFERENCES Books(BookID),
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Bogreden_log (
	LogID INT auto_increment NOT NULL PRIMARY KEY,
	TableChanged VARCHAR(20) NOT NULL,
    ChangeType VARCHAR(10) NOT NULL,
    TimeChanged TIMESTAMP default current_timestamp
);

-- Creating triggers:
DELIMITER //
CREATE TRIGGER Bogreden_Log_Books_UPDATE_Trigger
AFTER UPDATE
ON Books
FOR EACH ROW
BEGIN
	INSERT INTO Bogreden_log (TableChanged, ChangeType)
    VALUES ('Books', 'UPDATE');
END//

CREATE TRIGGER Bogreden_log_Authors_UPDATE_Trigger
AFTER UPDATE
ON Authors
FOR EACH ROW
BEGIN
	INSERT INTO Bogreden_log (TableChanged, ChangeType)
    VALUES ('Authors', 'UPDATE');
END//

CREATE TRIGGER Bogreden_log_Prices_UPDATE_Trigger
AFTER UPDATE
ON Prices
FOR EACH ROW
BEGIN
	INSERT INTO Bogreden_log (TableChanged, ChangeType)
    VALUES ('Prices', 'UPDATE');
END//

CREATE TRIGGER Bogreden_log_Addresses_UPDATE_Trigger
AFTER UPDATE
ON Addresses
FOR EACH ROW
BEGIN
	INSERT INTO Bogreden_log (TableChanged, ChangeType)
    VALUES ('Addresses', 'UPDATE');
END//

CREATE TRIGGER Bogreden_log_Customers_UPDATE_Trigger
AFTER UPDATE
ON Customers
FOR EACH ROW
BEGIN
	INSERT INTO Bogreden_log (TableChanged, ChangeType)
    VALUES ('Customers', 'UPDATE');
END//

CREATE TRIGGER Bogreden_log_Orders_UPDATE_Trigger
AFTER UPDATE
ON Orders
FOR EACH ROW
BEGIN
	INSERT INTO Bogreden_log (TableChanged, ChangeType)
    VALUES ('Orders', 'UPDATE');
END//

CREATE TRIGGER Bogreden_log_Cities_UPDATE_Trigger
AFTER UPDATE
ON Cities
FOR EACH ROW
BEGIN
	INSERT INTO Bogreden_log (TableChanged, ChangeType)
    VALUES ('Cities', 'UPDATE');
END//

CREATE TRIGGER Bogreden_log_Books_INSERT_Trigger
AFTER INSERT
ON Books
FOR EACH ROW
BEGIN
	INSERT INTO Bogreden_log (TableChanged, ChangeType)
    VALUES ('Books', 'INSERT');
END//

CREATE TRIGGER Bogreden_log_Authors_INSERT_Trigger
AFTER INSERT
ON Authors
FOR EACH ROW
BEGIN
	INSERT INTO Bogreden_log (TableChanged, ChangeType)
    VALUES ('Authors', 'INSERT');
END//

CREATE TRIGGER Bogreden_log_Prices_INSERT_Trigger
AFTER INSERT
ON Prices
FOR EACH ROW
BEGIN
	INSERT INTO Bogreden_log (TableChanged, ChangeType)
    VALUES ('Prices', 'INSERT');
END//

CREATE TRIGGER Bogreden_log_Addresses_INSERT_Trigger
AFTER INSERT
ON Addresses
FOR EACH ROW
BEGIN
	INSERT INTO Bogreden_log (TableChanged, ChangeType)
    VALUES ('Addresses', 'INSERT');
END//

CREATE TRIGGER Bogreden_log_Customers_INSERT_Trigger
AFTER INSERT
ON Customers
FOR EACH ROW
BEGIN
	INSERT INTO Bogreden_log (TableChanged, ChangeType)
    VALUES ('Customers', 'INSERT');
END//

CREATE TRIGGER Bogreden_log_Orders_INSERT_Trigger
AFTER INSERT
ON Orders
FOR EACH ROW
BEGIN
	INSERT INTO Bogreden_log (TableChanged, ChangeType)
    VALUES ('Orders', 'INSERT');
END//

CREATE TRIGGER Bogreden_log_Cities_INSERT_Trigger
AFTER INSERT
ON Cities
FOR EACH ROW
BEGIN
	INSERT INTO Bogreden_log (TableChanged, ChangeType)
    VALUES ('Cities', 'INSERT');
END//

DELIMITER ;

-- Creating index for all tables
-- Index for Cities table
CREATE INDEX idx_Cities_PostalCode ON Cities (PostalCode);
CREATE INDEX idx_Cities_CityName ON Cities (CityName);

-- Index for Authors table
CREATE INDEX idx_Authors_AuthorName ON Authors (AuthorName);
CREATE INDEX idx_Authors_DateOfBirth ON Authors (DateOfBirth);
CREATE INDEX idx_Authors_Nationality ON Authors (Nationality);

CREATE INDEX idx_Addresses_AddressName ON Addresses (AddressName);
CREATE INDEX idx_Addresses_CityID ON Addresses (CityID);
CREATE INDEX idx_Addresses_Country ON Addresses (Country);

-- Index for Customers table
CREATE INDEX idx_Customers_CustomerName ON Customers (CustomerName);
CREATE INDEX idx_Customers_DateOfBirth ON Customers (DateOfBirth);
CREATE INDEX idx_Customers_Email ON Customers (Email);
CREATE INDEX idx_Customers_Address ON Customers (AddressID);

-- Index for Books table
CREATE INDEX idx_Books_Title ON Books (Title);
CREATE INDEX idx_Books_AuthorID ON Books (AuthorID);
CREATE INDEX idx_Books_PriceID ON Books (PriceID);
CREATE INDEX idx_Books_ReleaseDate ON Books (ReleaseDate);

-- Index for Orders table
CREATE INDEX idx_Orders_BookID ON Orders (BookID);
CREATE INDEX idx_Orders_CustomerID ON Orders (CustomerID);

-- Index for Bogreden_log table
CREATE INDEX idx_Bogreden_log_TableChanged ON Bogreden_log (TableChanged);
CREATE INDEX idx_Bogreden_log_ChangeType ON Bogreden_log (ChangeType);
CREATE INDEX idx_Bogreden_log_TimeChanged ON Bogreden_log (TimeChanged);


-- Inserting data for all tables:
-- Inserting data into the Authors table
INSERT INTO Authors (AuthorName, DateOfBirth, Nationality) VALUES
('John Doe', '1980-05-15', 'American'),
('Jane Smith', '1975-10-20', 'British'),
('Ahmed Ali', '1990-03-02', 'Egyptian');

-- Inserting data into the Addresses table
INSERT INTO Addresses (AddressName, CityID, Country) VALUES
('Kaj Munks vej 12', 694, 'Denamrk'),
('Lavendelvej 91', 764, 'Denmark'),
('Tårsvej 8', 766, 'Denmark');

-- Inserting data into the Customers table
INSERT INTO Customers (CustomerName, DateOfBirth, Email, AddressID, Password) VALUES
('Rikke Olsen', '1995-08-10', 'Rikke@example.com', 1, 'password123'),
('Ole Hansen', '1990-12-25', 'Ole@example.com', 2, 'securepass'),
('Klaus Jensen', '1988-03-30', 'Klaus@example.com', 3, 'letmein');

-- Inserting data into the Prices table
INSERT INTO Prices (Price) VALUES
(99.95),
(149.95),
(199.95);

-- Inserting data into the Books table
INSERT INTO Books (Title, AuthorID, PriceID, ReleaseDate) VALUES
('Book1', 1, 1, '2023-01-15'),
('Book2', 2, 2, '2022-05-20'),
('Book3', 3, 3, '2024-03-10');

-- Inserting data into the Orders table
INSERT INTO Orders (BookID, CustomerID) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Stored Procedures:
DELIMITER //
CREATE PROCEDURE sp_GetBooks()
BEGIN
	SELECT Books.Title, Authors.AuthorName, Prices.Price, Books.ReleaseDate
	FROM Books 
	LEFT JOIN Authors ON Books.AuthorID = Authors.AuthorID
	LEFT JOIN Prices ON Books.PriceID = Prices.PriceID; 
END//

CREATE PROCEDURE sp_GetCustomerInfo()
BEGIN
	SELECT Customers.CustomerName, Customers.DateOfBirth, Customers.Email, Addresses.AddressName, Cities.PostalCode, Cities.CityName
	From Customers
	JOIN Addresses ON Customers.AddressID = Addresses.AddressID
	JOIN Cities ON Addresses.CityID = Cities.CityID;
END//

DELIMITER ;
