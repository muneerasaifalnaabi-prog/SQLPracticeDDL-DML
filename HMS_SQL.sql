CREATE DATABASE HospitalManagementDB;
USE HospitalManagementDB;

CREATE TABLE PATIENT(
PID INT PRIMARY KEY,
FNAME VARCHAR(35) NOT NULL,
LNAME VARCHAR(35) NOT NULL,
Email VARCHAR(100) NOT NULL,
DOB DATE NOT NULL,
Adress VARCHAR(300),
Blood_Group VARCHAR(5)
);

CREATE TABLE PATIENT_PHONENO(
PID INT NOT NULL,
Phone_number VARCHAR(20) NOT NULL,
PRIMARY KEY (PID,Phone_number),
FOREIGN  KEY (PID) REFERENCES Patient(PID) 
);

CREATE TABLE Doctor (
D_ID INT PRIMARY KEY,
Name VARCHAR(100) NOT NULL,
Email VARCHAR(100) NOT NULL,
Specilization VARCHAR(100) NOT NULL,
Experience_Year INT CHECK (Experience_Year >= 0),
Sup_ID INT,
Qualification VARCHAR(200) NOT NULL,
Licence_No VARCHAR(50),
FOREIGN  KEY (Sup_ID) REFERENCES Doctor(D_ID) 
);

CREATE TABLE DOCTOR_PHONENO(
D_ID INT NOT NULL,
Phone_number VARCHAR(20) NOT NULL,
PRIMARY KEY (D_ID,Phone_number),
FOREIGN  KEY (D_ID) REFERENCES Doctor(D_ID) 
);

CREATE TABLE Department (
DNUM INT PRIMARY KEY,
DNAME VARCHAR(100) NOT NULL,
MANAGER_ID INT,
LOCATION VARCHAR(200),
CONTACT_NO VARCHAR(20),
FOREIGN KEY(MANAGER_ID) REFERENCES Doctor(D_ID)
);

CREATE TABLE Service (
SER_ID INT PRIMARY KEY ,
SNAME VARCHAR(100) NOT NULL,
UNIT_PRICE DECIMAL CHECK (UNIT_PRICE>=0),
DESCRIPTION VARCHAR(500) ,
SERVICE_TYPE VARCHAR(100) NOT NULL,
DNUM INT ,
FOREIGN KEY(DNUM) REFERENCES Department(DNUM)
);

CREATE TABLE Appointment (
AP_ID INT PRIMARY KEY ,
Date DATE NOT NULL ,
Time TIME ,
REASON VARCHAR(300) NOT NULL,
STATUS VARCHAR(300) NOT NULL,
TYPE VARCHAR(50),
PID INT ,
DID INT ,
FOREIGN KEY(PID) REFERENCES PATIENT(PID),
FOREIGN KEY(DID) REFERENCES Doctor(D_ID),
);

CREATE TABLE Appointment_Service (
AP_ID INT NOT NULL ,
SERV_ID INT NOT NULL ,
QUANTITY INT CHECK (QUANTITY >0),

PRIMARY KEY (AP_ID,SERV_ID),
FOREIGN KEY (AP_ID ) REFERENCES Appointment(AP_ID),
FOREIGN KEY (SERV_ID ) REFERENCES Service(SER_ID)
);

CREATE TABLE Bill (
BID INT PRIMARY KEY,
TOTAL DECIMAL NOT NULL ,
STATUS VARCHAR(35),
PAYMENT_METHOD VARCHAR(50),
AP_ID INT NOT NULL,
PID INT NOT NULL,
FOREIGN KEY (AP_ID ) REFERENCES Appointment(AP_ID),
FOREIGN KEY (PID ) REFERENCES PATIENT(PID)
);

CREATE TABLE Medical_Record (
RECO_ID INT  PRIMARY KEY ,
Date DATE  NOT NULL ,
DIAGNOSIS VARCHAR(50) NOT NULL,
TREATMENT_PLANE VARCHAR(300),
FOLLOW_UP DATE ,
PRE_MED VARCHAR(100) NOT NULL,
NOTE VARCHAR(300) ,
PID INT NOT NULL ,
AP_ID INT NOT NULL,
DID INT NOT NULL ,
FOREIGN KEY (AP_ID ) REFERENCES Appointment(AP_ID),
FOREIGN KEY (PID ) REFERENCES PATIENT(PID),
FOREIGN KEY (DID ) REFERENCES Doctor(D_ID)

);

ALTER TABLE Doctor 
ADD DNUM INT ;

ALTER TABLE Doctor
ADD FOREIGN KEY (DNUM ) REFERENCES Department(DNUM);



--INSERT 6 PATIENT 
INSERT INTO PATIENT 
(PID, FNAME, LNAME, Email, DOB, Adress, Blood_Group) VALUES
(1, 'Ahmed', 'Al-Balushi', 'ahmed@gmail.com', '1998-05-12', 'Muscat', 'A+'),

(2, 'Fatma', 'Al-Harthy', 'fatma@gmail.com', '2001-08-20', 'Sohar', 'B+'),

(3, 'Salim', 'Al-Rawahi', 'salim@gmail.com', '1995-03-15', 'Nizwa', 'O+'),

(4, 'Maha', 'Al-Lawati', 'maha@gmail.com', '1999-11-10', 'Salalah', 'AB+'),

(5, 'Noor', 'Al-Hinai', 'noor@gmail.com', '2003-01-25', 'Muscat', 'A-'),

(6, 'Khalid', 'Al-Kindi', 'khalid@gmail.com', '1997-07-18', 'Ibri', 'O-');


--INSERT PATIENT PHONE NUMBER 
INSERT INTO PATIENT_PHONENO
(PID, Phone_number)
VALUES
(1, '91234567'),
(2, '92345678'),
(3, '93456789'),
(4, '94567890'),
(5, '95678901'),
(6, '96789012');


--INSERT DOCTOR 
INSERT INTO Doctor
(D_ID, Name, Email, Specilization, Experience_Year,
 Sup_ID, Qualification, Licence_No)
VALUES

(101, 'Dr. Ali Hassan', 'ali@hospital.com','Cardiology', 10, NULL,
 'MBBS Cardiology', 'LIC1001'),

(102, 'Dr. Sara Ahmed', 'sara@hospital.com','Dermatology', 7, 101,
 'MBBS Dermatology', 'LIC1002'),

(103, 'Dr. Mohammed Saleh', 'mohammed@hospital.com','Orthopedics', 12, 101,
 'MBBS Orthopedics', 'LIC1003'),

(104, 'Dr. Aisha Noor', 'aisha@hospital.com','Neurology', 8, 102,
 'MBBS Neurology', 'LIC1004');

 --INSERT DOCTOR PHONE NUMBER  
 INSERT INTO DOCTOR_PHONENO(D_ID, Phone_number) VALUES
(101, '90001111'),(102, '90002222'),(103, '90003333'),(104, '90004444');


--INSERT DEPARTMENT 
INSERT INTO Department
(DNUM, DNAME, MANAGER_ID, LOCATION, CONTACT_NO) VALUES
(1, 'Cardiology Department', 101,'Muscat Building A', '22001111'),
(2, 'Dermatology Department', 102,'Muscat Building B', '22002222'),
(3, 'Orthopedics Department', 103,'Sohar Building C', '22003333'),
(4, 'Neurology Department', 104,'Salalah Building D', '22004444');


UPDATE Doctor SET DNUM = 1 WHERE D_ID = 101;
UPDATE Doctor SET DNUM = 2 WHERE D_ID = 102;
UPDATE Doctor SET DNUM = 3 WHERE D_ID = 103;
UPDATE Doctor SET DNUM = 4 WHERE D_ID = 104;


--INSERT SERVICE 
INSERT INTO Service
(SER_ID, SNAME, UNIT_PRICE, DESCRIPTION,
 SERVICE_TYPE, DNUM) VALUES
(1, 'Heart Checkup', 50,'Complete heart examination','Medical', 1),
(2, 'Skin Treatment', 40,'Skin allergy treatment','Medical', 2),
(3, 'Bone X-Ray', 35,'Orthopedic X-Ray service','Radiology', 3),
(4, 'Brain Scan', 80, 'Neurology MRI scan','Radiology', 4);

--INSERT APPOINTMENT 
INSERT INTO Appointment
(AP_ID, Date, Time, REASON, STATUS,
 TYPE, PID, DID) VALUES
(1, '2026-05-01', '09:00:00','Heart pain', 'Completed','Consultation', 1, 101),
(2, '2026-05-02', '10:30:00','Skin rash', 'Completed','Consultation', 2, 102),
(3, '2026-05-03', '11:00:00','Back pain', 'Pending','Checkup', 3, 103),
(4, '2026-05-04', '01:00:00','Migraine headache', 'Completed','Consultation', 4, 104),
(5, '2026-05-05', '02:30:00', 'Chest checkup', 'Completed','Follow-up', 1, 101),
(6, '2026-05-06', '09:45:00','Skin follow-up', 'Pending', 'Follow-up', 2, 102),
(7, '2026-05-07', '03:15:00','Knee injury', 'Completed','Emergency', 5, 103),
(8, '2026-05-08', '12:00:00','Nerve pain', 'Scheduled','Consultation', 6, 104);

--INSERT APPOINTMENT SERVICE 
INSERT INTO Appointment_Service(AP_ID, SERV_ID, QUANTITY) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 1),
(4, 4, 1),
(5, 1, 1),
(6, 2, 2),
(7, 3, 1),
(8, 4, 1);

--INSERET BILL 
INSERT INTO Bill
(BID, TOTAL, STATUS, PAYMENT_METHOD,AP_ID, PID) VALUES
(1, 50, 'Paid', 'Cash', 1, 1),
(2, 40, 'Paid', 'Card', 2, 2),
(3, 35, 'Pending', 'Cash', 3, 3),
(4, 80, 'Paid', 'Insurance', 4, 4),
(5, 50, 'Paid', 'Card', 5, 1),
(6, 80, 'Pending', 'Cash', 6, 2),
(7, 35, 'Paid', 'Cash', 7, 5),
(8, 80, 'Pending', 'Insurance', 8, 6);

--INSERT MENDICAL RECORDS 
INSERT INTO Medical_Record
(RECO_ID, Date, DIAGNOSIS,
 TREATMENT_PLANE, FOLLOW_UP,
 PRE_MED, NOTE, PID, AP_ID, DID) VALUES
(1, '2026-05-01', 'Heart Disease','Medication and rest', '2026-06-01', 'Aspirin','Patient stable',1, 1, 101),
(2, '2026-05-02', 'Skin Allergy','Skin cream treatment','2026-05-20','Antihistamine','Avoid dust',2, 2, 102),
(3, '2026-05-03', 'Back Injury','Physical therapy','2026-06-10','Painkiller','Need exercise', 3, 3, 103),
(4, '2026-05-04', 'Migraine','Neurology treatment','2026-06-15','Ibuprofen','Regular sleep needed',4, 4, 104);

--UPDATE PATIENT AGE  
 UPDATE PATIENT SET DOB ='1999-05-12' WHERE PID =1;

 --CHANGE DOCTOR SPECIALTY
UPDATE Doctor SET Specilization = 'Pediatrics' WHERE D_ID = 102;

-- UPDATE APPOINTMENT DATE
UPDATE Appointment SET Date = '2026-05-15' WHERE AP_ID = 3;

-- CORRECT PATIENT NAME SPELLING
UPDATE PATIENT SET FNAME = 'Mohammed'WHERE PID = 4;

-- REASSIGN APPOINTMENT TO ANOTHER DOCTOR
UPDATE Appointment SET DID = 104 WHERE AP_ID = 7;

-- DELETE A PATIENT RECORD BY PATIENT ID
DELETE FROM Medical_Record WHERE PID = 6;
DELETE FROM Bill WHERE PID = 6;
DELETE FROM Appointment_Service WHERE AP_ID IN (SELECT AP_ID FROM Appointment WHERE PID = 6);
DELETE FROM Appointment WHERE PID = 6; 
DELETE FROM PATIENT_PHONENO WHERE PID = 6;
DELETE FROM PATIENT WHERE PID = 6;

--REMOVE A DOCTOR WHO IS NO LONGER WORKING

DELETE FROM Medical_Record WHERE DID = 104;
DELETE FROM Appointment_Service WHERE AP_ID IN (SELECT AP_ID FROM Appointment WHERE DID = 104);
DELETE FROM Bill WHERE AP_ID IN (SELECT AP_ID FROM Appointment WHERE DID = 104);
DELETE FROM Appointment WHERE DID = 104;
UPDATE Department SET MANAGER_ID = NULL WHERE MANAGER_ID = 104;
UPDATE Doctor SET Sup_ID = NULL WHERE Sup_ID = 104;
DELETE FROM DOCTOR_PHONENO WHERE D_ID = 104;
DELETE FROM Doctor WHERE D_ID = 104;

-- DELETE A COMPLETED OR CANCELED APPOINTMENT
DELETE FROM Appointment_Service WHERE AP_ID = 3;
DELETE FROM Bill WHERE AP_ID = 3;
DELETE FROM Medical_Record WHERE AP_ID = 3;
DELETE FROM Appointment WHERE AP_ID = 3
AND STATUS IN ('Completed', 'Canceled');


-- REMOVE PATIENTS WITH INVALID OR MISSING DATA
DELETE FROM PATIENT WHERE Email IS NULL OR FNAME IS NULL OR LNAME IS NULL;

-- DELETE ALL APPOINTMENTS FOR A SPECIFIC DOCTOR
DELETE FROM Appointment_Service WHERE AP_ID IN (SELECT AP_ID FROM Appointment WHERE DID = 102);
DELETE FROM Bill WHERE AP_ID IN (SELECT AP_ID FROM Appointment WHERE DID = 102);
DELETE FROM Medical_Record WHERE DID = 102;
DELETE FROM Appointment WHERE DID = 102;

--DROP TABLE APPOINTMENT SERVICE 
DROP TABLE Appointment_Service ;

--DROP PATIENT PHONE TABLE 
DROP TABLE PATIENT_PHONENO;
--TEST 
SELECT * FROM PATIENT WHERE PID = 1;
SELECT * FROM Doctor WHERE D_ID = 102;
SELECT * FROM Appointment WHERE AP_ID = 3;
SELECT * FROM PATIENT WHERE PID = 4;
SELECT * FROM Appointment WHERE AP_ID = 7;

SELECT * FROM PATIENT WHERE PID = 6;
SELECT * FROM Doctor WHERE D_ID = 104;
SELECT * FROM Appointment WHERE AP_ID = 3;
SELECT * FROM Appointment WHERE DID = 102;
