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
select nume, year(data_nasterii) as anul_nasterii from angajati where year(data_nasterii) > 1989;
select nume, year(data_nasterii) as anul_nasterii from angajati having anul_nasterii > 1989;
-- tema 
-- sa se afiseze persoanele din departamentul Sales 
-- sa se afiseze persoanele nascute in luna septembrie
-- sa se afiseze persoanele ce au salariu peste 3000 de lei

-- Modificati interogarea anterioara si ordonati rezultatele dupa nume, crescator. Similar, ordonati 
--  dupa varsta, crescator. 
use firma6;
select id, nume, data_nasterii from angajati order by nume asc;
select id, nume, data_nasterii, year(now())-year(data_nasterii) as varsta
from angajati
order by varsta asc;

select id, nume, data_nasterii, datediff(now(), data_nasterii) as varsta from angajati;
select id, nume, data_nasterii, datediff(now(), data_nasterii)/365 as varsta from angajati;

select floor(3.99999999); -- rotunjeste in minus aka - partea intreaga
select round(3.5); -- rotunjeste aritmetic
select ceil(3.000001); -- rotunjeste in plus   

select id, nume, data_nasterii,  floor(datediff(now(), data_nasterii)/365) as varsta from angajati order by data_nasterii desc;

-- 4.  Adaugati departamentul in interogarea anterioara si ordonati rezultatele dupa departament, iar in cadrul departamentului dupa nume. 
select id, nume, data_nasterii,  floor(datediff(now(), data_nasterii)/365) as varsta, departament from angajati order by departament asc, nume asc;

-- sa se afiseze angajatii nascuti in 1983 din departamentul Soft
select  true and true ; -- true 
select true and false ; -- false
select false and true ; -- false 
select false and false ; -- false 

select true or true ; -- true 
select true or false; -- true 
select false or true ; -- true 
select false or false ; -- false 

select nume, data_nasterii, departament from angajati where year(data_nasterii)=1983 and departament='Soft';

-- sa se afiseze persoanele din departamentul Soft si Sales 

select nume,departament from angajati where departament="soft" or departament="sales";

-- sa se afiseze persoanele din departamentul soft si sales cu salariul peste 6000 

select nume, departament, salariu from angajati where (departament="Soft" or departament="Sales") and salariu > 6000; -- AND > OR 


-- sa se afiseze persoanle din departamentul sales ordonate dupa salariu crescatror

-- sa se afiseze persoanele din departamentul sales cu salariul intre 2500 si 5000
select nume, departament, salariu from angajati where departament="sales" and (salariu < 5000 and salariu > 2500);
select nume, departament, salariu from angajati where departament="sales" and salariu between 2500 and 5000;

-- 5.  Proiectati o interogare ce va afisa: id-ul, numele si data nasterii tuturor angajatilor din departamentul Sales. 
select id, nume, data_nasterii, departament from angajati where departament="Sales";

-- 6.  Proiectati o interogare ce va afisa toti angajatii cu salariul mai mare de 3000. 
select * from angajati where salariu> 3000;

-- 7.  Proiectati o interogare ce va afisa toti angajatii cu salariul intre 2500 si 5000. 
select nume, departament, salariu from angajati where departament="sales" and salariu between 2500 and 5000;

-- 8.  Proiectati o interogare ce va afisa toti angajatii cu pozitia ‘Programator’ sau ‘Manager’. 
select nume,pozitie from angajati where pozitie = "programator" or pozitie = "manager" ;
select nume,pozitie from angajati where pozitie IN ("programator","manager");

-- 9.  Proiectati o interogare ce va afisa toti angajatii ce nu au pozitia ‘Programator’ sau ‘Manager’. 
select * from angajati where pozitie not in("programator","manager");
select * from angajati where not pozitie in ("programator","manager");
select * from angajati where pozitie != "programator" and pozitie != "manager";
select * from angajati where pozitie <>"programator" and pozitie <>"manager";

-- 10. Proiectati o interogare ce va afisa toti angajatii al caror nume incepe cu litera “B”. 

select left("abecedar", 2);
select right("abecedar", 5);
select mid("abecedar", 2,1); -- mid("sirul de caractere", start, lungime)
select locate("m", "Am cumparat un abecedar");
select ascii("Bogdan");

select * from angajati where left(nume,1)="B";
select * from angajati where mid(nume, 1,1)='B';
select * from angajati where locate('B',nume)=1;
select * from angajati where ascii(nume)=ascii('B');
-- 

-- 11. Proiectati o interogare ce va afisa datele celui mai tanar angajat. 

-- 11. Proiectati o interogare ce va afisa datele celui mai tanar angajat.
select * , floor(datediff(now(), data_nasterii)/365) as varsta from angajati order by data_nasterii desc limit 1; 
-- 12. sa se afiseze cea mai apropiata data de nastere de data curenta 
select  data_nasterii from angajati order by data_nasterii desc limit 1;
-- 13. sa se afiseze toti angajatii care s au nascut in 19 dec 2000
select * from angajati where data_nasterii = '2000-12-19';
select * from angajati where data_nasterii = (select  data_nasterii from angajati order by data_nasterii desc limit 1);

-- sa se afiseze datele celui mai bine platit angajat 
select * from angajati where salariu =(select salariu from angajati order by salariu desc limit 1);
select * from angajati where salariu =(select max(salariu) from angajati );

-- sa se afiseze cel mai mare salariu de la Sales
 -- sa se afiseze cel mai mare salariu, de la sales
 select * from angajati where departament='Sales' and salariu = (select salariu from angajati where departament = 'sales' order by salariu desc limit 1);
 
 -- 12. Proiectati o interogare ce va afisa datele celui mai batran angajat. 
-- 13. Proiectati o interogare ce va afisa toti salariatii angajati in anul 2019. 
select rand(); -- genereaza un numar aleatoriu intre 0 si 1 
select date_add(now(), interval -365 day);

alter table angajati add column data_angajarii date default "2020-01-01";
select * from angajati;
select rand();
select floor(rand() * 2000);
select date_add("2023-07-30", interval -floor(rand() * 2000) day);
update angajati set data_angajarii = date_add("2023-07-30", interval -floor(rand() * 2000) day);
select * from angajati where year(data_angajarii)= 2019;

-- 14. Proiectati o interogare ce va afisa angajatii ce urmeaza sa isi serbeze ziua de nastere in luna curenta. 
 select * from angajati where month(data_nasterii)=month(now()) and day(data_nasterii)>day(now());
 

 -- sa se afiseze pers cu cel mai mare salariu de la un departament ce incepe cu litera S;
select * from angajati where salariu= (select max(salariu) from angajati where left(departament,1)="s") and left(departament,1)="s";
select * from angajati;
-- sa se afiseze cel mai tanar director

-- TEMA 

-- Sa se afiseze persoanele al caror nume incepe cu litera C si au salariul peste 4900 
select * from angajati where left(nume,1)="C" AND salariu>4900;
-- sa se afiseze persoanele nascute in luna decembrie si au salariul sub 5000
select * from angajati where month(data_nasterii)=12 and salariu<5000;
-- sa se afiseze persoanele cu cel mai mare salariul si care s-au nascut dupa 2000 
select * from angajati;select * from angajati where salariu=(select salariu from angajati where year(data_nasterii)>2000 order by salariu desc limit 1) and year(data_nasterii)>2000;
SELECT * FROM Angajati WHERE YEAR(Data_Nasterii) >= 2000 AND Salariu = (SELECT MAX(Salariu) FROM Angajati WHERE YEAR(Data_Nasterii) >= 2000);
-- sa se afiseze persoana care s-a angajat la cea mai mica varsta si sa se afiseze varsta de angajare
select *, floor(datediff(data_angajarii, data_nasterii)/365) as varsta_angajarii 
from angajati having varsta_angajarii=(select floor(datediff(data_angajarii, data_nasterii)/365) as varsta_angajarii 
from angajati order by varsta_angajarii asc limit 1); 
-- sa se afiseze salariul minim pentru angajatii din departamentul sales nascuti dupa 2000 
-- sa se afiseze persoanele nascute in zodia leu

select dayofyear(now());
select dayofyear('2000-07-23'); -- 205
select dayofyear('2000-08-23'); -- 236
select * from angajati where dayofyear(data_nasterii) between  dayofyear('2000-07-23') and dayofyear('2000-08-23');
select * from angajati where dayofyear(data_nasterii) between 205 and 236;
select * from angajati where (month(data_nasterii)=07 and day(data_nasterii)>=23) 
							or (month(data_nasterii)=08 and day(data_nasterii)<=23);
                            

-- 15. Proiectati o interogare ce va afisa: id-ul, numele si varsta (in ani) a tuturor angajatilor. 
select id, nume, concat(floor(datediff(now(), data_nasterii)/365)," ani") as varsta from angajati;

-- 16. Proiectati o interogare ce va afisa: id-ul, numele, prenumele, pozitia si varsta (in ani) a tuturor 
-- angajatilor. 

select length("ana are mere"); -- calculeaza lungimea (ca numar de caractere)
select locate("n","ana are mere"); -- localizeaza primul caractrer de la stanga la dreapta 
select replace("ana are banane", "ana ", "vasilica ");
select substring_index("a fost odata ca in povesti a fost ca niciodata", "a", -5);
select substring("a fost odata ca in povesti a fost ca niciodata",3,10);
select mid("a fost odata ca in povesti a fost ca niciodata",3,10);

select * from angajati;
-- 
select id, 
		left(nume, locate(substring_index(nume, " ", -1), nume) -2) as prenume,
        substring_index(nume, " ", -1) as nume_famile, pozitie, 
        concat(floor(datediff(now(), data_nasterii)/365), " ani") as varsta 
			from angajati;
            
	select substring_index(nume,substring_index(nume, " ", -1),1) as prenume, nume from angajati;
    select left(nume,length(nume)-length(substring_index(nume, " ", -1)) -1) as prenume from angajati;
    select replace(nume, substring_index(nume, " ", -1), "") from angajati;
    
-- 17. Modificati interogarea anterioara astfel incat numele campurilor sa aiba titlurile “ID”, “Nume 
--  angajat”, “Prenume angajat”, “Pozitia ocupata”, “Varsta”. 

select id as ID, 
		left(nume, locate(substring_index(nume, " ", -1), nume) -2) as "Prenume angajat",
        substring_index(nume, " ", -1) as 'Nume angajat', 
        `pozitie` as `Pozitie ocupata`, 
        concat(floor(datediff(now(), data_nasterii)/365), " ani") as Varsta 
			from angajati;
            
-- 18. Modificati din nou interogarea anterioara, astfel incat varsta angajatilor sa apara sub forma “x ani”. 

-- 19. Proiectati o interogare ce va afisa toti angajatii cu varsta cuprinsa intre 20 si 30 de ani. 
select nume,concat(floor(datediff(now(), data_nasterii)/365), " ani") as varsta from angajati having varsta >=20 and varsta <= 30;
select nume,concat(floor(datediff(now(), data_nasterii)/365), " ani") as varsta from angajati having varsta  between 20 and 30;

-- 20. Proiectati o interogare ce va afisa toti angajatii ordonati dupa numele de familie. 

-- 21. Proiectati o interogare ce va afisa cei mai vechi 3 angajati. 

-- sa se afiseze departamentul/ele cu cel mai mic salariu 
 select departament, salariu from angajati where salariu = (SELECT MIN(salariu)from angajati) and departament is not null ;
 select * from angajati;
 update angajati set salariu = 1000 where id = 4;
 
 -- sa se afiseze  prenumele, varsta si departamentul celui mai varstnic angajat de la sales 
SELECT 
    SUBSTRING(nume, 1, LOCATE(SUBSTRING_INDEX(nume, ' ', - 1), nume) - 2) AS prenume,
    FLOOR(DATEDIFF(NOW(), data_nasterii) / 365) AS varsta
FROM
    angajati
WHERE
    departament = 'Sales'
HAVING varsta = (SELECT 
        FLOOR(DATEDIFF(NOW(), data_nasterii) / 365) AS varsta
    FROM
        angajati
    WHERE
        departament = 'Sales'
    ORDER BY varsta DESC
    LIMIT 1); -- limit doar in subquery
    -- tema
    -- sa se afiseze numele si prenumele, data_nasterii si varsta pentru persoanele ce s-au angajat de ziua lor
    -- sa se afiseze numele si prenumele , departamentul si varsta la angajare ordonate descrescator in functie de varsta la angajare
    -- 2) sa se afiseze numele si prenumele, departamentul si varsta la angajare ordonate descrescator in functie de varsta la angajare
select substring_index(nume, " ", -1) as "Nume angajat", 
left(nume, locate(substring_index(nume, " ", -1), nume) -2) as "Prenume angajat", 
Departament, 
floor(datediff(data_angajarii, data_nasterii)/365) as Varsta_angajare
from angajati order by Varsta_angajare desc;
    -- sa se afiseze prenumele , salariul si pozitia pentru cel mai bine platit vanzator
    -- sa se afiseze nmumele de familie si data_nasterii pentru cea mai veche persoana de pe pozitia de Director
    -- sa se afiseze prenumele celei mai tinere persoane de la sales si care are salariul peste 2500
     -- sa se afiseze prenumele celei mai varstnice persoane de la la un departament ce incepe cu litera S  si care are salariul peste 2500
     -- sa se afiseze prenumele si salariul pentru cea mai veche persoana al carei nume de familie incepe cu H si face parte dintr-un departament ce incepe cu S 
use firma;
select * from angajati;

-- 22. Proiectati o interogare ca va afisa toate pozitiile din cadrul firmei.
select distinct pozitie from angajati;

-- 23. Proiectati o interogare care va afisa suma platita lunar pentru salarii
select sum(salariu) as suma from angajati;

-- 24. Proiectati o interogare care va afisa bugetul pentru fiecare departament
select sum(salariu) as buget, departament from angajati group by departament;

-- SELECT -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY -> LIMIT 

-- 25. Proiectati o interogare care va afisa departamentul cu bugetul maxim.

-- 26. Proiectati o interogare care va afisa varsta medie si salariul mediu al angajatilor.
select floor(avg( datediff(now(), data_nasterii)/365)) as varsta_medie, round(avg(salariu)) from angajati;

-- -- 27. Proiectati o interogare ce va afisa salariul mediu pentru fiecare departament. 
select round(avg(salariu)) as salariu_mediu, departament from angajati group by departament;
-- 28. Proiectati o interogare ce va afisa departamentele cu salariul mediu peste 5000.
select departament, avg(salariu) as sal_mediu from angajati group by departament having sal_mediu>5000;
select * from angajati;

alter table angajati add column prenume varchar(250) after nume;

update angajati set prenume = ( substring_index(nume, substring_index(nume, " ", -1),1) );
update angajati set departament="soft" where id=5;

-- 30. Proiectati o interogare care va afisa data numele, departamentul si data angajarii tuturor angajatilor, in formatul dd.mm.yyyy, ordonati dupa departament si apoi dupa data angajarii
update angajati set nume = (substring_index(nume, " ", -1));
-- sa trreaca angajatul andrei ionescu in departamentul Soft
-- sa se sparga numele si prenumele in doua coloane diferite


-- 31. Proiectati o interogare care va modifica numele departamentului Soft in Software.
update angajati set departament="Sofware" where departament="Soft";

-- 32. Proiectati o interogare care va micsora salariile tuturor angajatilor din departamentul Sales cu 10%.

-- tema 
-- sa se afiseze media de varsta si media de vechime pe departamente 
-- sa se afiseze pozitia cu cea mai mare medie a salariilor 
-- sa se afiseze media salariilor pe departamente tinand cont ca numele departamentului trebuie sa inceapa cu litera S 
-- sa se afiseze angajatii ce au salariul mai mare decat media salariilor de pe firma
-- sa se afiseze angajatii al caror salariu este mai mare decat media salariilor aferente departamentului din care fac parte
