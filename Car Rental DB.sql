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


INSERT INTO Customer (FirstName, LastName, Email, PhoneNumber, Address)
VALUES
('John', 'Muiruri', 'johnmuiruri@yahoo.com', '0723769461', 'Nairobi'),
('Janet', 'Wanjiru', 'janetwanjiru@gmail.com', '0700468752', 'Mombasa'),
('Alexis', 'Kamau', 'alexiskamau@hotmail.com', '0701357608', 'Nakuru'),
('Mary', 'Otieno', 'maryotieno@yahoo.com', '0769653874', 'Kisumu'),
('Peter', 'Mwangi', 'petermwangi@gmail.com', '0722694705', 'Eldoret'),
('Linda', 'Mutua', 'lindamutua@icloud.com', '0728759763', 'Thika'),
('Brian', 'Musanga', 'briannjoroge@gmail.com', '0729057907', 'Naivasha');


INSERT INTO Car (CarModel, Manufacturer, Year, Color, RentalRate, Availability)
VALUES
('Corolla', 'Toyota', 2020, 'White', 3500.00, 1),
('CX-5', 'Mazda', 2021, 'Blue', 5000.00, 1),
('X-Trail', 'Nissan', 2019, 'Black', 4000.00, 1),
('Civic', 'Honda', 2022, 'Red', 4500.00, 1),
('Ranger', 'Ford', 2018, 'Grey', 6000.00, 1),
('Land Cruiser', 'Toyota', 2021, 'Black', 8000.00, 1),
('Swift', 'Suzuki', 2020, 'Silver', 3000.00, 1);


INSERT INTO Booking (CarID, CustomerID, RentalStartDate, RentalEndDate, TotalAmount)
VALUES
(1, 1, '2025-10-01', '2025-10-05', 14000.00),
(2, 2, '2025-09-20', '2025-09-25', 25000.00),
(3, 3, '2025-09-10', '2025-09-15', 20000.00),
(4, 4, '2025-08-01', '2025-08-10', 45000.00),
(5, 5, '2025-07-15', '2025-07-20', 30000.00),
(6, 6, '2025-06-01', '2025-06-03', 16000.00),
(7, 7, '2025-05-05', '2025-05-07', 6000.00);


INSERT INTO Payment (BookingID, PaymentDate, Amount, PaymentMethod)
VALUES
(1, '2025-10-01', 14000.00, 'M-Pesa'),
(2, '2025-09-20', 25000.00, 'Credit Card'),
(3, '2025-09-10', 20000.00, 'Cash'),
(4, '2025-08-01', 45000.00, 'Bank Transfer'),
(5, '2025-07-15', 30000.00, 'M-Pesa'),
(6, '2025-06-01', 16000.00, 'Credit Card'),
(7, '2025-05-05', 6000.00, 'Cash');


INSERT INTO Location (CarID, LocationName, Address, ContactNumber)
VALUES
(1, 'Nairobi Branch', 'Moi Avenue', '0701065981'),
(2, 'Mombasa Branch', 'Diani Road', '0701094872'),
(3, 'Nakuru Branch', 'Kenyatta Avenue', '0764897503'),
(4, 'Kisumu Branch', 'Jomo Kenyatta Highway', '0711643004'),
(5, 'Eldoret Branch', 'Oloo Street', '0721040075'),
(6, 'Thika Branch', 'Thika Road', '0701874636'),
(7, 'Naivasha Branch', 'Mama Ngina Street', '0747398507');


INSERT INTO Insurance (CarID, InsuranceProvider, PolicyNumber, StartDate, EndDate)
VALUES
(1, 'Jubilee', 'POL001', '2025-01-01', '2025-12-31'),
(2, 'Britam', 'POL002', '2025-02-01', '2026-01-31'),
(3, 'Madison', 'POL003', '2025-03-01', '2026-02-28'),
(4, 'APA', 'POL004', '2025-04-01', '2026-03-31'),
(5, 'CIC', 'POL005', '2025-05-01', '2026-04-30'),
(6, 'UAP', 'POL006', '2025-06-01', '2026-05-31'),
(7, 'Heritage', 'POL007', '2025-07-01', '2026-06-30');


INSERT INTO Maintenance (CarID, MaintenanceDate, Description, Cost)
VALUES
(1, '2025-05-10', 'Oil change', 3000.00),
(2, '2025-04-20', 'Brake replacement', 12000.00),
(3, '2025-03-15', 'Tire replacement', 8000.00),
(4, '2025-02-10', 'Engine tune-up', 15000.00),
(5, '2025-01-05', 'Suspension repair', 20000.00),
(6, '2024-12-01', 'Air filter change', 2500.00),
(7, '2024-11-15', 'Battery replacement', 10000.00);


INSERT INTO Reservation (CarID, CustomerID, ReservationDate, PickupDate, ReturnDate)
VALUES
(1, 1, '2025-09-25', '2025-10-01', '2025-10-05'),
(2, 2, '2025-09-15', '2025-09-20', '2025-09-25'),
(3, 3, '2025-09-05', '2025-09-10', '2025-09-15'),
(4, 4, '2025-07-25', '2025-08-01', '2025-08-10'),
(5, 5, '2025-07-10', '2025-07-15', '2025-07-20'),
(6, 6, '2025-05-25', '2025-06-01', '2025-06-03'),
(7, 7, '2025-05-01', '2025-05-05', '2025-05-07');
GO


UPDATE Car SET Availability = 0 WHERE CarID = 1;

DELETE FROM Payment WHERE BookingID = 1;
DELETE FROM Booking WHERE BookingID = 1;
