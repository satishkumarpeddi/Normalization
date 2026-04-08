       -- id PK        name    age     branch  hod issue
       --  1       Ravi    20      CSE     Dr. Sharma
       --  2       Priya   21      CSE     Dr. Sharma
       --  3       Arun    22      ECE     Dr. Mehta
       --  4       Sneha   20      ECE     Dr. Mehta
       
        -- Removing The Partial-dependency anonmaly
        
        -- Id -> name, age ,branch --> Student Table
        -- Id -> branch, hod issue --> Branch Table 
        create table branch(branch_id varchar2(50) primary key,hod_issue varchar2(50) not null); 
        
        create table student(id int primary key,name varchar2(50),age int check(age>18),branch varchar2(50) not null,foreign key(branch) references branch(branch_id));
        
        -- Insert branch data first (parent table)
        INSERT INTO branch VALUES ('CSE', 'Dr. Sharma');
        INSERT INTO branch VALUES ('ECE', 'Dr. Mehta');

        -- Then insert students
        INSERT INTO student VALUES (1, 'Ravi',  20, 'CSE');
        INSERT INTO student VALUES (2, 'Priya', 21, 'CSE');
        INSERT INTO student VALUES (3, 'Arun',  22, 'ECE');
        INSERT INTO student VALUES (4, 'Sneha', 20, 'ECE');
        
        SELECT 
            s.id,
            s.name,
            s.age,
            s.branch,
            b.hod_issue
        FROM student s
        JOIN branch b
        ON s.branch = b.branch_id;
     