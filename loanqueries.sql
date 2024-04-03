select *
from bank_loan_data

--1
select count(id) as total_loan_applications
from bank_loan_data
--total_loan_applications
--38576

--2

select count(id) as MTD_total_loan_applications
from bank_loan_data
WHERE MONTH(issue_date) = 12 and year(issue_date) =2021
--MTD_total_loan_applications
--4314

select count(id) as PMTD_total_loan_applications
from bank_loan_data
WHERE MONTH(issue_date) = 11 and year(issue_date) =2021
--PMTD_total_loan_applications
--4035


select sum(loan_amount) as total_funded_amount
from bank_loan_data
--total_funded_amount
--435757075


select sum(loan_amount) as mtd_total_funded_amount
from bank_loan_data
WHERE MONTH(issue_date) = 12 and year(issue_date) =2021
--mtd_total_funded_amount
--53981425


select sum(loan_amount) as PMTD_total_funded_amount
from bank_loan_data
WHERE MONTH(issue_date) = 11 and year(issue_date) =2021
--PMTD_total_funded_amount
--47754825

select sum(total_payment) as total_amount_recieved
from bank_loan_data
--total_amount_recieved
--473070933

select sum(total_payment) as MTD_total_amount_recieved
from bank_loan_data
where month(issue_Date)=12 and year(issue_date)= 2021
--MTD_total_amount_recieved
--58074380

select sum(total_payment) as PMTD_total_amount_recieved
from bank_loan_data
where month(issue_Date)=11 and year(issue_date)= 2021
--PMTD_total_amount_recieved
--50132030

select round(avg(int_rate)*100, 3)  as avg_interest_rate
from bank_loan_data
--avg_interest_rate
--12.049

select round(avg(int_rate)*100, 3)  as MTD_avg_interest_rate
from bank_loan_data
where MONTH(issue_date) = 12 and year(issue_date) = 2021
--MTD_avg_interest_rate
--12.356

select round(avg(int_rate)*100, 3)  as PMTD_avg_interest_rate
from bank_loan_data
where MONTH(issue_date) = 11 and year(issue_date) = 2021
--PMTD_avg_interest_rate
--11.942

select round(avg(dti),3) *100 as avg_dti
from bank_loan_data
--avg_dti
--13.3

select round(avg(dti) *100,3) as MTD_avg_dti
from bank_loan_data
where month(issue_date) = 12 and year(issue_date) = 2021
--MTD_avg_dti
--13.666

select round(avg(dti) *100,3) as PMTD_avg_dti
from bank_loan_data
where month(issue_date) = 11 and year(issue_date) = 2021
--PMTD_avg_dti
--13.303

--GOOD LOAN KPI'S

select 
	(count(case when loan_status = 'Fully Paid' or loan_status = 'Current' then id end)*100)
	/
	count(id) as good_loan_percentage
from bank_loan_data
--good_loan_percentage
--86


select count(id) as good_loan_applications
from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current'
--good_loan_applications
--33243

select sum(loan_amount) as good_loan_funded_amount
from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current' 
--good_loan_funded_amount
--370224850

select sum(total_payment) as good_loan_receieved_amount
from bank_loan_data
where loan_status = 'Fully Paid' or loan_status = 'Current' 
--good_loan_receieved_amount
--435786170

--BAD LOAN KPI'S
select 
	ROUND(((count(case when loan_status = 'Charged off'  then id end) *100.0)
	/
	count(id) ),3)as bad_loan_percentage
from bank_loan_data
--bad_loan_percentage
--13.825000000000

Select count(id) as bad_loan_applications
from bank_loan_data
where loan_status = 'Charged off'
--bad_loan_applications
--5333


select sum(loan_amount) as bad_loan_funded_amount
from bank_loan_data
where loan_status ='Charged off'
--bad_loan_funded_amount
--65532225


select sum(total_payment) as bad_loan_receieved_amount
from bank_loan_data
where loan_status ='Charged off'
--good_loan_receieved_amount
--37284763


--LOAN STATUS GRID VIEW

SELECT loan_status,
	count(id) as total_loan_apllications,
	sum(loan_amount) as total_funded_amount, 
	sum(total_payment) as total_amount_receieved,
	avg(int_rate *100) as interest_rate,
	avg(dti*100) as DTI
from bank_loan_data
group by loan_status
--loan_status		total_loan_apllications			total_funded_amount			total_amount_receieved		interest_rate			DTI
--Fully Paid		32145						351358350				411586256				11.6410707918092	13.1673507557434
--Current			1098						18866500				24199914				15.0993260800947	14.7243442736843
--Charged Off		5333						65532225				37284763				13.8785749318289	14.0047328005517

SELECT loan_status,
	count(id) as total_loan_apllications,
	sum(loan_amount) as MTD_total_funded_amount, 
	sum(total_payment) as MTD_total_amount_receieved
from bank_loan_data
where month(issue_date) = 12  
group by loan_status
--loan_status	total_loan_apllications		MTD_total_funded_amount		MTD_total_amount_receieved
--Fully Paid	3452						41302025					47815851
--Current		213							3946625						4934318
--Charged Off	649							8732775						5324211


---OVERVIEW DASHBOARD QUERIES

--1) MONTHLY TREND
SELECT
   DATENAME(MONTH, issue_date) AS month_name,
   month(issue_date) as month_number,
   count(id) as total_loan_applicatipons,
   sum(loan_amount) as total_funded_amount,
   sum(total_payment) as total_amount_receieved
FROM bank_loan_data
group by  DATENAME(MONTH, issue_date) , month(issue_date) 
order by   month(issue_date) 
--month_name	month_number	total_loan_applicatipons	total_funded_amount		total_amount_receieved
--January			1				2332						25031650				27578836
--February			2				2279						24647825				27717745
--March				3				2627						28875700				32264400
--April				4				2755						29800800				32495533
--May				5				2911						31738350				33750523
--June				6				3184						34161475				36164533
--July				7				3366						35813900				38827220
--August			8				3441						38149600				42682218
--September			9				3536						40907725				43983948
--October			10				3796						44893800				49399567
--November			11				4035						47754825				50132030
--December			12				4314						53981425				58074380



--2)REGIONAL TREND
SELECT
   address_state ,
   count(id) as total_loan_applicatipons,
   sum(loan_amount) as total_funded_amount,
   sum(total_payment) as total_amount_receieved
FROM bank_loan_data
group by  address_state
order by  address_state -- for statewise trend
--address_state		total_loan_applicatipons	total_funded_amount			total_amount_receieved
--AK						78						1031800						1108570
--AL						432						4949225						5492272

SELECT
   address_state ,
   count(id) as total_loan_applicatipons,
   sum(loan_amount) as total_funded_amount,
   sum(total_payment) as total_amount_receieved
FROM bank_loan_data
group by  address_state
order by  sum(loan_amount) desc -- state given highest funding

--address_state	 total_loan_applicatipons	total_funded_amount			total_amount_receieved
--CA						6894				78484125						83901234



SELECT
   address_state ,
   count(id) as total_loan_applicatipons,
   sum(loan_amount) as total_funded_amount,
   sum(total_payment) as total_amount_receieved
FROM bank_loan_data
group by  address_state
order by  count(id) desc -- state taken highest loan applications 

--address_state				total_loan_applicatipons	total_funded_amount		total_amount_receieved
--CA								6894						78484125			83901234
--NY								3701						42077050			46108181


--3)TERM TREND
SELECT
   term ,
   count(id) as total_loan_applicatipons,
   sum(loan_amount) as total_funded_amount,
   sum(total_payment) as total_amount_receieved
FROM bank_loan_data
group by     term 
order by     term

--term		total_loan_applicatipons	total_funded_amount			total_amount_receieved
--36months			28237					273041225					294709458
--60months			10339					162715850					178361475

--4)EMPLOYEE LENGTH TREND 
SELECT
   emp_length ,
   count(id) as total_loan_applicatipons,
   sum(loan_amount) as total_funded_amount,
   sum(total_payment) as total_amount_receieved
FROM bank_loan_data
group by     emp_length 
order by     emp_length

--emp_length	total_loan_applicatipons	total_funded_amount			total_amount_receieved
--< 1 year			4575					44210625						47545011
--1 year			3229					32883125						35498348
--10+ years			8870					116115950						125871616

--5)PURPOSE TREND
SELECT
   purpose ,
   count(id) as total_loan_applicatipons,
   sum(loan_amount) as total_funded_amount,
   sum(total_payment) as total_amount_receieved
FROM bank_loan_data
group by     purpose 
order by     count(id) DESC	
--purpose				total_loan_applicatipons	total_funded_amount		total_amount_receieved
--Debt consolidation		18214						232459675				253801871
--credit card				4998						58885175				65214084

--6) HOME OWNERSHIP TREND
SELECT
   home_ownership ,
   count(id) as total_loan_applicatipons,
   sum(loan_amount) as total_funded_amount,
   sum(total_payment) as total_amount_receieved
FROM bank_loan_data
group by     home_ownership 
order by     count(id) DESC	

--home_ownership	total_loan_applicatipons	total_funded_amount			total_amount_receieved
--RENT					18439					185768475						201823056
--MORTGAGE				17198					219329150						238474438
--OWN					2838					29597675						31729129
--OTHER					98						1044975							1025257
--NONE					3						16800							19053