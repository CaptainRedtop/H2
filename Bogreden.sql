--CREATE DATABASE Bogreden;
--USE Bogreden;

CREATE TABLE Book (
	BookID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Title VARCHAR(100) NOT NULL,
	GenreID INT NOT NULL,
	AuthorID INT NOT NULL,
	PriceID INT NOT NULL,
	ReleaseDate DATE
);

CREATE TABLE Genre (
	GenreID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Genre VARCHAR(100) NOT NULL
);

CREATE TABLE City (
	CityID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	CityName VARCHAR(100) NOT NULL,
	PostalCode VARCHAR(50) NOT NULL
);

CREATE TABLE Author (
	AuthorID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	AuthorName VARCHAR(100) NOT NULL,
	DateOfBirth DATE,
	Nationality VARCHAR(50),
);

CREATE TABLE WritingBooks (
	BookID INT NOT NULL,
	AuthorID INT NOT NULL,
	FOREIGN KEY (BookID) REFERENCES Book(BookID),
	FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID)
);

CREATE TABLE Customer (
	CustomerID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	CustomerName VARCHAR(100) NOT NULL,
	DateOfBirth DATE,
	Email VARCHAR(255) NOT NULL,
	Address VARCHAR(100),
	CityID INT,
	Country VARCHAR(100),
	Password VARCHAR(255) NOT NULL,
	FOREIGN KEY (CityID) REFERENCES City(CityID)
);

CREATE TABLE Price (
	PriceID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	Price DECIMAL(5,2) NOT NULL,
	BookID INT,
	FOREIGN KEY (BookID) REFERENCES Book(BookID)
);

CREATE TABLE Orders (
	OrderID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	BookID INT NOT NULL,
	CustomerID INT NOT NULL,
	FOREIGN KEY (BookID) REFERENCES Book(BookID),
	FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Bogreden_log (
	LogID INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
	LogText TEXT NOT NULL
);

ALTER TABLE Book
ADD FOREIGN KEY (GenreID) REFERENCES Genre(GenreID);
ALTER TABLE Book
ADD FOREIGN KEY (AuthorID) REFERENCES Author(AuthorID);
ALTER TABLE Book
ADD FOREIGN KEY (PriceID) REFERENCES Price(PriceID);
