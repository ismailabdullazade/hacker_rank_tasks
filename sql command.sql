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




































