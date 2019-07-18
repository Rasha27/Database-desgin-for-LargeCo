--1
SELECT E.*, S.Sal_Amount
FROM Employee E
INNER JOIN Salary_History S
ON E.Emp_Num = S.Emp_Num
WHERE E.Dept_Num = 300
AND S.Sal_End IS NULL
ORDER BY 2 DESC;

--2

SELECT E.*, S.Sal_Amount
FROM Employee E
INNER JOIN Salary_History S
ON E.Emp_Num = S.Emp_Num
INNER JOIN (SELECT Emp_Num, min(Sal_From) Min_Sal_From FROM Salary_History
GROUP BY Emp_Num) AS SM
ON E.Emp_Num = SM.Emp_Num
WHERE S.Sal_From = SM.Min_Sal_From
order by 1;

--3

SELECT L1.Inv_Num, L1.Line_Num, L2.Line_Num, P1.Prod_Sku, P2.Prod_Sku, P1.Prod_Descript, P2.Prod_Descript, P1.Brand_id
FROM Line L1 
INNER JOIN Product P1
ON L1.Prod_Sku = P1.Prod_Sku 
INNER JOIN Line L2
ON L1.Inv_Num = L2.Inv_Num
INNER JOIN Product P2
ON L2.Prod_Sku = P2.Prod_Sku
AND P1.Brand_Id = P2.Brand_Id
WHERE P1.Prod_Category = 'Sealer'
AND P2.Prod_Category = 'Top Coat'
ORDER BY L1.Inv_Num, L2.Line_Num;

--4

SELECT E.Emp_num, E.Emp_fname, E.Emp_lname, E.Emp_email, M.UnitsCount 
FROM Employee AS E 
INNER JOIN (SELECT I.Employee_Id, SUM(Line_Qty) AS UnitsCount 
			FROM Invoice i 
			INNER JOIN line l 
			ON I.Inv_num = l.Inv_num 
			INNER JOIN Product p 
			ON l.Prod_sku = p.Prod_sku 
			INNER JOIN Brand B
			ON b.Brand_id = p.Brand_id 
			WHERE brand_name = 'BINDER PRIME' 
			AND I.INV_DATE BETWEEN '2015-11-01' AND '2015-12-05' 
			GROUP BY I.Employee_id) M 
	ON E.Emp_Num = M.Employee_Id 
WHERE UnitsCount = (SELECT MAX(UnitsCount) 
					FROM (SELECT I.Employee_id, Sum(Line_Qty) AS UnitsCount 
							FROM Invoice I 
							INNER JOIN Line L 
							ON I.Inv_Num = L.Inv_Num 
							INNER JOIN Product P
							ON l.Prod_Sku = p.Prod_Sku
							INNER JOIN Brand B
							ON B.Brand_Id = P.Brand_Id 
							WHERE B.Brand_Name = 'BINDER PRIME' 
							AND INV_DATE BETWEEN '2015-11-01' AND '2015-12-05' 
							GROUP BY Employee_Id) AS E) 
ORDER BY E.Emp_Lname;

--5

SELECT C.Cust_code, C.Cust_fname, C.Cust_lname 
FROM Customer C
INNER JOIN Invoice I 
	ON C.Cust_code = I.Cust_code 
WHERE I.Employee_id IN (83649,83677)
GROUP BY C.Cust_code, C.Cust_fname, C.Cust_lname
HAVING COUNT(DISTINCT I.Employee_Id) = 2;

--6

SELECT C.Cust_code, C.Cust_fname, C.Cust_lname, C.Cust_street, C.Cust_city, C.Cust_state, C.Cust_zip, I.Inv_date, ISNULL(I.Inv_total,0) AS LargestPurchase
FROM Customer C
INNER JOIN Invoice I
ON C.Cust_code = I.Cust_code
WHERE C.Cust_state = 'AL' 
AND I.Inv_total = (SELECT Max(IM.Inv_total) FROM Invoice IM WHERE IM.Cust_code = C.Cust_code)
UNION ALL
SELECT C.Cust_code, C.Cust_fname, C.Cust_lname, C.Cust_street, C.Cust_city, C.Cust_state, C.Cust_zip, NULL, 0
FROM customer c
WHERE C.Cust_state = 'AL' 
AND C.Cust_code NOT IN (SELECT Cust_code FROM Invoice)
ORDER BY C.Cust_lname, C.Cust_fname;

SELECT C.cust_code, 
       C.cust_fname, 
       C.cust_lname, 
       C.cust_street, 
       C.cust_city, 
       C.cust_state, 
       C.cust_zip, 
       I.inv_date, 
       ISNULL(I.inv_total, 0) AS INV_TOTAL 
FROM   customer C 
       LEFT JOIN invoice I 
              ON C.cust_code = I.cust_code 
WHERE  C.cust_state = 'AL' 
ORDER  BY inv_total

--7

SELECT brand_name, brand_type, PR.avg_price AS AveragePrice, UN.units_sold As UnitsSold
FROM brand b 
INNER JOIN (SELECT brand_id, Avg(prod_price) AS avg_price 
			FROM product GROUP BY brand_id) PR 
ON b.brand_id = PR.brand_id
INNER JOIN (SELECT brand_id, Sum(line_qty) AS units_sold 
			FROM product p 
			INNER JOIN line l 
			ON p.prod_sku = l.prod_sku 
			GROUP BY brand_id) UN
ON b.brand_id = UN.brand_id
ORDER BY brand_name;

--8

SELECT b.brand_name, b.brand_type, p.prod_sku, p.prod_descript, p.prod_price
FROM product p
INNER JOIN brand b ON p.brand_id = b.brand_id
WHERE brand_type != 'PREMIUM'
AND prod_price > (SELECT MAX(prod_price)
					FROM Product P
					INNER JOIN Brand B 
					ON P.brand_id = B.brand_id
					WHERE B.brand_type = 'PREMIUM');

--9
--a

SELECT * FROM Product P WHERE P.prod_price > 50;

--b
SELECT SUM(Prod_QOH*Prod_Price) FROM Product P;

--c
SELECT COUNT(*) AS CustomerCount, SUM(Cust_Balance) AS TotalBalance FROM Customer

--d

SELECT TOP 3 C.Cust_State, Sum(I.Inv_total) AS TotalPurchase
FROM Customer C 
INNER JOIN Invoice I
ON I.Cust_Code = C.Cust_Code 
GROUP BY C.Cust_State
ORDER BY 2 DESC;

select top 3 CUST_STATE,SUM(INV_TOTAL) as TOTAL_SALES_Dollars from INVOICE I INNER JOIN CUSTOMER C ON I.CUST_CODE=C.CUST_CODE group by CUST_STATE
order by SUM(INV_TOTAL) desc

select * from Customer

select sum(inv_total) from Invoice
order by Inv_total desc

--10

							
select top 10 * from Invoice
select top 10 * from line

select * from Customer

select Inv_Num,count(*) from line
group by Inv_Num
order by 2 desc

select Inv_Num,count(distinct Prod_Sku) from DataSet2
group by Inv_Num
order by 2 desc


SELECT employee_id, Sum(line_qty) AS total FROM invoice i join line l ON I.Inv_num = l.Inv_num JOIN product p ON l.Prod_sku = p.Prod_sku JOIN brand b ON b.Brand_id = p.Brand_id 
WHERE brand_name = 'BINDER PRIME' 
AND INV_DATE BETWEEN '2015-11-01' AND '2015-12-05' 
GROUP BY employee_id

SELECT employee_id, inv_date FROM invoice i join line l ON I.Inv_num = l.Inv_num JOIN product p ON l.Prod_sku = p.Prod_sku JOIN brand b ON b.Brand_id = p.Brand_id 
WHERE brand_name = 'BINDER PRIME' 
AND INV_DATE BETWEEN '2015-11-01' AND '2015-12-05' 

select * from INFORMATION_SCHEMA.COLUMNS where table_name not like '%data%set%'
order by TABLE_NAME 

select table_name, CONSTRAINT_NAME from INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
where table_name not like '%data%set%'
order by table_name

select min(inv_date), max(inv_date) from invoice


select * from sys.tables where name not like '%data%set%'