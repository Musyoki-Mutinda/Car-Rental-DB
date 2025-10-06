IF OBJECT_ID('dbo.Payment', 'U') IS NOT NULL DROP TABLE dbo.Payment;
IF OBJECT_ID('dbo.Booking', 'U') IS NOT NULL DROP TABLE dbo.Booking;
IF OBJECT_ID('dbo.Reservation', 'U') IS NOT NULL DROP TABLE dbo.Reservation;
IF OBJECT_ID('dbo.Maintenance', 'U') IS NOT NULL DROP TABLE dbo.Maintenance;
IF OBJECT_ID('dbo.Insurance', 'U') IS NOT NULL DROP TABLE dbo.Insurance;
IF OBJECT_ID('dbo.Location', 'U') IS NOT NULL DROP TABLE dbo.Location;
IF OBJECT_ID('dbo.Car', 'U') IS NOT NULL DROP TABLE dbo.Car;
IF OBJECT_ID('dbo.Customer', 'U') IS NOT NULL DROP TABLE dbo.Customer;
GO

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PhoneNumber VARCHAR(20),
    Address VARCHAR(255)
);
GO

CREATE TABLE Car (
    CarID INT PRIMARY KEY IDENTITY(1,1),
    CarModel VARCHAR(100) NOT NULL,
    Manufacturer VARCHAR(100) NOT NULL,
    Year INT NOT NULL,
    Color VARCHAR(50),
    RentalRate DECIMAL(10,2) NOT NULL,
    Availability BIT NOT NULL DEFAULT 1
);
GO

CREATE TABLE Booking (
    BookingID INT PRIMARY KEY IDENTITY(1,1),
    CarID INT NOT NULL,
    CustomerID INT NOT NULL,
    RentalStartDate DATE NOT NULL,
    RentalEndDate DATE NOT NULL,
    TotalAmount DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_Booking_Car FOREIGN KEY (CarID) REFERENCES Car(CarID),
    CONSTRAINT FK_Booking_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
GO

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY IDENTITY(1,1),
    BookingID INT NOT NULL UNIQUE,   
    PaymentDate DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(50) NOT NULL,
    CONSTRAINT FK_Payment_Booking FOREIGN KEY (BookingID) REFERENCES Booking(BookingID)
);
GO

CREATE TABLE Location (
    LocationID INT PRIMARY KEY IDENTITY(1,1),
    CarID INT NOT NULL UNIQUE,  
    LocationName VARCHAR(100) NOT NULL,
    Address VARCHAR(255) NOT NULL,
    ContactNumber VARCHAR(20),
    CONSTRAINT FK_Location_Car FOREIGN KEY (CarID) REFERENCES Car(CarID)
);
GO

CREATE TABLE Insurance (
    InsuranceID INT PRIMARY KEY IDENTITY(1,1),
    CarID INT NOT NULL UNIQUE,  
    InsuranceProvider VARCHAR(100) NOT NULL,
    PolicyNumber VARCHAR(50) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    CONSTRAINT FK_Insurance_Car FOREIGN KEY (CarID) REFERENCES Car(CarID)
);
GO

CREATE TABLE Maintenance (
    MaintenanceID INT PRIMARY KEY IDENTITY(1,1),
    CarID INT NOT NULL,
    MaintenanceDate DATE NOT NULL,
    Description VARCHAR(255),
    Cost DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_Maintenance_Car FOREIGN KEY (CarID) REFERENCES Car(CarID)
);
GO

CREATE TABLE Reservation (
    ReservationID INT PRIMARY KEY IDENTITY(1,1),
    CarID INT NOT NULL,
    CustomerID INT NOT NULL,
    ReservationDate DATE NOT NULL,
    PickupDate DATE NOT NULL,
    ReturnDate DATE NOT NULL,
    CONSTRAINT FK_Reservation_Car FOREIGN KEY (CarID) REFERENCES Car(CarID),
    CONSTRAINT FK_Reservation_Customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);
GO
