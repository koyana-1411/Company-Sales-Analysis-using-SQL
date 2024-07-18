/*CREATE A TABLE BY THE NAME EMPLOYEE_DETAILS*/
CREATE TABLE employee_details
(
Emp_id INT PRIMARY KEY,
First_name VARCHAR(40),
Last_name VARCHAR(40),
Birth_date DATE,
Gender VARCHAR(1),
salary INT,
Super_id INT,
Branch_id INT
);
ALTER TABLE employee_details
ADD FOREIGN KEY(Super_id) REFERENCES employee_details(Emp_id) ON DELETE SET NULL;


/*CREATE A TABLE BY THE NAME BRANCH*/
CREATE TABLE branch_details
(
Branch_id INT PRIMARY KEY,
Branch_name VARCHAR(40),
Mgr_id INT,
Mgr_start_date DATE
);

ALTER TABLE employee_details
ADD FOREIGN KEY(Branch_id) REFERENCES branch_details(Branch_id) ON DELETE SET NULL;

DESCRIBE employee_details;

ALTER TABLE branch_details
ADD FOREIGN KEY(Mgr_id) REFERENCES employee_details(Emp_id) ON DELETE SET NULL;

DESCRIBE branch_details;

CREATE TABLE client(
    Client_id INT,
    Client_name VARCHAR(40),
    Branch_id INT,
    PRIMARY KEY(client_id),
    FOREIGN KEY(Branch_id) REFERENCES branch_details(Branch_id) ON DELETE SET NULL
);

DESCRIBE client;

CREATE TABLE works_with(
    Emp_id INT,
    Client_id INT,
    Total_sales VARCHAR(40),
    PRIMARY KEY(Emp_id, Client_id)
);

DESCRIBE works_with;

ALTER TABLE works_with
ADD FOREIGN KEY(Emp_id) REFERENCES employee_details(Emp_id) ON DELETE CASCADE;

ALTER TABLE works_with
ADD FOREIGN KEY(Client_id) REFERENCES client(Client_id) ON DELETE CASCADE;

CREATE TABLE branch_supplier(
        Branch_id INT,
        Supplier_name VARCHAR(40),
        Supply_type VARCHAR(40),
        PRIMARY KEY(Branch_id, Supplier_name),
        FOREIGN KEY(Branch_id) REFERENCES branch_details(Branch_id) ON DELETE CASCADE
);

DESCRIBE branch_supplier;

INSERT INTO employee_details VALUES(100,'David','Wallace','1967-11-17','M',250000,NULL,NULL);
INSERT INTO employee_details VALUES(101,'Jan','Levinson','1961-05-11','F','110000',100,NULL);
INSERT INTO employee_details VALUES(102,'Michael','Scott','1964-03-15','M',75000,100,NULL);
INSERT INTO employee_details VALUES(103,'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, NULL);
INSERT INTO employee_details VALUES(104, 'Kelly', 'Kapoor', '1980-02-05' ,'F', 55000, 102, NULL);
INSERT INTO employee_details VALUES(105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, NULL);
INSERT INTO employee_details VALUES(106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, NULL);
INSERT INTO employee_details VALUES(107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, NULL);
INSERT INTO employee_details VALUES(108, 'Jim', 'Halpert', '1978-10-01', 'M' ,71000, 106 ,NULL);

DESCRIBE employee_details;
select * from employee_details;

INSERT INTO branch_details VALUES(1,'Corporate',100,'2006-02-09');
INSERT INTO branch_details VALUES(2, 'Scranton', 102, '1992-04-06');
INSERT INTO branch_details VALUES(3,'Stamford', 106, '1998-02-13');

select * from branch_details;

UPDATE employee_details
SET Branch_id =1
WHERE Emp_id=100;

select * from employee_details;

UPDATE employee_details
SET Branch_id=1
WHERE Emp_id=101;

UPDATE employee_details
SET Branch_id=2
WHERE Emp_id=102 OR Emp_id=103 OR Emp_id=104 OR Emp_id=105;

UPDATE employee_details
SET Branch_id=3
WHERE Emp_id=106 OR Emp_id=107 OR Emp_id=108;

select * from employee_details;

INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country', 2);
INSERT INTO client VALUES(402, 'FedEx', 3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3);
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper',3);
INSERT INTO client VALUES(406, 'FedEx' ,2);

select * from client;

INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 22500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);

select * from works_with;

INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Lables', 'Custom Forms');

select * from branch_supplier;
/* Find all employees*/

select First_name,Last_name from employee_details;

/* Find all clients*/
select Client_name,Client_id from client;

/* Find all employees order by salary*/
select First_name,Last_name,Salary from employee_details order by Salary desc;

/* Find all employees ordered by gender then name*/
select First_name,Last_name,Gender from employee_details order by Gender, First_name;

/* Find first 5 employees*/
select * from employee_details LIMIT 5;

/*Find out all the different genders*/
select Gender from employee_details GROUP BY Gender;

/*Find all male employees*/
select First_name,Last_name from employee_details where Gender='M';

/*Find all emplyees at branch 2*/
select First_name,Last_name from employee_details where Branch_id=2;

/*Find all employee's id's and names who were born after 1969*/
select Emp_id,First_name,Last_name from employee_details where Birth_date>=1970-01-01;

/*Find all female employees at branch 2*/
select Emp_id,First_name,Last_name from employee_details where Gender='F' and Branch_id=2;

/*Find all employees who are female & born after 1969 or who make over 80000*/
select Emp_id,First_name,Last_name,Salary from employee_details where (Gender='F' and Birth_date>='1970-01-01') or Salary>80000;

/*Find all employees born between 1970 and 1975*/
select First_name,Last_name from employee_details where Birth_date between '1970-01-01' and '1975-12-31';

/*Find all employees named Jim, Michael, Johnny or David*/
select Emp_id,First_name,Last_name from employee_details where First_name in('Jim','Michael','Johny','David');

/*Find no of employees*/
select count(Emp_id) from employee_details;

/*Find the average of all employee's salaries*/
select avg(Salary) from employee_details;

/*Find sum of employee's salaries*/
select sum(Salary) from employee_details;

/*Find out how many males and females there are*/
select count(Gender),Gender from employee_details group by Gender;

/*Find the total sales of each salesman*/
select Emp_id,sum(Total_sales) from works_with group by Emp_id;

/*Find the total amount of money spent by each client*/
select Client_id,sum(Total_sales)from works_with group by Client_id;

/*Find any branch suppliers who are in the label business*/
select * from branch_supplier where Supplier_name like '%labels%';

/*Find any clients who are schools*/
select * from client where Client_name like '%school%';

/*Find a list of employees and branch names*/
select First_name from employee_details
UNION
select Branch_name from branch_details;

/*Find a list of all clients & branch suppliers' names*/
SELECT client_name
FROM client
UNION
SELECT Supplier_name
FROM branch_supplier;
/*Add extra branch values*/
INSERT INTO branch_details VALUES(4, "Buffalo", NULL, NULL);

/*JOINS*/
select e.Emp_id,e.First_name,b.Branch_name
from employee_details e
JOIN branch_details b
on e.Emp_id=b.Mgr_id;

/* find all employees who sold over 50000*/
select e.Emp_id,e.First_name,w.Total_sales
from employee_details e
JOIN works_with w
on e.Emp_id=w.Emp_id
where w.Total_sales>50000;

SELECT First_name
FROM employee_details
WHERE Emp_id IN(
    SELECT Emp_id
    FROM works_with
    WHERE Total_sales>50000

);
/*Find all clients who are handles by the branch that 
Michael Scott manages -- Assume you know Michael's ID*/
SELECT Client_name, Branch_id
FROM client
WHERE Branch_id IN(
    SELECT Branch_id
   FROM branch_details
   WHERE Mgr_id=102

);
/*Find the names of employees who work with clients handled by 
the Scranton branch*/
select First_name,Last_name from employee_details
where Emp_id in(select Emp_id from works_with
where Client_id in(select Client_id from client
where Branch_id in(select Branch_id from branch_details 
where Branch_name='Scranton')
)
);
/*Find the names of all clients who have spent more than 100,000 dollars*/
select Client_name from Client 
where Client_id in (select client_id from works_with
where Total_sales>10000);
/*INNER JOIN-FIND EMPLOYEES AND THEIR BRANCH DETAILS*/

SELECT e.Emp_id, e.First_name, e.Last_name, b.Branch_name
FROM employee_details e
INNER JOIN branch_details b ON e.Branch_id = b.Branch_id;

/*SELF JOIN -FIND ALL EMPLOYEES AND THEIR MANAGERS*/
select e.Emp_id as employee_id,e.First_name as employee_first_name,e.Last_name as employee_last_name,
m.Emp_id as Manager_id,m.First_name as manager_first_name,m.Last_name as manager_last_name
from employee_details e
join employee_details m on e.Super_id=m.Emp_id;

/*CROSS JOIN-LIST ALL POSSIBLE EMPLOYEES AND CLIENT PAIRS*/
select e.First_name as Employee_first_name,e.Last_name as Employee_last_name,
c.Client_name
from employee_details e
cross join Client c;
/*Left Outer Join (Employees and their clients, including employees with no clients)*/
SELECT e.Emp_id, e.First_name, e.Last_name, w.Client_id, c.Client_name
FROM employee_details e
LEFT OUTER JOIN works_with w ON e.Emp_id = w.Emp_id
LEFT OUTER JOIN Client c ON w.Client_id = c.Client_id;
/*Right Outer Join (Clients and their employees, including clients with no employees)*/
SELECT c.Client_id, c.Client_name, w.Emp_id, e.First_name, e.Last_name
FROM Client c
RIGHT OUTER JOIN works_with w ON c.Client_id = w.Client_id
RIGHT OUTER JOIN employee_details e ON w.Emp_id = e.Emp_id;

/*Full Outer Join (All employees and clients, including those without a match*/
SELECT e.Emp_id, e.First_name, e.Last_name, c.Client_id, c.Client_name
FROM employee_details e
LEFT OUTER JOIN works_with w ON e.Emp_id = w.Emp_id
LEFT OUTER JOIN Client c ON w.Client_id = c.Client_id
UNION
SELECT e.Emp_id, e.First_name, e.Last_name, c.Client_id, c.Client_name
FROM employee_details e
RIGHT OUTER JOIN works_with w ON e.Emp_id = w.Emp_id
RIGHT OUTER JOIN Client c ON w.Client_id = c.Client_id;

/*creating views/*
/*Employeebranchdetails*/
CREATE VIEW EmployeeDetails AS
SELECT 
    e.Emp_id,
    e.First_name,
    e.Last_name,
    e.Birth_date,
    e.Gender,
    e.Salary,
    e.Super_id,
    e.Branch_id,
    b.Branch_name,
    b.Mgr_id,
    b.Mgr_start_date
FROM 
    employee_details e
JOIN 
    branch_details b ON e.Branch_id = b.Branch_id;
select * from EmployeeDetails;
-- Alter the works_with table to change the Total_sales column type to INT
ALTER TABLE works_with MODIFY Total_sales INT;
describe works_with;
/*employee sales*/
CREATE VIEW EmployeeSales AS
SELECT 
    e.Emp_id,
    e.First_name,
    e.Last_name,
    COALESCE(SUM(w.Total_sales), 0) AS Total_sales
FROM 
    employee_details e
LEFT JOIN 
    works_with w ON e.Emp_id = w.Emp_id
GROUP BY 
    e.Emp_id, e.First_name, e.Last_name;
select * from EmployeeSales;
