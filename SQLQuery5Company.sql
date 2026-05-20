USE COMPANYDB1;

CREATE TABLE Employee1(
    SSN INT PRIMARY KEY,
    BD DATE,
    GENDER VARCHAR(10),
    FNAME VARCHAR(25) NOT NULL,
    LNAME VARCHAR(25) NOT NULL,
    Superid INT,
    DNUM INT
);
CREATE TABLE Employee1_BACKUP(
    SSN INT PRIMARY KEY,
    BD DATE,
    GENDER VARCHAR(10),
    FNAME VARCHAR(25) NOT NULL,
    LNAME VARCHAR(25) NOT NULL,
    Superid INT,
    DNUM INT
);

CREATE TABLE Dept (
    DNUM INT PRIMARY KEY,
    DNAME VARCHAR(35) NOT NULL,
    HIRE_DATE DATE,
    SSN_EMP INT
);

CREATE TABLE Locations (
    DNUM INT NOT NULL,
    LOCATION VARCHAR(100) NOT NULL,
    PRIMARY KEY (DNUM, LOCATION)
);

CREATE TABLE Project (
    PNUM INT PRIMARY KEY,
    PNAME VARCHAR(100) NOT NULL, 
    CITY VARCHAR(100),
    LOCATION VARCHAR(100),
    DNUM INT NOT NULL
);

CREATE TABLE EMP_PRO(
    SSN_ID INT,
    PNUM INT,
    HOURS DECIMAL(5,2),
    PRIMARY KEY (SSN_ID, PNUM)
);

CREATE TABLE Dependent (
    SSN INT,
    DEPENDENT_NAME VARCHAR(100),
    GENDER VARCHAR(10),
    BD DATE,
    PRIMARY KEY (SSN, DEPENDENT_NAME)
);

INSERT INTO Dept (DNUM, DNAME, HIRE_DATE, SSN_EMP) VALUES
(1, 'Human Resources', '2020-01-15', 1),
(2, 'Engineering', '2019-03-10', 2),
(3, 'Marketing', '2020-06-20', 3),
(4, 'Finance', '2018-11-05', 4),
(5, 'Operations', '2021-02-14', 5);


INSERT INTO Employee1 (SSN, BD, GENDER, FNAME, LNAME, Superid, DNUM) VALUES
(101, '1985-05-12', 'Male', 'Ishaq', 'Al-Balushi', NULL, 2),
(102, '1990-08-23', 'Female', 'Fatima', 'Al-Hinai', NULL, 1),
(103, '1988-03-15', 'Male', 'Mohammed', 'Al-Lawati', NULL, 3),
(104, '1992-11-30', 'Female', 'Maryam', 'Al-Siyabi', NULL, 4),
(105, '1987-07-18', 'Male', 'Khalid', 'Al-Harthy', NULL, 5),
(106, '1995-02-25', 'Female', 'Aisha', 'Al-Kindi', 101, 2),
(107, '1993-09-10', 'Male', 'Salem', 'Al-Rawahi', 101, 2),
(108, '1991-04-05', 'Female', 'Latifa', 'Al-Ghafri', 102, 1),
(109, '1994-12-20', 'Male', 'Abdullah', 'Al-Busaidi', 103, 3),
(110, '1989-06-08', 'Female', 'Noor', 'Al-Habsi', 104, 4);

UPDATE Dept SET SSN_EMP = 101 WHERE DNUM = 2;
UPDATE Dept SET SSN_EMP = 103 WHERE DNUM = 3;
UPDATE Dept SET SSN_EMP = 104 WHERE DNUM = 4;
UPDATE Dept SET SSN_EMP = 105 WHERE DNUM = 5;

--insert location 
INSERT INTO Locations (DNUM, LOCATION) VALUES
(1, 'Muscat - Qurum'),
(2, 'Muscat - Al Khuwair'),
(2, 'Sohar Industrial Area'),
(3, 'Muscat - Ruwi'),
(4, 'Muscat - CBD'),
(5, 'Salalah Port'),
(5, 'Nizwa Distribution Center');

--insert project 
INSERT INTO Project (PNUM, PNAME, CITY, LOCATION, DNUM) VALUES
(1, 'E-Government Portal Development', 'Muscat', 'Muscat - Al Khuwair', 2),
(2, 'Tourism Digital Campaign 2024', 'Muscat', 'Muscat - Ruwi', 3),
(3, 'VAT System Implementation', 'Muscat', 'Muscat - CBD', 4),
(4, 'Logistics Network Expansion', 'Salalah', 'Salalah Port', 5),
(5, 'Smart City Mobile Application', 'Muscat', 'Muscat - Al Khuwair', 2),
(6, 'HR Management System', 'Muscat', 'Muscat - Qurum', 1),
(7, 'Financial Reporting Dashboard', 'Muscat', 'Muscat - CBD', 4);

INSERT INTO EMP_PRO (SSN_ID, PNUM, HOURS) VALUES
-- Engineering projects
(101, 1, 40.00),
(106, 1, 35.50),
(107, 1, 38.00),
(111, 5, 40.00),
(101, 5, 20.00),

-- Marketing projects
(103, 2, 42.00),
(109, 2, 40.00),
(113, 2, 35.00),

-- Finance projects
(104, 3, 45.00),
(110, 3, 38.50),
(114, 7, 40.00),
(104, 7, 25.00),

-- Operations projects
(105, 4, 40.00),
(115, 4, 38.00),

-- HR projects
(102, 6, 35.00),
(108, 6, 40.00),
(112, 6, 32.00);

---ADD SALARY ATTRIBUTE 
ALTER TABLE Employee1
ADD SALARY INT;

--ADD SALARY FOR EACH EMPLOYEE
UPDATE Employee1 SET SALARY =9000 WHERE SSN=101;
UPDATE Employee1 SET SALARY =8000 WHERE SSN=102;
UPDATE Employee1 SET SALARY =6000 WHERE SSN=103;
UPDATE Employee1 SET SALARY =9000 WHERE SSN=104;
UPDATE Employee1 SET SALARY =5000 WHERE SSN=105;
UPDATE Employee1 SET SALARY =3000 WHERE SSN=106;
UPDATE Employee1 SET SALARY =2000 WHERE SSN=107;
UPDATE Employee1 SET SALARY =4000 WHERE SSN=108;
UPDATE Employee1 SET SALARY =8000 WHERE SSN=109;
UPDATE Employee1 SET SALARY =2000 WHERE SSN=110;

--INCREASE SALARY FOR Engineering DEPARTMENT BY 10%
UPDATE Employee1 SET SALARY =SALARY*1.10 WHERE DNUM=2;

--Change department name
UPDATE Dept SET DNAME='COMPUTER SCINCE' WHERE DNUM=3;

--Update project name
UPDATE Project SET PNAME = 'Digital Government Services Platform'
WHERE PNUM = 1;

--ASSIGN EMPLOYEE TO ANOTHER DEPT
UPDATE Employee1 SET DNUM=3,Superid =103 WHERE SSN=106;

--CORRECT WRONG SALARY 
UPDATE Employee1 SET SALARY =6000 WHERE SSN=107;

--Delete an employee by EmployeeID 
DELETE FROM Employee1 WHERE SSN=109;

--Remove employees from a specific department
UPDATE Dept SET SSN_EMP = NULL WHERE DNUM = 3;
UPDATE Employee1 SET Superid = NULL WHERE Superid IN (SELECT SSN FROM Employee1 WHERE DNUM = 3);
DELETE FROM Dependent WHERE SSN IN (SELECT SSN FROM Employee1 WHERE DNUM = 3);
DELETE FROM EMP_PRO WHERE SSN_ID IN (SELECT SSN FROM Employee1 WHERE DNUM = 3);
DELETE FROM Employee1 WHERE DNUM = 3;

--Delete inactive project 
DELETE FROM EMP_PRO WHERE PNUM = 6;
DELETE FROM Project WHERE PNUM = 6;

--Remove a department 
UPDATE Employee1 SET DNUM = 2, Superid = 101 WHERE DNUM = 5;
UPDATE Project SET DNUM = 2 WHERE DNUM = 5;
DELETE FROM Locations WHERE DNUM = 5;
DELETE FROM Dept WHERE DNUM = 5;

--Delete employees with salary below 3000 OMR
SELECT SSN, FNAME, LNAME, SALARY, DNUM 
FROM Employee1 
WHERE SALARY < 3000;

--drop table dependent 
DROP TABLE  Dependent;

--REMOVE BACKUP TABLE 
DROP TABLE Employee1_BACKUP;

-- Drop a project-related table after system redesign 
DROP TABLE EMP_PRO;

--TEST 
SELECT SSN, FNAME, LNAME, DNUM, Superid FROM Employee1 WHERE SSN = 106;
SELECT * FROM Dependent WHERE SSN = 112;
SELECT * FROM Dept WHERE SSN_EMP = 112;
SELECT SSN, FNAME, LNAME, DNUM FROM Employee1 WHERE DNUM = 3;
SELECT * FROM Employee1 WHERE DNUM = 3;
SELECT * FROM Project WHERE PNUM = 6;
SELECT * FROM EMP_PRO WHERE PNUM = 6;
SELECT * FROM Project WHERE PNUM = 6;

SELECT * FROM Dept WHERE DNUM = 5;
SELECT * FROM Employee1 WHERE DNUM = 5;
SELECT * FROM Project WHERE DNUM = 5;
SELECT * FROM Locations WHERE DNUM = 5;
SELECT * FROM Dept WHERE DNUM = 5;
SELECT * FROM EMP_PRO;


