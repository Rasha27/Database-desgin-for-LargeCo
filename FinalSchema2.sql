CREATE TABLE BRAND
(
Brand_Id int not null primary key,
Brand_name varchar(100),
Brand_Type varchar(100) not null
)

CREATE TABLE Product
(
Prod_Sku varchar(50) not null primary key,
prod_descript varchar(500) not null,
prod_type varchar(50),
prod_base varchar(50),
prod_Category varchar(50),
prod_price decimal(35,5) not null,
prod_Qoh int not null,
prod_min int not null,
brand_Id int not null foreign key references Brand(Brand_id)
)

CREATE TABLE Vendor
(
Vend_Id int not null primary key,
Vend_Name varchar(150) not null,
vend_street varchar(150),
vend_City varchar(150),
vend_State varchar(150),
vend_Zip int
)

--drop table product
--drop table Supplies
--drop table line

CREATE TABLE Supplies
(
Vend_Id int not null,
Prod_Sku varchar(50) not null,
CONSTRAINT PK_Supplies PRIMARY KEY(Vend_Id, Prod_Sku),
CONSTRAINT FK_Vend FOREIGN KEY(Vend_Id) REFERENCES Vendor(Vend_Id),
CONSTRAINT FK_Prod FOREIGN KEY(Prod_Sku) REFERENCES Product(Prod_Sku)
)

CREATE TABLE Customer
(
Cust_Code int not null primary key,
Cust_Fname varchar(100) not null,
Cust_Lname varchar(100) not null,
Cust_Street varchar(100),
Cust_State varchar(100),
Cust_City varchar(100),
Cust_Zip int,
Cust_Balance decimal(35,5) not null
)
--drop table employee;
--drop table Department

CREATE TABLE Department
(
Dept_Num int not null Primary key,
Dept_Name varchar(100) not null,
Dept_Mail_Box varchar(100) not null,
Dept_Phone varchar(100) not null,
Emp_num int not null
)

--drop table Employee

--Alter table Employee drop constraint FK__Employee__Dept_N__5DCAEF64
--Alter table Department drop constraint FK__Departmen__Emp_n__5EBF139D

CREATE TABLE Employee
(
Emp_num int not null primary key,
Emp_Fname varchar(100) not null,
Emp_Lname varchar(100) not null,
Emp_Email varchar(100) null,
Emp_Phone varchar(100) null,
Emp_HiredDate datetime not null,
Emp_Title varchar(100) not null,
Emp_Comm varchar(100) null,
Dept_Num int not null
)

ALTER TABLE Employee ADD foreign key (Dept_Num) references Department(Dept_num)

ALTER TABLE Department ADD foreign key (Emp_Num) references Employee(Emp_num)


CREATE TABLE Salary_History
(
Emp_num int not null foreign key references Employee(Emp_Num),
Sal_from datetime not null,
Sal_end datetime,
sal_Amount decimal(35,5) not null,
CONSTRAINT PK_Salary PRIMARY KEY(Emp_num, Sal_from)
)

--select c.name,t.name from sys.columns c
--inner join sys.tables t
--on c.object_id = t.object_id
--where c.name like '%sal%amoun%'

--select top 10 * from DataSet2
--select top 10 * from DataSet3
--select top 10 * from DataSet4

CREATE TABLE Invoice
(
Inv_Num int not null primary key,
Cust_Code int not null foreign key references Customer(Cust_Code),
Inv_Date datetime not null,
Inv_total decimal(35,5) not null,
Employee_Id int not null foreign key references Employee(Emp_Num)
)


CREATE TABLE Line
(
Inv_Num int not null,
Line_Num int not null,
Line_Qty int not null,
Line_price decimal(35,5) not null,
Prod_Sku varchar(50) not null,
CONSTRAINT PK_Line PRIMARY KEY(Inv_Num, Line_Num),
CONSTRAINT FK_Prod_SKU FOREIGN KEY(Prod_Sku) REFERENCES Product(Prod_Sku),
CONSTRAINT FK_Inv FOREIGN KEY(Inv_Num) REFERENCES Invoice(Inv_Num)
)

select * from DataSet1_ST

select * from DataSet2_ST

select * from DataSet3_ST


select * from sys.columns where name like '%dept%'
