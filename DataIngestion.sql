Insert into Brand
select DISTINCT BRAND_ID, BRAND_NAME, BRAND_TYPE from DataSet3

Insert into Vendor
select DISTINCT Vend_Id,
Vend_Name,
vend_street,
vend_City,
vend_State,
vend_Zip from DataSet3
WHERE VEND_NAME!=''

insert into Product
select DISTINCT SUBSTRING(prod_sku,1,8),
prod_descript,
prod_type,
prod_base,
prod_Category,
prod_price,
prod_Qoh,
prod_min,
brand_Id from DataSet3


insert into Supplies
select distinct vend_Id, SUBSTRING(prod_sku,1,8) from dataset3


insert into customer(Cust_Code,
Cust_Fname,
Cust_Lname,
Cust_Street,
Cust_City,
Cust_State,
Cust_Zip,
Cust_Balance)
select DISTINCT Cust_Code,
Cust_Fname,
Cust_Lname,
Cust_Street,
Cust_City,
Cust_State,
Cust_Zip,
Cust_Balance from dataset2

--select * from dataset2 where cust_code = 86
--SELECT * from Customer where cust_code = 86

Insert into Department
select distinct Dept_Num,
Dept_Name,
Dept_Mail_Box,
Dept_Phone,
Supv_Emp_num
from dataset4

insert into employee
select distinct Emp_num,
Emp_Fname,
Emp_Lname,
Emp_Email,
Emp_Phone,
CONVERT(varchar(20),cast(cast(EMP_HIREDATE as int) as datetime),120),
Emp_Title,
Emp_Comm,
Dept_Num from dataset4

--truncate table salary_history

insert into salary_history
select distinct Emp_num,
CONVERT(varchar(20),cast(cast(Sal_from as int) as datetime),120),
CASE Sal_end when ' - ' THEN NULL ELSE CONVERT(varchar(20),cast(cast(Sal_end as int) as datetime),120) END,
sal_Amount
from dataset4


--select * from Invoice where inv_num in (1978, 2124, 2275, 2315, 2362, 2364, 2577, 2644, 2885, 2921, 3024, 3135, 3347, 3364, 3370)

--2 cust code for same inv_num
insert into Invoice
select distinct Inv_Num,
MIN(Cust_Code),
min(CONVERT(varchar(20),cast(cast(Inv_Date as int) as datetime),120)),
min(Inv_total),
min(Employee_Id)
from dataset2
group by Inv_Num
having COUNT(DISTINCT Cust_Code) = 1

--select inv_num from dataset2
--group by inv_num
--having count(distinct cust_code)>1

--select * from  dataset2
--where inv_num in( 1978
--,2885
--,2921
--,3024
--,3135
--,3347
--,3364
--,3370)
--order by inv_num

insert into line
select distinct Inv_Num,
Line_Num,
Line_Qty,
Line_price,
Prod_Sku
from dataset2 d
where exists (select 1 from Invoice I where I.inv_num = d.inv_num)

select 'select count(*) from '+name from sys.tables where name not like '%dat%set%'


select count(*) from BRAND
select count(*) from Product
select count(*) from Vendor
select count(*) from Supplies
select count(*) from Customer
select count(*) from Department
select count(*) from Employee
select count(*) from Salary_History
select count(*) from Invoice
select count(*) from Line
drop table temp
drop table test
select * from product where prod_sku like '%6358%'
select * from product where prod_sku like '%8338%'

select prod_sku, len(prod_sku) from Product
order by 2 desc

update P
set P.prod_sku = SUBSTRING(prod_sku,1,8)
from Product P
where len(prod_sku) = 9

select * from DataSet2
where CUST_CODE in (850, 851)

select INV_NUM, count(distinct LINE_NUM) from DataSet2
group by INV_NUM
order by 2 desc

select c.name,t.name from sys.columns c
inner join sys.tables t
on c.object_id = t.object_id
where c.name like '%doll%'