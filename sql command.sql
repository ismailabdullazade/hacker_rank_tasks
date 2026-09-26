CREATE TABLE isciler ( id INT PRIMARY KEY, ad VARCHAR(50), sobe VARCHAR(50), maas INT, ise_giris_tarixi DATE );

INSERT INTO isciler (id, ad, sobe, maas, ise_giris_tarixi) VALUES 
(1, 'Əli', 'IT', 3500, '2021-03-01'), 
(2, 'Leyla', 'IT', 4200, '2020-05-15'), 
(3, 'Murad', 'IT', 4200, '2022-01-10'), 
(4, 'Aysel', 'IT', 2800, '2023-06-01'), 
(5, 'Samir', 'Satış', 2000, '2021-09-01'), 
(6, 'Nigar', 'Satış', 2600, '2020-11-20'), 
(7, 'Fərid', 'Satış', 2600, '2022-08-15'), 
(8, 'Rauf', 'HR', 1800, '2022-04-01'), 
(9, 'Günel', 'HR', 2200, '2021-02-10');
-- with siralama as (
-- 	select 
-- 	ad,
-- 	sobe,
-- 	maas,
-- 	dense_rank() OVER(partition by sobe order by maas DESC) as isci_sirasi
-- 	from isciler
-- )
-- select
-- 	ad,
-- 	sobe,
-- 	maas,
--     isci_sirasi
-- from siralama
-- where isci_sirasi<=2;

-- select 
-- 	ad,
-- 	sobe,
-- 	maas,
--     SUM(maas) OVER(partition by sobe order by ise_giris_tarixi ASC) AS Sum_by_dept,
--     maas - LAG(maas) OVER(partition by sobe order by ise_giris_tarixi ASC) AS evvelki_isci_maasin_ferqi
-- from isciler;

/*select
	ad,
	sobe,
	maas,
    AVG(maas) over(partition by sobe) as ortalama_maas,
    maas-AVG(maas) over(partition by sobe) as maas_ferqi
from isciler;


with isci_maas_siralamasi as (
select
	ad,
	sobe,
    maas,
    AVG(maas) over(partition by sobe) as ortalama_maas,
    dense_rank() over(partition by sobe order by maas desc) as maas_siralamasi
  
from isciler
)
select * 
from isci_maas_siralamasi
where maas_siralamasi <= 2;




select
	ad,
    sobe,
    ise_giris_tarixi,
    maas,
    LAG(maas) over(partition by sobe order by ise_giris_tarixi ASC) as evvelki_maas,
    maas - LAG(maas) over(partition by sobe order by ise_giris_tarixi ASC) as evvelki_maas_ferqi,
    SUM(maas) over(partition by sobe order by ise_giris_tarixi ASC) as sobe_uzre_running_total,
    AVG(maas) over(partition by sobe order by ise_giris_tarixi ASC) as sobe_uzre_maas_ortalamasi
from isciler;

CREATE TABLE musteriler (
    id INT,
    ad VARCHAR(50),
    email VARCHAR(100),
    seher VARCHAR(50),
    qeydiyyat_tarixi DATE
);

INSERT INTO musteriler VALUES
(1, 'Ali', 'ali@gmail.com', 'Krakow', '2025-01-10'),
(2, 'Leyla', 'leyla@gmail.com', 'Warsaw', '2025-02-15'),
(3, 'Ali', 'ali@gmail.com', 'Krakow', '2025-03-20'),
(4, 'Murad', 'murad@gmail.com', 'Gdansk', '2025-01-05'),
(5, 'Ali', 'ali@gmail.com', 'Krakow', '2025-04-01'),
(6, 'Leyla', 'leyla@gmail.com', 'Warsaw', '2025-05-10'),
(7, 'Nigar', 'nigar@gmail.com', 'Krakow', '2025-06-01');

select * from musteriler;

with rn_musteriler as (
select
	ad,
    email,
    seher,
    qeydiyyat_tarixi,
    row_number() over(partition by email order by qeydiyyat_tarixi) as rn
    
from musteriler
) 
select 
    ad,
    email,
    seher,
    qeydiyyat_tarixi,
    rn,
case
	when rn = 1 then 'original'
	else 'duplicate'
end as status
from rn_musteriler;*/

CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    name VARCHAR(50),
    department_id INT,
    salary DECIMAL(10,2)
);
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50)
);
    

INSERT INTO Departments (department_id, department_name)
VALUES
    (10, 'IT'),
    (20, 'Finance'),
    (30, 'HR'),
    (40, 'Marketing');
    
INSERT INTO Employees (employee_id, name, department_id, salary)
VALUES
    (1, 'Ali', 10, 5000),
    (2, 'John', 20, 6000),
    (3, 'Maria', 10, 5500),
    (4, 'David', 30, 4500),
    (5, 'Emma', 20, 7000),
    (6, 'Michael', 30, 4000),
    (7, 'Sarah', 40, 6200),
    (8, 'Daniel', NULL, 4800);
    
    
select
	e.employee_id,
    d.department_name,
    e.salary
from Employees e 
join Departments d
on e.department_id = d.department_id
order by salary desc;

select 
	e.name,
    d.department_name
from Employees e 
left join Departments d
	on e.department_id = d.department_id;

-- Səndən istəyirəm ki, hər department üçün bunları göstərəsən:

-- department_name
-- həmin department-də neçə employee var
-- həmin department-in average salary-si

-- Amma yalnız average salary 5500-dən böyük olan department-ləri göstər.

-- Nəticəni average salary-yə görə böyükdən kiçiyə sırala.

-- select 
-- 	d.department_name,
--     count(e.employee_id) as sum_of_employee,
--     avg(e.salary) as average_salary
-- from departments d
-- join employees e 
-- on d.department_id = e.department_id
-- group by d.department_name
-- having average_salary > 5500
-- order by average_salary desc;

-- Hər department-də ən yüksək maaş alan employee-ni tap.
-- Göstər:

-- department_name
-- employee name
-- salary

-- Məsələn:

-- IT        Maria    5500
-- Finance   Emma     7000
-- HR        David    4500

select
	d.department_name,
    max(salary)
from employees e
join departments d 
on d.department_id = e.department_id
group by 	
	d.department_name;

with employee_board as (    
	select
		d.department_name as department_name,
		e.name as employee_name,
		e.salary as employee_salary
	from employees e
	join departments d 
	on d.department_id = e.department_id
	group by 	
		d.department_name,
		e.name,
		e.salary
)
select 
department_name,
max(employee_salary),
employee_name
from employee_board
group by department_name,employee_name;
	


with department_max as (
select
	d.department_name,
    max(salary) as max_salary
from employees e
join departments d 
on d.department_id = e.department_id
group by 	
	d.department_name
),
 employee_board as (    
	select
		d.department_name as department_name,
		e.name as employee_name,
		e.salary as employee_salary
	from employees e
	join departments d 
	on d.department_id = e.department_id
	group by 	
		d.department_name,
		e.name,
		e.salary
)
select 
	eb.department_name,
	eb.employee_name,
	eb.employee_salary
from employee_board eb
join department_max db
	on eb.department_name = db.department_name
    and eb.employee_salary = db.max_salary;
    
select * from employees;
-- Hər employee-nin maaşını öz department-inin average salary-si ilə müqayisə et.
-- Yalnız department average salary-dən yüksək maaş alan employee-ləri göstər.
-- Nəticədə bunlar olsun:

-- employee_name
-- department_name
-- salary
-- department_average_salary

-- with salary_board as (
-- select 
-- 	e.name,
--     d.department_name,
--     d.department_id,
--     e.salary,
--     avg(e.salary) as average_department_salary
-- from employees e
-- join departments d 
-- on e.department_id = d.department_id
-- group by
-- 	e.name,
--     d.department_name,
--     e.salary,
--     d.department_id
--     order by d.department_name
-- ),
-- average_salary as (
-- select 
-- 	d.department_name,
--     d.department_id,
--     avg(e.salary) as average_department_salary
-- from employees e
-- join departments d 
-- on e.department_id = d.department_id
-- group by
-- 	d.department_name,
--     d.department_id
-- )
-- select 
-- 	salary_board.name,
--     salary_board.salary,
--     average_salary.department_name,
--     average_salary.average_department_salary
-- from salary_board
-- join average_salary
-- on salary_board.department_id = average_salary.department_id
-- where salary_board.salary > average_salary.average_department_salary
-- group by 
-- 	salary_board.name,
--     salary_board.salary,
--     average_salary.average_department_salary,
--     average_salary.department_name;
--  
--     
--     
-- CREATE TABLE Students (
--     student_id INT PRIMARY KEY,
--     name VARCHAR(50)
-- );

-- INSERT INTO Students (student_id, name)
-- VALUES
--     (1, 'Alice'),
--     (2, 'Bob'),
--     (3, 'Charlie'),
--     (4, 'David'),
--     (5, 'Emma');
--     
-- CREATE TABLE Courses (
--     course_id INT PRIMARY KEY,
--     course_name VARCHAR(50)
-- );

-- INSERT INTO Courses (course_id, course_name)
-- VALUES
--     (101, 'SQL'),
--     (102, 'Python'),
--     (103, 'Java'),
--     (104, 'Oracle');
--     
-- CREATE TABLE Enrollments (
--     student_id INT,
--     course_id INT,
--     score DECIMAL(5,2)
-- );

-- INSERT INTO Enrollments (student_id, course_id, score)
-- VALUES
--     (1, 101, 90),
--     (1, 102, 80),
--     (1, 101, 95),
--     (1, 103, 70),

--     (2, 101, 70),
--     (2, 103, 85),
--     (2, 103, 90),

--     (3, 102, 100),
--     (3, 103, 60),

--     (4, 101, 50),
--     (4, 102, 65),

--     (5, 101, 95),
--     (5, 102, 90),
--     (5, 104, 88);
--     
-- SELECT * FROM Students;

-- SELECT * FROM Courses;

-- SELECT * FROM Enrollments;

-- with score_board as(
-- select
-- 	st.name,
--     cr.course_name,
--     max(en.score) as max_score
-- from students st 
-- join enrollments en  
-- on st.student_id = en.student_id
-- join courses cr
-- on cr.course_id = en.course_id
-- group by 
-- 	st.name,
--     cr.course_name
-- )
-- select 
-- name,
-- sum(max_score) as total_score
-- from score_board
-- group by 
-- 	score_board.name
-- having total_score > 150
-- order by total_score desc;

-- employee_name
-- department_name
-- salary
-- salary_rank
-- Şərtlər
-- Hər department öz daxilində ayrıca sıralanmalıdır.
-- Ən yüksək maaş → rank 1
-- Eyni maaş varsa, eyni rank almalıdır.
-- Bütün employee-lər görünsün.
-- Department və rank üzrə sıralaya bilərsən.

-- select 
-- 	e.name,
--     d.department_name,
--     e.salary,
--     rank() over(partition by d.department_name order by e.salary desc) as salary_rank
-- from employees e
-- join departments d
-- on e.department_id = d.department_id;

-- group by 
-- 	e.name,
--     d.department_name,
--     e.salary;

CREATE TABLE Projects (
    Task_ID INT PRIMARY KEY,
    Start_Date DATE,
    End_Date DATE
);
INSERT INTO Projects (Task_ID, Start_Date, End_Date)
VALUES
(1, '2015-10-01', '2015-10-02'),
(2, '2015-10-02', '2015-10-03'),
(3, '2015-10-03', '2015-10-04'),
(4, '2015-10-13', '2015-10-14'),
(5, '2015-10-14', '2015-10-15'),
(6, '2015-10-28', '2015-10-29'),
(7, '2015-10-30', '2015-10-31');


select * from Projects;

select Task_ID, Start_Date, End_Date,
row_number() over(order by start_date)
from Projects;

-- with t as (
-- 	select 
-- 		*,
--         row_number() over(order by start_date) as rn
-- 	from Projects
-- )
-- select
-- 	a.task_id,
--     a.start_date,
--     b.start_date as next_start
-- from t a 
-- join t b 
-- 	on a.rn+1 = b.rn;

-- select 
-- 	start_date,
-- 	end_date,
--     prev_end_date,
-- 	case 
-- 		when Start_Date = prev_end_date then 0
-- 		else 1
-- 	end as new_project
-- from (
-- 	select 
-- 		start_date,
-- 		end_date,
-- 		lag(end_date) over(order by (start_date)) as prev_end_date
-- 	from projects
-- 	) as sub;
    
-- WITH project_groups AS (
--     SELECT
--         start_date,
--         end_date,
--         SUM(new_project) OVER (ORDER BY start_date) AS project_id
--     FROM (
--         SELECT
--             start_date,
--             end_date,
--             CASE
--                 WHEN start_date = prev_end_date THEN 0
--                 ELSE 1
--             END AS new_project
--         FROM (
--             SELECT
--                 start_date,
--                 end_date,
--                 LAG(end_date) OVER (ORDER BY start_date) AS prev_end_date
--             FROM Projects
--         ) AS t1
--     ) AS t2
-- )

-- SELECT
--     MIN(start_date) AS start_date,
--     MAX(end_date) AS end_date
-- FROM project_groups
-- GROUP BY project_id
-- ORDER BY DATEDIFF(MAX(end_date), MIN(start_date)), MIN(start_date);

-- select * from employee_demographics;

-- select 
-- 	first_name,
--     last_name,
--     age,
--     gender,
--     count(gender) over(partition by gender) as age_sum_gender
-- from employee_demographics;

-- select * from employees;

-- select 
-- 	name,
--     department_id,
--     salary,
--     lag(salary) over(order by salary) as prev_salary,
--     salary - lag(salary) over(order by employee_id) as salary_difference
-- from employees;

-- select	
-- 	ed.first_name,
--     ed.gender,
--     es.salary,
--     rank() over(partition by ed.gender order by es.salary desc) as rank_num
-- from employee_demographics ed
-- join employee_salary 	   es
-- on ed.employee_id = es.employee_id;

CREATE TABLE Sales (
    sale_id INT,
    sale_date DATE,
    amount INT
);

INSERT INTO Sales VALUES
(1, '2025-01-01', 100),
(2, '2025-01-02', 150),
(3, '2025-01-03', 200),
(4, '2025-01-07', 300),
(5, '2025-01-08', 250),
(6, '2025-01-15', 400),
(7, '2025-01-16', 500),
(8, '2025-01-20', 100);

WITH grouped_sales AS (
    SELECT
        sale_date,
        amount,
        SUM(same_project) OVER (ORDER BY sale_date) AS group_id
    FROM (
        SELECT
            sale_date,
            amount,
            CASE
                WHEN sale_date = DATE_ADD(prev_sale_date, INTERVAL 1 DAY)
                THEN 0
                ELSE 1
            END AS same_project
        FROM (
            SELECT
                sale_date,
                amount,
                LAG(sale_date) OVER (ORDER BY sale_date) AS prev_sale_date
            FROM Sales
        ) AS sub
    ) AS sub1
)

SELECT
    group_id,
    MIN(sale_date) AS start_date,
    MAX(sale_date) AS end_date,
    SUM(amount) AS total_sales
FROM grouped_sales
GROUP BY group_id
ORDER BY group_id;

























    




































