--loome db
create database TARpe24SQL

-- db valimine
use TARpe24SQL

-- db kustutamine
drop database TARpe24SQL

-- tabeli loomine
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

-- andmete sisestamine
insert into Gender (Id, Gender)
values (2, 'Male')
insert into Gender (Id, Gender)
values (1, 'Female')
insert into Gender (Id, Gender)
values (3, 'Unknown')

-- vaatame tabeli sisu
select * from Gender

-- teeme tabeli Person
create table Person
(
Id int not null primary key,
Name nvarchar (30),
Email nvarchar(30),
GenderId int 
)

-- andmete sisestamine
insert into Person (Id, Name, Email, GenderId)
values (1, 'Superman', 's@s.com', 2)
insert into Person (Id, Name, Email, GenderId)
values (2, 'Wonderwoman', 'w@w.com', 1),
(3, 'Batman', 'b@b.com', 2),
(4, 'Aquaman', 'a@a.com', 2),
(5, 'Catwoman', 'c@c.com', 1),
(6, 'Antman', 'ant"ant.com', 2),
(7, 'Spiderman', 'spider@s.com', 2),
(9, NULL, NULL, 2)

-- sovime vaadata Person tabeli andmeid
select * from Person

-- v��rv�tme �henduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

-- kui sisestad uue rea andmeid ja ei ole sisestanud GenderId alla v��rtust,
-- siis see automaatselt sisestab sellele reale v��rtuse 3 e nagu meil
-- on unknown
alter table Person
add constraint DF_Persons_GenderId
default 3 for GenderId

-- 
insert into Person (Id, Name, Email, GenderId)
values (10, 'Deadpool', 'd@d.com', NULL)
insert into Person (Id, Name, Email)
values (11, 'Kalevipoeg', 'k@k.com')

-- piirangu kustutamine
alter table person
drop constraint DF_Persons_GenderId

-- lisame uue veeru
alter table Person
add Age nvarchar(10)

-- lisame nr piirangu vanuse sisestamisel
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

-- kustutame �he rea
delete from Person where Id = 11

select * from Person

-- kuidas uuendada andmeid
update Person 
set Age = 50 where Id = 4

-- lisame uue veeru
alter table Person
add City nvarchar(50)

-- k�ik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'

-- k�ik, kes ei ela Gothamis
select * from Person where City != 'Gotham'
-- variant nr 2
select * from Person where City <> 'Gotham'

-- n�itab teatud vanusega inimesi
select * from Person where Age in (100, 35, 27)

-- n�itab teatud vanuse vahemikus olevaid inimesi
select * from Person where Age between 20 and 50

-- wildcard e n�itab k�ik g-t�hega linnad
select * from Person where City like 'g%'

-- k�ik emailid, kus on @-m�rk emailis
select * from Person where Email like '%@%'

-- n�itab k�iki, kellel ei ole @-m�rki emailis
select * from Person where Email not like '%@%'

-- tund 2 07.03.2025

-- n�itab, kellel on emailis ees ja peale @-m�rki ainult �ks t�ht
select * from Person where Email like '_@_.com'

-- k�ik, kellel on nimes esimene t�ht W, A, S
select * from Person where Name like '[^WAS]%'
select * from Person

-- kes elavad Gotgamis ja New Yorkis
select * from Person where City in ('Gotham', 'New York')

-- k�ik, kes elavad Gothamis ja New Yorki linnades ja on vanemad, kui 29
select * from Person where City in ('Gotham', 'New York') and Age >= 30

-- kuvab t�hestikuses j�rjekorras inimesi ja v�tab auseks nime
select * from Person order by Name

-- sama p�ring, aga vastupidises j�rjestuses on nimed
select * from Person order by Name desc

-- v�tab kolm esimest rida
select top 3 * from Person

-- kolm esimest, aga tabeli j�rjestus on Age ja siis Name
select top 3 Age, Name from Person

-- n�itab esimesed 50% tabelis
select top 50 percent * from Person

-- j�rjestab vanuse j�rgi isikud
select * from Person order by Age desc

-- muudab Age muutuja INTiks ja n�itab vanuselises j�rjestikuses
select * from Person order by cast(Age as int)

-- k�ikide isikute koondvanus
select sum(cast(Age as int)) from Person

-- kuvab k�ige nooremat isikut
select min(cast(Age as int)) from Person
-- kuvab k�ige vanemat isikut
select max(cast(Age as int)) from Person

-- konkreetsetes linnades olevate isikute koondvanus
-- enne oli Age nvarchar, aga muudame selle int andmet��biks
select City, sum(Age) as totalAge from Person group by City

-- kuidas saab koodiga muuta andmet��pi ja selle pikkust
alter table Person
alter column Name nvarchar(25)

-- kuvab esimeses reas v�lja toodud j�rjestuses ja kuvab Age TotalAge
-- j�rjestab City-s olevate nimede j�rgi ja siis GenderId j�rgi
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId order by City

-- n�itab ridade arvu tabelis
select count(*) from Person
select * from Person

-- n�itab tulemust, et mitu inimest on GenderId v��rtusega 2 konkreetses linnas
-- arvutab vanuse kokku selles linnas
select GenderId, City, sum(Age) as TotalAge, count(Id) as [Total Person(s)]
from Person
where GenderId = '2'
group by GenderId, City

 -- loome, tabelid Employees ja Department
 create table Department
 (
 Id int primary key,
 DepartmentName nvarchar(50),
 Locatiaon nvarchar(50),
 DepartmentHead nvarchar(50)
 )

 create table Employees
 (
 Id int primary key,
 Name nvarchar(50),
 Gender nvarchar(50),
 Salary nvarchar(50),
 DepartmentId int
 )