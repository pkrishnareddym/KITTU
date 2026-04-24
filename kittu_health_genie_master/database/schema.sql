CREATE TABLE patients(
 id SERIAL PRIMARY KEY,
 name VARCHAR(120),
 age INT,
 created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE vitals(
 id SERIAL PRIMARY KEY,
 patient_id INT,
 heart_rate INT,
 oxygen INT,
 temperature NUMERIC,
 created_at TIMESTAMP DEFAULT NOW()
);
