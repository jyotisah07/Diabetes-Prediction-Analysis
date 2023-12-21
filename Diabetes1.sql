--1. Retrieve the Patient_id and ages of all patients.
SELECT patient_id,age FROM patientdata;

--2. Select all female patients who are older than 40.
 SELECT * FROM patientdata 
where Gender='Female' and age>40;

--3. Calculate the average BMI of patients.
SELECT AVG(bmi) AS Averagebmi FROM patientdata;

--4. List patients in descending order of blood glucose levels.
SELECT * FROM patientdata
ORDER BY blood_glucose_level DESC;

--5. Find patients who have hypertension and diabetes.
SELECT employeename, patient_id, age, gender, hypertension, diabetes FROM patientdata
WHERE hypertension=1 and diabetes=1;

--6. Determine the number of patients with heart disease.
SELECT COUNT(patient_id) AS heart_disease_patient FROM patientdata
WHERE heart_disease=1 ;

--7. Group patients by smoking history and count how many smokers and nonsmokers there are.
SELECT smoking_history, COUNT(*) FROM patientdata
WHERE smoking_history='current' OR smoking_history='never'
GROUP BY smoking_history;

--8. Retrieve the Patient_ids of patients who have a BMI greater than the average BMI.
SELECT patient_id, bmi FROM patientdata
WHERE bmi> (SELECT AVG(bmi) FROM patientdata);

--9. Find the patient with the highest HbA1c level and the patient with the lowest HbA1clevel.
SELECT patient_id, employeename, hba1c_level AS MAXhba1c_level FROM patientdata  
ORDER BY hba1c_level DESC
LIMIT 1;

--10. Calculate the age of patients in years (assuming the current date as of now).
SELECT employeename,
patient_id,
age AS currentage,
EXTRACT (YEAR FROM CURRENT_DATE) - age AS birthyear
FROM patientdata;

--11. Rank patients by blood glucose level within each gender group.
SELECT
  patient_id,
  gender,
  blood_glucose_level,
  RANK() OVER (PARTITION BY gender ORDER BY blood_glucose_level) AS glucose_rank
FROM patientdata;

--12. Update the smoking history of patients who are older than 50 to "Ex-smoker."
UPDATE patientdata
SET smoking_history = 'Ex-smoker'
WHERE age > 50;
SELECT * FROM patientdata
WHERE age > 50;

--13. Insert a new patient into the database with sample data.
INSERT INTO patientdata (employeename, patient_id, gender, age, hypertension, heart_disease, smoking_history, bmi, HbA1c_level, blood_glucose_level, diabetes)
VALUES
  ('Rohan', 'PT100102', 'Male', 45, 0, 0, 'never', 25.5, 5.8, 110, 0);
SELECT * FROM patientdata
WHERE = 'PT100102';

--14. Delete all patients with heart disease from the database.
DELETE FROM patientdata
WHERE heart_disease = 1;

--15. Find patients who have hypertension but not diabetes using the EXCEPT operator.
SELECT patient_id, hypertension, diabetes
FROM patientdata
WHERE hypertension = 1
EXCEPT
SELECT patient_id, hypertension, diabetes
FROM patientdata
WHERE hypertension = 1 AND diabetes = 1;

--16. Define a unique constraint on the "patient_id" column to ensure its values are unique.
ALTER TABLE patientdata
ADD CONSTRAINT unique_patient_id UNIQUE (patient_id);

--17. Create a view that displays the Patient_ids, ages, and BMI of patients.
CREATE VIEW patient_summary_view AS
SELECT patient_id, age, bmi
FROM patientdata;
SELECT * FROM patient_summary_view;
