-- DDL
-- CRUD  (CREATE READ UPDATE DELETE)
create database firma6; -- CREATE in DDL
-- comentariile le trecem cu --  (nu se executa)

/*
	acesta
    este
    un
    comentariu pe mai multe 
    randuri
*/
-- afisam o lista a bazelor de date
show databases; -- READ din DDL

drop database firma6; -- DELETE din DDL

use firma6;-- specificam ce baza de date sa utilizeze in viitoarele interogari 
show tables;

create table angajati
(
	id int primary key auto_increment,
    nume varchar(255),
    data_nasterii date,
    pozitie varchar(255),
	departament varchar(255),
    salariu int default 1000
);


/*
 1
 2
 3
 4
 
 6
 7
 8
*/


-- pentru mai multe detalii folosim intructiunea describe
describe angajati;

-- sa se adauge coloana obs
alter table angajati add column obs varchar(255) default 'obs1';

-- sa se actualizeze coloana obs in observatii
alter table angajati change column obs observatii varchar(200) default null after pozitie;

-- sa se stearga coloana observatii
alter table angajati drop column observatii;

-- DML
-- sa se insereze date in tabela angajati  -- create in DML
insert into angajati values
(null, "Bogdan Florea", "1983-03-27", "Programator", "Soft", 5000),
(null, "Ana Patrascu", "1987-12-12", "Secretara","Marketing", 2500),
(null, "George Mihalache","1977-09-14", "Director","Mangament",8500);

-- read in DML  - afisarea datelor 
select * from `angajati`;

insert into angajati(nume, salariu, pozitie, data_nasterii, departament, id) values 
		("Carmelita Stoian", 5000, "Vanzator", "1983-06-06", "Sales", 4);

insert into angajati(data_nasterii, id, nume) values
("1982-08-15", 5, "Andrei Ionescu");


-- sa se treaca pozitia lui Andrei Ionescu ca programator

update angajati set pozitie="Programator" where id=5;

--  Proiectati o interogare ce va insera 3 angajati in departamentul Sales
-- Cristian Harabor, 4500, Inspector, 9 septembrie 2000, 
-- Director, 9620, Ion Ion Harabor, 19/12/2000
-- 7650, Maria Harabor, 09.04.2000, Manager 

insert into angajati(nume, salariu, pozitie, data_nasterii, departament, id) values 
("Cristian Harabor", 4500, "Inspector", "2000-09-09", "Sales", 6);


-- Director, 9620, Ion Ion Harabor, 19/12/2000,
insert into angajati (nume, salariu, pozitie, data_nasterii, departament, id) values
('Ion Ion Harabor', 9620, 'Director', '2000-12-19', 'Sales', 7 );

-- 7650, Maria Harabor, 09.04.2000, Manager
insert into angajati( `salariu`, `nume`, `pozitie` ,`data_nasterii`, `departament`, `id`) values
(7650, 'Maria Harabor', 'Manager', '2000-04-09', 'Sales', 8);

--   Proiectati o interogare ce va afisa: id-ul, numele si data nasterii tuturor angajatilor. 

select id, nume, data_nasterii from angajati;

-- sa se afiseze numele si anul nasterii pentru toti angajatii
select nume, year(data_nasterii) as anul_nasterii from angajati;
-- sa se afiseze numele si luna si ziua nasterii pentru toti angajatii
select nume, month(data_nasterii) as luna_nasterii, day(data_nasterii) as ziua_nasterii from angajati;

-- sa se afiseze numele si anul nasterii pentru cei nascuti dupa 1989 

-- tema 
-- sa se afiseze persoanele din departamentul Sales 
-- sa se afiseze persoanele nascute in luna septembrie
-- sa se afiseze persoanele ce au salariu peste 3000 de lei
