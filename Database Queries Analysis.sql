/* Count the Number of Patients by Gender */
SELECT gender, COUNT(*) AS Total_Patients
FROM healthcare.patient
GROUP BY 1;

/* Number of Patients per Hospital */ 
SELECT h.hospital, COUNT(p.patient_id) AS Total_Patients
FROM healthcare.patient p
LEFT JOIN healthcare.hospital h 
	ON p.hospital_id = h.hospital_id
GROUP BY 1
ORDER BY 2 DESC;

/* Number of Appointment per Doctor*/
SELECT d.doctor_name, COUNT(pc.patient_id) AS Appointments
FROM healthcare.doctors d
JOIN healthcare.patient_condition pc
	ON d.doctor_id = pc.doctor_id
GROUP BY 1
ORDER BY 2 DESC;

/* Find the Earliest and Latest Admission Dates */
SELECT 
    MIN(date_of_admission) AS Earliest_Admission,
    MAX(date_of_admission) AS Latest_Admission
FROM healthcare.appointment;

/* Calculate Average Billing Amount per Insurance Provider */
SELECT insurance_id, AVG(billing_amount) AS Average_Billing
FROM healthcare.patient_billing
GROUP BY 1
ORDER BY 2 DESC;

/* Total Billing by Insurance Provider */
SELECT insurance_id, SUM(billing_amount) AS Total_Collected
FROM healthcare.patient_billing
GROUP BY 1
HAVING SUM(billing_amount) > 100000
ORDER BY 2 DESC;

/* Analyze condition - blood type */ 
SELECT blood_type, medical_condition, COUNT(*) AS total_patients
FROM healthcare.patient_condition
WHERE blood_type LIKE '%AB+%' 
	  AND medical_condition IS NOT NULL
GROUP BY 1, 2
ORDER BY 1, 3 DESC;

/* Number of Doctors by Appointment Type */

SELECT appointment_type, COUNT(*) AS Total_Doctors
FROM healthcare.doctors
GROUP BY 1;

/* --- Count of Each Medical Condition Diagnosed --- */

SELECT medical_condition, COUNT(*) AS Total_Diagnosed
FROM healthcare.patient_condition
GROUP BY 1
ORDER BY 2 DESC;
