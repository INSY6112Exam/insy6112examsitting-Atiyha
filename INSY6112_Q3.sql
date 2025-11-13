-- Create and use database
DROP DATABASE IF EXISTS clinic_db;
CREATE DATABASE clinic_db;
USE clinic_db;

-- Q3.1: Create Patient table
CREATE TABLE Patient (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(100) NOT NULL,
    patient_surname VARCHAR(100) NOT NULL,
    date_of_birth DATE
);

-- Q3.2: Create Doctor table
CREATE TABLE Doctor (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(100) NOT NULL,
    doctor_surname VARCHAR(100) NOT NULL
);

-- Q3.3: Create Appointments table
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    appointment_date DATE NOT NULL,
    appointment_time TIME NOT NULL,
    duration_minutes INT NOT NULL,
    doctor_id INT NOT NULL,
    patient_id INT NOT NULL,
    CONSTRAINT fk_doctor FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    CONSTRAINT fk_patient FOREIGN KEY (patient_id) REFERENCES Patient(patient_id)
);

-- Q3.4: Insert data
INSERT INTO Patient VALUES
(1, 'Debbie', 'Theart', '1980-03-17'),
(2, 'Thomas', 'Duncan', '1976-08-12');

INSERT INTO Doctor VALUES
(1, 'Zintle', 'Nukani'),
(2, 'Ravi', 'Maharaj');

INSERT INTO Appointments VALUES
(1, '2025-01-15', '09:00:00', 15, 2, 1),
(2, '2025-01-18', '15:00:00', 30, 2, 2),
(3, '2025-01-20', '10:00:00', 15, 1, 1),
(4, '2025-01-21', '11:00:00', 15, 2, 1);

-- Q3.5: Appointments between 2025-01-16 and 2025-01-20
SELECT * FROM Appointments
WHERE appointment_date BETWEEN '2025-01-16' AND '2025-01-20';

-- Q3.6: Total appointments per patient
SELECT p.patient_name, p.patient_surname, COUNT(a.appointment_id) AS total_appointments
FROM Patient p
LEFT JOIN Appointments a ON p.patient_id = a.patient_id
GROUP BY p.patient_id
ORDER BY total_appointments DESC;

-- Q3.7: View for patients with doctor ID 2
CREATE OR REPLACE VIEW patients_with_doc2 AS
SELECT DISTINCT p.patient_name, p.patient_surname
FROM Patient p
JOIN Appointments a ON p.patient_id = a.patient_id
WHERE a.doctor_id = 2
ORDER BY p.patient_surname ASC;

SELECT * FROM patients_with_doc2;