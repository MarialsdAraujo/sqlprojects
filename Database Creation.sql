/* ------------------------------ CREATING THE DATABASE AND THE TABLES ------------------------------ */
CREATE DATABASE healthcare;
USE healthcare;
CREATE TABLE hospital (
	hospital_id INT PRIMARY KEY, 
    hospital VARCHAR (50),
    address VARCHAR (100),
    phone_number VARCHAR(50)
);

CREATE TABLE patient (
	patient_id INT PRIMARY KEY,
    name VARCHAR (100),
    age INT NOT NULL,
    gender VARCHAR (50),
    hospital_id INT NOT NULL,
    FOREIGN KEY (hospital_id) REFERENCES hospital (hospital_id)
);
ALTER TABLE patient
ADD COLUMN (room_number INT);

CREATE TABLE doctors (
	hospital_id INT,
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_name VARCHAR (50),
    appointment_type VARCHAR(50),
    FOREIGN KEY (hospital_id) REFERENCES hospital (hospital_id)
);
SHOW CREATE TABLE doctors;
ALTER TABLE doctors DROP FOREIGN KEY doctors_ibfk_1; 	/* delete the foreing key */
ALTER TABLE doctors DROP COLUMN hospital_id;            /* delete a column */

CREATE TABLE appointment_types (
	appointment_id INT UNIQUE PRIMARY KEY,
    appointment_type VARCHAR(50)
);

CREATE TABLE appointment (
    appointment_id INT,
    appointment_type VARCHAR(50),
    patient_id INT,
    date_of_admission DATE,
    doctor_id INT,
    medical_condition_id INT,
    FOREIGN KEY (appointment_id) REFERENCES appointment_types(appointment_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (medical_condition_id) REFERENCES medical_condition(medical_id)
); 

CREATE TABLE insurance (
	insurance_id INT PRIMARY KEY,
    insurance VARCHAR(50),
    phone VARCHAR(50)
);

CREATE TABLE patient_billing (
    patient_id INT PRIMARY KEY,
    billing_amount DECIMAL(10,2),
    insurance_id INT,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    FOREIGN KEY (insurance_id) REFERENCES insurance(insurance_id)
);

CREATE TABLE medical_condition (
	medical_id INT PRIMARY KEY,
    medical_condition VARCHAR(50),
    patient_id INT,
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);
ALTER TABLE medical_condition DROP FOREIGN KEY medical_condition_ibfk_1; 	/* delete the foreing key */
ALTER TABLE medical_condition DROP COLUMN patient_id;            /* delete a column */

/* ------------------------------ INSERT DATA INSIDE THE PREVIOUS TABLE CREATED ------------------------------ */
INSERT INTO healthcare.hospital (hospital_id, hospital, phone_number, address)
VALUES (001, 'Sons and Miller', '(386) 261-0610', '66 Lookout Ave., Redwood Meadows, AB T3Z 5R2'),
	   (002, 'Kim Inc', '(821) 283-6505', '354 Devonshire Avenue, Reserve Mines, NS B1E 3L7'),
       (003, 'Cook PLC', '(401) 894-6842', '615 West Marshall Lane, St. Stephen, NB E3L 0B5'),
       (004, 'Hernandez Rogers and Vang,', '(306) 208-8906', "5 Sulphur Springs St., St. Mary's, ON N4X 7A1"),
       (005, 'White-White', '(974) 469-9503', '840 Penn Street, Farnham, QC J2N 1C4'),
       (006, 'Nunez-Humphrey', '(616) 614-5501', '52 W. Durham Road, Fergus, ON N1M 1C6'),
       (007, 'Group Middleton', '(831) 529-2547', '570 Trenton Drive, York, ON M6C 1K3'),
       (008, 'Powell Robinson and Valdez', '(490) 786-2449', '72 Essex Street, Kedgwick, NB E8B 1K5'),
       (009, 'Sons Rich', '(514) 941-4203', '891 Railroad Dr., Chaudière-Sud, QC G0N 7P9'),
       (010, 'Padilla-Walker','(304) 573-9173', '803 Dogwood Drive, Hampton, NB E5N 5T9'),
       (011, 'Schaefer-Porte', '(510) 850-1728', '9 Bowman Ave., Buena Vista, SK S2V 8E4'),
       (012, 'Lyons-Blair', '(690) 313-8094', '5 Brook Street, Tillsonburg, ON N4G 6C4'),
       (013,  'Powers Miller, and Flores', '(497) 443-9302', '703 East Fairview Ave., Valleyfield, QC J7X 9A7');

INSERT INTO healthcare.patient (patient_id, name, age, gender, hospital_id, room_number)
VALUES (001, 'Bobby Jackson', 30, 'Male', 005, 328),
       (002, 'Leslie Terry', 62,'Male',	003, 265),
       (003, 'Danny Smith', 76, 'Female', 010, 205),
       (004, 'Andrew Watts', 28, 'Female', 011, 450),
       (005, 'Adrienne Bell', 43, 'Female', 006, 458),
       (006, 'Emily Johnson', 36, 'Male', 002, 389),
       (007, 'Edward Edwards', 21, 'Female', 013, 349),
       (008, 'Christina Martinez', 20, 'Female', 009, 277),
       (009, 'Jasmine Aguilar', 82,	'Male', 003, 316),
       (010, 'Christopher Berg', 58, 'Female', 012, 249),
       (011, 'Michelle Daniels', 72, 'Male', 006, 394),
       (012, 'Aaron Martinez', 38, 'Female', 008, 288),
       (013, 'Connor Hansen', 75, 'Female', 001, 134),
       (014, 'Robert Bauer', 68, 'Female', 002, 309),
       (015, 'Brooke Brady', 44, 'Female', 013, 182),
       (016, 'Ms. Natalie Gamble', 46, 'Female', 007, 415),
       (017, 'Haley Perkins', 63, 'Female', 011, 114),
       (018, 'Mrs. Jamie Campbell', 38,	'Male',	010, 449),
       (019, 'Luke Burgess', 34, 'Female', 007, 260),
       (020, 'Daniel Schmidt', 63,	'Male', 009, 465);


INSERT INTO healthcare.doctors (doctor_id, doctor_name, appointment_type)
VALUES (101, 'Matthew Smith', 'Urgent'),
       (102, 'Samantha Davies', 'Emergency'),
       (103, 'Tiffany Mitchell', 'Emergency'),
       (104, 'Kevin Wells', 'Elective'),
       (105, 'Kathleen Hanna', 'Urgent'),
       (108, 'Suzanne Thomas', 'Emergency'),
       (107, 'Kelly Olson', 'Emergency'),
       (109, 'Daniel Ferguson', 'Elective'),
       (106, 'Taylor Newton', 'Urgent'),
       (110, 'Heather Day', 'Elective');

INSERT INTO healthcare.appointment_types (appointment_id, appointment_type)
VALUES (001, 'Urgent'),
	   (002, 'Emergency'),
       (003, 'Elective');

/* -------------- ONE WEAK TABLE - DEPENDENT OF Patient_id AND Appointment_id ------------ */
INSERT INTO healthcare.appointment (appointment_id, appointment_type, patient_id, date_of_admission, doctor_id, medical_condition_id)
VALUES (001, 'Urgent', 001, '2024-01-31', 101, 001),
	   (002, 'Emergency', 002, '2019-08-20', 102, 002),
       (002, 'Emergency', 003, '2022-09-22', 103, 002),
       (003, 'Elective', 004, '2020-11-18', 104, 003),
       (001, 'Urgent', 005, '2022-09-19', 105, 001),
       (001, 'Urgent', 006, '2023-12-20', 106, 004),
       (002, 'Emergency', 007, '2020-11-03', 104, 003),
       (002, 'Emergency', 008, '2021-12-28', 105, 001),
       (003, 'Elective', 009, '2020-07-01', 109, 004),
       (003, 'Elective', 010, '2021-05-23', 110, 001),
       (001, 'Urgent', 011, '2020-04-19', 101, 001),
       (001, 'Urgent', 012, '2023-08-13', 107, 005),
       (002, 'Emergency', 013, '2019-12-12', 104, 003),
       (001, 'Urgent', 014, '2020-05-22', 109, 004),
       (001, 'Urgent', 015, '2021-10-08', 105, 001),
       (003, 'Elective', 016, '2022-01-01', 102, 002),
       (003, 'Elective', 017, '2020-06-23', 108, 006),
       (001, 'Urgent', 018, '2020-03-08', 103, 002),
       (003, 'Elective', 019, '2021-03-04', 107, 005),
       (003, 'Elective', 020, '2022-11-15', 106, 004);

ALTER TABLE healthcare.appointment DROP COLUMN appointment_type;

INSERT INTO healthcare.insurance (insurance_id, insurance, phone)
VALUES (120, 'Blue Cross', '(440) 728-4104'),
	   (121, 'Medicare', '(984) 675-0751'),
       (122, 'Aetna', '(411) 297-0277'),
       (123, 'UnitedHealthcare', '(917) 684-5723'),
       (124, 'Cigna', '(998) 472-9541');

INSERT INTO healthcare.patient_billing (patient_id, billing_amount, insurance_id)
VALUES (001, '18856.28',120),
	   (002, '33643.32', 121),
       (003, '27955.09', 122),
       (004, '3790.97', 121),
       (005, '14238.31', 122),
       (006, '4814.51', 123),
       (007, '1958.08', 121),
       (008, '4582.04', 124),
       (009, '50119.22' , 124),
       (010, '1978.46' , 123),
       (011, '12576.59', 121),
       (012, '7999.58', 121),
       (013, '4328.22', 124),
       (014, '33207.70', 123),
       (015, '40701.59', 123),
       (016, '12263.35', 120),
       (017, '24499.84', 123),
       (018, '17440.46', 124),
       (019, '1884.30', 120),
       (020, '23762.20', 124);
 
INSERT INTO healthcare.medical_condition (medical_id, medical_condition)
VALUES (001, 'Cancer'),
       (002, 'Obesity'),
       (003, 'Diabetes'),
       (004, 'Asthma'),
       (005, 'Hypertension'),
       (006, 'Arthritis');

/* ------------------------------ ADD ONE MORE TABLE (THE WEAK ONE) AND THE VALUES INSIDE IT ------------------------------ */

CREATE TABLE patient_condition (
    doctor_id INT,
    patient_id INT,
    appointment_id INT,
    medical_condition VARCHAR(100),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES patient(patient_id)
);
INSERT INTO patient_condition (doctor_id, patient_id, appointment_id, medical_condition)
SELECT a.doctor_id, a.patient_id, a.appointment_id, mc.medical_condition
FROM appointment a
JOIN patient p 
	ON a.patient_id = p.patient_id
JOIN doctors d 
	ON a.doctor_id = d.doctor_id
JOIN medical_condition mc
	ON mc.medical_id = a.medical_condition_id
LIMIT 20;

ALTER TABLE patient_condition
ADD COLUMN (
    blood_type VARCHAR (10),
    results VARCHAR (25)
);

UPDATE patient_condition SET blood_type = 'B-', results = 'Normal' WHERE patient_id = 1;
UPDATE patient_condition SET blood_type = 'A+', results = 'Inconclusive' WHERE patient_id = 2;
UPDATE patient_condition SET blood_type = 'A-', results = 'Normal' WHERE patient_id = 3;
UPDATE patient_condition SET blood_type = 'O+', results = 'Abnormal' WHERE patient_id = 4;
UPDATE patient_condition SET blood_type = 'AB+', results = 'Abnormal' WHERE patient_id = 5;
UPDATE patient_condition SET blood_type = 'A+', results = 'Normal' WHERE patient_id = 6;
UPDATE patient_condition SET blood_type = 'AB-', results = 'Inconclusive' WHERE patient_id = 7;
UPDATE patient_condition SET blood_type = 'A+', results = 'Inconclusive' WHERE patient_id = 8;
UPDATE patient_condition SET blood_type = 'AB+', results = 'Abnormal' WHERE patient_id = 9;
UPDATE patient_condition SET blood_type = 'AB-', results = 'Inconclusive' WHERE patient_id = 10;
UPDATE patient_condition SET blood_type = 'O+', results = 'Normal' WHERE patient_id = 11;
UPDATE patient_condition SET blood_type = 'A-', results = 'Inconclusive' WHERE patient_id = 12;
UPDATE patient_condition SET blood_type = 'A+', results = 'Abnormal' WHERE patient_id = 13;
UPDATE patient_condition SET blood_type = 'AB+', results = 'Normal' WHERE patient_id = 14;
UPDATE patient_condition SET blood_type = 'AB+', results = 'Normal' WHERE patient_id = 15;
UPDATE patient_condition SET blood_type = 'AB-', results = 'Inconclusive' WHERE patient_id = 16;
UPDATE patient_condition SET blood_type = 'A+', results = 'Normal' WHERE patient_id = 17;
UPDATE patient_condition SET blood_type = 'AB-', results = 'Abnormal' WHERE patient_id = 18;
UPDATE patient_condition SET blood_type = 'A-', results = 'Abnormal' WHERE patient_id = 19;
UPDATE patient_condition SET blood_type = 'B+', results = 'Normal' WHERE patient_id = 20;



select * from healthcare.hospital  -- hospital_id, hospital, address, phone_number --
select * from healthcare.patient   -- patient_id, name, age, gender, hospital_id, room_number --
select * from healthcare.medical_condition -- medical_id, medical_condition --
select * from healthcare.doctors -- doctor_id, doctor_name, appointment_type --
select * from healthcare.insurance -- insurance_id, insurance, phone --
select * from healthcare.patient_billing -- patient_id, billing_amount, insurance_id, --
select * from healthcare.appointment -- appointment_id, patient_id, date_of_admission, doctor_id, medical_condition_id (WEAK TABLE) --
select * from healthcare.appointment_types -- appointment_id, appointment_type --
select * from healthcare.patient_condition -- doctor_id, patient_id, appointment_id, medical_condition, bloody_type, results (WEAK TABLE) -- 
