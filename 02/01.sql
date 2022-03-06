CREATE TABLE
	Absenteeism
	(
		emp_id INTEGER NOT NULL REFERENCES Personnel(emp_id)
		, absent_date DATE NOT NULL
		, reason_code CHAR(40) NOT NULL REFERENCES ExcuseList(reason_code)
		, severirty_points INTEGER NOT NULL CHECK (severirty_points  BETWEEN 0 AND 4)
		, PRIMARY KEY (emp_id, absent_date)
	)
;

UPDATE
	Absenteeism
SET
	severity_points = 0
	, readon_code = 'long term illness'
WHERE
	EXISTS
		(
			SELECT
				*
			FROM
				Absenteeism AS A2
			WHERE
				Absenteeism.emp_id = A2.emp_id
				AND Absenteeism.absent_date = (A2.absent_date + INTERVAL '1' DAY)
		)
;

DELETE FROM
	Personnel1
WHERE
	emp_id = (
		SELECT
			A1.emp_id
		FROM
			Absenteeism AS A1
		WHERE
			A1.emp_id = Personnel1.emp_id
		GROUP BY
			A1.emp_id
		HAVING SUM(severity_points) >= 40
	)
;