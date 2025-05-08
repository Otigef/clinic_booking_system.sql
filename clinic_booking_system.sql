-- Create Database
CREATE DATABASE ClinicBookingSystem;
USE ClinicBookingSystem;

-- 1. Departments Table (1-M with Doctors)
CREATE TABLE Departments (
    DepartmentID INT AUTO_INCREMENT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE,
    Description TEXT
);

-- 2. Doctors Table (M-M with Specialties via DoctorSpecialties)
CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20),
    DepartmentID INT NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- 3. Patients Table (1-M with Appointments)
CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20),
    DateOfBirth DATE NOT NULL,
    Address TEXT
);

-- 4. Appointments Table (M-M between Patients and Doctors)
CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentTime DATETIME NOT NULL,
    Status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    Notes TEXT,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    UNIQUE (DoctorID, AppointmentTime) -- Prevent double-booking
);

-- 5. Specialties Table (M-M with Doctors via DoctorSpecialties)
CREATE TABLE Specialties (
    SpecialtyID INT AUTO_INCREMENT PRIMARY KEY,
    SpecialtyName VARCHAR(100) NOT NULL UNIQUE,
    Description TEXT
);

-- 6. DoctorSpecialties Junction Table (M-M Relationship)
CREATE TABLE DoctorSpecialties (
    DoctorID INT NOT NULL,
    SpecialtyID INT NOT NULL,
    PRIMARY KEY (DoctorID, SpecialtyID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (SpecialtyID) REFERENCES Specialties(SpecialtyID)
);

-- Insert a department
INSERT INTO Departments (DepartmentName, Description)
VALUES ('Cardiology', 'Heart and cardiovascular system care');

-- Insert a doctor
INSERT INTO Doctors (FirstName, LastName, Email, DepartmentID)
VALUES ('Emily', 'Clark', 'emily.clark@clinic.com', 1);

-- Book an appointment
INSERT INTO Appointments (PatientID, DoctorID, AppointmentTime)
VALUES (1, 1, '2023-10-25 14:30:00');

-- Find all appointments for a patient:
SELECT * FROM Appointments WHERE PatientID = 1;

-- List doctors in the Cardiology department:
SELECT * FROM Doctors WHERE DepartmentID = 1;