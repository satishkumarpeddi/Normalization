
/* Starting point — tables after 2NF

student
id PK        name    age     branch FK
1       Ravi    20      CSE
2       Priya   21      CSE
3       Arun    22      ECE
branch

branch PK       hod
CSE     Dr. Sharma
ECE     Dr. Mehta
These two came from 2NF. Now check each for 3NF.

Extend branch table — add hod_phone to expose 3NF violation
branch (extended — before 3NF)


branch PK       hod     hod_phone issue
        CSE     Dr. Sharma      9876500001
        ECE     Dr. Mehta       9876500002
        MECH    Dr. Mehta       9876500002
Dr. Mehta's phone appears twice. If his number changes, every row for his branches must be updated — update anomaly.
*/

/*Apply 3NF — decompose branch into two tables

student

id PK        name    age     branch FK
1       Ravi    20      CSE
2       Priya   21      CSE
3       Arun    22      ECE
Unchanged from 2NF. Already in 3NF.

branch PK       hod FK

    CSE     Dr. Sharma
    ECE     Dr. Mehta
    MECH    Dr. Mehta

hod_phone removed. hod now points to hod table.

hod PK          hod_phone
Dr. Sharma      9876500001
Dr. Mehta       9876500002
Phone stored once per HOD. No more
*/
CREATE TABLE hod (
  hod_name  VARCHAR(50) PRIMARY KEY,
  hod_phone VARCHAR(15) NOT NULL
);

CREATE TABLE branch (
  branch   VARCHAR(20) PRIMARY KEY,
  hod_name VARCHAR(50),
  FOREIGN KEY (hod_name) REFERENCES hod(hod_name)
);

CREATE TABLE student (
  id     INT PRIMARY KEY,
  name   VARCHAR(50),
  age    INT,
  branch VARCHAR(20),
  FOREIGN KEY (branch) REFERENCES branch(branch)
);

-- Insert HOD data first (no dependencies)
INSERT INTO hod VALUES ('Dr. Sharma', '9876500001');
INSERT INTO hod VALUES ('Dr. Mehta',  '9876500002');

-- Then branch (depends on hod)
INSERT INTO branch VALUES ('CSE',  'Dr. Sharma');
INSERT INTO branch VALUES ('ECE',  'Dr. Mehta');
INSERT INTO branch VALUES ('MECH', 'Dr. Mehta');

-- Then students (depends on branch)
INSERT INTO student VALUES (1, 'Ravi',  20, 'CSE');
INSERT INTO student VALUES (2, 'Priya', 21, 'CSE');
INSERT INTO student VALUES (3, 'Arun',  22, 'ECE');

select * from student s join branch b on s.branch = b.branch;