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

-- võõrvõtme ühenduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

-- kui sisestad uue rea andmeid ja ei ole sisestanud GenderId alla väärtust,
-- siis see automaatselt sisestab sellele reale väärtuse 3 e nagu meil
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

-- kustutame ühe rea
delete from Person where Id = 11

select * from Person

-- kuidas uuendada andmeid
update Person 
set Age = 50 where Id = 4

-- lisame uue veeru
alter table Person
add City nvarchar(50)

-- kõik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'

-- kõik, kes ei ela Gothamis
select * from Person where City != 'Gotham'
-- variant nr 2
select * from Person where City <> 'Gotham'

-- näitab teatud vanusega inimesi
select * from Person where Age in (100, 35, 27)

-- näitab teatud vanuse vahemikus olevaid inimesi
select * from Person where Age between 20 and 50

-- wildcard e näitab kõik g-tähega linnad
select * from Person where City like 'g%'

-- kõik emailid, kus on @-märk emailis
select * from Person where Email like '%@%'

-- näitab kõiki, kellel ei ole @-märki emailis
select * from Person where Email not like '%@%'

-- tund 2 07.03.2025

-- näitab, kellel on emailis ees ja peale @-märki ainult üks täht
select * from Person where Email like '_@_.com'

-- kõik, kellel on nimes esimene täht W, A, S
select * from Person where Name like '[^WAS]%'
select * from Person

-- kes elavad Gotgamis ja New Yorkis
select * from Person where City in ('Gotham', 'New York')

-- kõik, kes elavad Gothamis ja New Yorki linnades ja on vanemad, kui 29
select * from Person where City in ('Gotham', 'New York') and Age >= 30

-- kuvab tähestikuses järjekorras inimesi ja võtab auseks nime
select * from Person order by Name

-- sama päring, aga vastupidises järjestuses on nimed
select * from Person order by Name desc

-- võtab kolm esimest rida
select top 3 * from Person

-- kolm esimest, aga tabeli järjestus on Age ja siis Name
select top 3 Age, Name from Person

-- näitab esimesed 50% tabelis
select top 50 percent * from Person

-- järjestab vanuse järgi isikud
select * from Person order by Age desc

-- muudab Age muutuja INTiks ja näitab vanuselises järjestikuses
select * from Person order by cast(Age as int)

-- kõikide isikute koondvanus
select sum(cast(Age as int)) from Person

-- kuvab kõige nooremat isikut
select min(cast(Age as int)) from Person
-- kuvab kõige vanemat isikut
select max(cast(Age as int)) from Person

-- konkreetsetes linnades olevate isikute koondvanus
-- enne oli Age nvarchar, aga muudame selle int andmetüübiks
select City, sum(Age) as totalAge from Person group by City

-- kuidas saab koodiga muuta andmetüüpi ja selle pikkust
alter table Person
alter column Name nvarchar(25)

-- kuvab esimeses reas välja toodud järjestuses ja kuvab Age TotalAge
-- järjestab City-s olevate nimede järgi ja siis GenderId järgi
select City, GenderId, sum(Age) as TotalAge from Person
group by City, GenderId order by City

-- näitab ridade arvu tabelis
select count(*) from Person
select * from Person

-- näitab tulemust, et mitu inimest on GenderId väärtusega 2 konkreetses linnas
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