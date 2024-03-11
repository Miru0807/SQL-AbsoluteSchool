--  1. Modificati interogarea anterioara si ordonati rezultatele dupa nume, crescator. Similar, ordonati dupa varsta, crescator.
use firma;
select now();
select id, nume, data_nasterii from angajati order by nume asc;
select id, nume, data_nasterii, year(now())-year(data_nasterii) as varsta
from angajati
order by varsta asc;

select id, nume, data_nasterii, datediff(now(), data_nasterii) as varsta from angajati;
select id, nume, data_nasterii, datediff(now(), data_nasterii)/365 as varsta from angajati order by data_nasterii desc;

select floor(3.999999999); -- rontunjeste in minus aka - partea intreaga
select round(3.5); -- rotunjeste aritmetic
select ceil (3.000001); -- rotunjeste in plus

--  2.Adaugati departamentul in interogarea anterioara si ordonati rezultatele dupa departament, iar in cadrul departamentului dupa nume.
select id, nume, data_nasterii, floor(datediff(now(), data_nasterii)/365) as varsta, departament from angajati order by departament asc, nume asc;

-- 3.sa se afiseze angajatii nascuti in 1983 din departamentul Soft
select nume, data_nasterii, departament from angajati where year(data_nasterii)= 1983 AND departament='Soft';


select true and true ; -- true 
select true and false ; -- false
select false and true ; -- false 
select false and false ; -- false 

select true or true ; -- true 
select true or false; -- true 
select false or true ; -- true 
select false or false ; -- false 


-- 1. sa se afiseze persoanele din departamentul Soft si Sales
select nume, departament from angajati where departament = 'Soft' or 'Sales';

-- 2. sa se afiseze persoanele din departamentul Soft si Sales cu salariul peste 6000
select nume, departament, salariu from angajati where (departament ='Sales'or departament ='Soft') AND salariu > 6000; -- AND> OR


-- 3.sa se afiseze persoanele din departamentul Sales ordonate dupa salariu crescator
select nume, departament, salariu from angajati where departament = 'Sales' order by salariu asc;

-- 4.sa se afiseze persoanele din departamentul Sales cu salariu intre 2500 si 5000
select nume, departament, salariu from angajati where salariu between 2500 and 5000;

select nume, departament, salariu from angajati where salariu < 5000 and salariu > 2500;
select nume, departament, salariu from angajati where salariu between 2500 and 5000;

-- 5.  Proiectati o interogare ce va afisa: id-ul, numele si data nasterii tuturor angajatilor din departamentul Sales. 
select id, nume, data_nasterii, departament from angajati where departament="Sales";

-- 6.  Proiectati o interogare ce va afisa toti angajatii cu salariul mai mare de 3000. 
select * from angajati where salariu> 3000;

-- 8.  Proiectati o interogare ce va afisa toti angajatii cu pozitia ‘Programator’ sau ‘Manager’.
select nume,pozitie from angajati where pozitie = "programator" or pozitie = "manager" ;
select nume,pozitie from angajati where pozitie IN ("programator","manager");

-- 9.  Proiectati o interogare ce va afisa toti angajatii ce nu au pozitia ‘Programator’ sau ‘Manager’
select nume, pozitie from angajati where pozitie <> 'Programator' AND 'Manager';

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

-- 11. Proiectati o interogare ce va afisa datele celui mai tanar angajat.
select * , floor(datediff(now(), data_nasterii)/365) as varsta from angajati order by data_nasterii desc limit 1; 
-- 12. sa se afiseze cea mai apropiata data de nastere de data curenta 
select  data_nasterii from angajati order by data_nasterii desc limit 1;
-- 13. sa se afiseze toti angajatii care s au nascut in 19 dec 2000
select * from angajati where data_nasterii = '2000-12-19';
select * from angajati where data_nasterii = (select  data_nasterii from angajati order by data_nasterii desc limit 1);
-- 14. sa se afiseze datele celui mai bine platit angajat.
select * from angajati where salariu =(select salariu from angajati order by salariu desc limit 1);
-- 15. sa se afiseze persoana care are cel mai mare salariu de la departamanetul Sales
 select * from angajati where departament='Sales' and salariu = (select salariu from angajati where departament = 'sales' order by salariu desc limit 1);
 
 
-- 12. Proiectati o interogare ce va afisa datele celui mai batran angajat.
select *, floor(datediff(now(), data_nasterii)/365) as varsta from angajati where data_nasterii = (select data_nasterii from angajati order by data_nasterii asc limit 1); 
-- 13. Proiectati o interogare ce va afisa toti salariatii angajati in anul 2019.
alter table angajati add column data_angajarii date default "2020-01-01";
select * from angajati;
select rand();
select floor(rand() * 2000);
select date_add("2023-07-30", interval -floor(rand() * 2000) day);
update angajati set data_angajarii = date_add("2023-07-30", interval -floor(rand() * 2000) day);
select * from angajati where year(data_angajarii)= 2019;


-- exercitii 5.08.2023
-- 14.  Proiectati o interogare ce va afisa angajatii ce urmeaza sa isi serbeze ziua de nastere in luna curenta.
 select * from angajati where month(data_nasterii)=month(now()) and day(data_nasterii)>day(now());
 -- 15. sa se afiseze persoanele cu cel mai mare salariu de la un departament care incepe cu litera  S
 select * from angajati where salariu= (select salariu from angajati where (left(departament,1)="s") order by salariu desc limit 1) and left(departament,1)="s";
 select * from angajati where data_nasterii = (select data_nasterii from angajati where pozitie = "director" order by data_nasterii desc limit 1) and pozitie = "director";
 -- 15.  Proiectati o interogare ce va afisa: id-ul, numele si varsta (in ani) a tuturor angajatilor.
 select id, nume, concat(floor(datediff(now(), data_nasterii)/365)," ani") as varsta from angajati;
 -- 16. Proiectati o interogare ce va afisa: id-ul, numele, prenumele, pozitia si varsta (in ani) a tuturor angajatilor.
 -- TEORIE
select length("ana are mere"); -- calculeaza lungimea (ca numar de caractere)
select locate("n","ana are mere"); -- localizeaza primul caractrer de la stanga la dreapta 
select replace("ana are banane", "ana ", "vasilica ");
select substring_index("a fost odata ca in povesti a fost ca niciodata", "a", -5);
select substring("a fost odata ca in povesti a fost ca niciodata",3,10);
select mid("a fost odata ca in povesti a fost ca niciodata",3,10);
-- REZOLVARE
select * from angajati;
select locate(' ', nume), nume from angajati;
select substring_index(nume, " ", -1) from angajati; -- AFISEAZA NUMELE DE FAMILIE
select id, 
     left(nume, locate(substring_index(nume, " ", -1), nume) -2) as prenume, 
     substring_index(nume, " ", -1) as nume_famile, pozitie,
     concat(floor(datediff(now(), data_nasterii)/365), " ani") as varsta 
        from angajati;
SELECT SUBSTRING(nume,1,LOCATE(SUBSTRING_INDEX(nume, ' ', - 1), nume) - 2) AS prenume FROM angajati;
-- A DOUA REZOLVARE
select substring_index(nume,substring_index(nume, " ", -1),1) as prenume, nume from angajati;
-- A TREIA REZOLVARE
select left(nume,length(nume)-length(substring_index(nume, " ", -1)) -1) as prenume from angajati;
-- A PATRA REZOLVARE
select replace("ana are banane", "ana ", "vasilica ");
select substring_index(nume, " ", -1) from angajati;
select replace(nume,substring_index(nume, " ", -1), '') from angajati;

-- 17.  Modificati interogarea anterioara astfel incat numele campurilor sa aiba titlurile “ID”, “Nume angajat”, “Prenume angajat”, “Pozitia ocupata”, “Varsta”.
select id as ID, 
     left(nume, locate(substring_index(nume, " ", -1), nume) -2) as 'Prenume angajat', 
     substring_index(nume, " ", -1) as 'Nume angajat', 
     pozitie as 'Pozitie ocupata',
     concat(floor(datediff(now(), data_nasterii)/365), " ani") as 'Varsta' 
        from angajati;
        
-- 18. Modificati din nou interogarea anterioara, astfel incat varsta angajatilor sa apara sub forma “x ani”.
-- o avem deja
-- 19. Proiectati o interogare ce va afisa toti angajatii cu varsta cuprinsa intre 20 si 30 de ani.
 select id, nume, concat(floor(datediff(now(), data_nasterii)/365)," ani") as varsta from angajati having varsta > 20 and varsta < 30;
 select id, nume, concat(floor(datediff(now(), data_nasterii)/365)," ani") as varsta from angajati having varsta between 20 and 30; -- la between ne ia si capetele
 
 -- 20. Proiectati o interogare ce va afisa toti angajatii ordonati dupa numele de familie.
 SELECT id, substring_index(nume, " ", -1) as nume, replace(nume,substring_index(nume, " ", -1), '') as prenume from angajati ORDER BY nume asc;

-- 21.  Proiectati o interogare ce va afisa cei mai vechi 3 angajati.
select * from angajati;
select nume, floor(datediff(now(), data_angajarii)/365) as vechime from angajati order by vechime desc limit 3;
 
 -- EXTRA Sa se afiseze departamentul/departamentele cu cel mai mic salariu.
 select departament, salariu from angajati where salariu = (SELECT MIN(salariu)from angajati);
 select * from angajati;
 update angajati set salariu = 1000 where id = 4;
 -- Extra Sa se afiseze prenumele, varsta si departamentul celui mai varstnic angajat de la Sales
 select * , floor(datediff(now(), data_nasterii)/365) as varsta from angajati;
 select SUBSTRING(nume,1,LOCATE(SUBSTRING_INDEX(nume, ' ', - 1), nume) - 2) as prenume, floor(datediff(now(), data_nasterii)/365) as varsta from angajati where departament='Sales' limit 1;
 -- REZOLVAREA MEA CORECTATA
 select SUBSTRING(nume,1,LOCATE(SUBSTRING_INDEX(nume, ' ', - 1), nume) - 2) as prenume, 
	floor(datediff(now(), data_nasterii)/365) as varsta from angajati 
		where departament='Sales' 
        having varsta =(select  floor(datediff(now(), data_nasterii)/365) as varsta from angajati
        where departament='Sales' order by varsta desc limit 1); -- limit doar in subquery
 update angajati set data_nasterii= '1983-06-09' where id = 6;
 -- ALTA REZOLVARE CORECTATA
 select replace(nume,substring_index(nume, " ", -1), '') as prenume, floor(datediff(now(), data_nasterii)/365) as varsta,
departament from angajati where departament = "Sales" having varsta  = (select max(floor(datediff(now(), data_nasterii)/365)) from angajati where departament = "Sales");

 -- TEMA pt 5.08.2023

-- 1. Sa se afiseze persoanele al caror nume incepe cu litera C si au salariul peste 4900. MI A VERIFICAT EX!

use firma;
select * from angajati where left(nume,1)="C" AND salariu>4900;

select * from angajati where mid(nume, 1,1)='C';
select * from angajati where locate('C',nume)=1;
select * from angajati where ascii(nume)=ascii('C');

-- 2. sa se afiseze persoanele nascute in luna decembrie si au salariul sub 5000
use firma;
SELECT * FROM angajati WHERE MONTH(Data_Nasterii) = 12 AND Salariu < 5000;

select * from angajati where month(data_nasterii)=12 and salariu<5000; -- VERIFICATA
-- 3. sa se afiseze persoanele cu cel mai mare salariul si care s-au nascut dupa 2000 
select * from angajati;
SELECT * FROM Angajati WHERE YEAR(Data_Nasterii) >= 2000 AND Salariu = (SELECT MAX(Salariu) FROM Angajati WHERE YEAR(Data_Nasterii) >= 2000);
select * from angajati where salariu=(select salariu from angajati where year(data_nasterii)>2000 order by salariu desc limit 1) and year(data_nasterii)>2000;
-- 4. sa se afiseze persoana care s-a angajat la cea mai mica varsta si sa se afiseze varsta de angajare 
SELECT *, YEAR(DataAngajarii) - YEAR(Data_Nasterii) AS VarstaAngajare FROM Angajati WHERE YEAR(DataAngajarii) - YEAR(Data_Nasterii) = (SELECT MIN(YEAR(DataAngajarii) - YEAR(Data_Nasterii)) FROM Angajati);
-- CORECTATA
select *, floor(datediff(data_angajarii, data_nasterii)/365) as varsta_angajarii 
from angajati having varsta_angajarii=(select floor(datediff(data_angajarii, data_nasterii)/365) as varsta_angajarii 
from angajati order by varsta_angajarii asc limit 1);
-- 5. sa se afiseze salariul minim pentru angajatii din departamentul sales nascuti dupa 2000 
SELECT MIN(Salariu) 
FROM Angajati 
WHERE Departament = 'sales' AND YEAR(DataNasterii) > 2000;
-- CORECTATA
 select nume,salariu,departament,data_nasterii from angajati
	where salariu=(select min(salariu) from angajati where year(data_nasterii) >=2000 and departament = "sales" )
		and year(data_nasterii)>=2000 and departament = "sales";
        
-- 6. sa se afiseze persoanele nascute in zodia leu
SELECT * FROM Angajati WHERE (MONTH(Data_Nasterii) = 7 AND DAY(Data_Nasterii) >= 23) OR (MONTH(Data_Nasterii) = 8 AND DAY(Data_Nasterii) <= 22);
SELECT nume, data_nasterii,
	CASE
        WHEN MONTH(data_nasterii) = 7 AND DAY(data_nasterii) >= 23 THEN 'Leu'
        WHEN MONTH(data_nasterii) = 8 AND DAY(data_nasterii) <= 22 THEN 'Leu'
        ELSE 'Altă zodie'
    END AS zodie FROM angajati;
    
    -- TEMA PT 8.08.23
   
    -- 1. sa se afiseze numele si prenumele, data_nasterii si varsta pentru persoanele ce s-au angajat de ziua lor.
    alter table angajati add column data_angajarii date default "2020-01-01";
    select * from angajati;
    -- CORECTATA:
    select 
		substring_index(nume, " ", -1) as Nume, 
		left(nume,locate(substring_index(nume, " ", -1), nume)-2) as Prenume, 
		data_nasterii,
		floor(datediff(now(),data_nasterii)/365) as Varsta
	from angajati
    where day(data_nasterii)=day(data_angajarii) and month(data_nasterii)=month(data_angajarii);
    update angajati set data_nasterii="1983-04-28" where id=4;
     select data_nasterii, SUBSTRING(nume,1,LOCATE(SUBSTRING_INDEX(nume, ' ', - 1), nume) - 2) as prenume, floor(datediff(now(), data_nasterii)/365) as varsta, substring_index(nume, " ", -1) as nume from angajati where data_anagajarii= data_nasterii;
    -- 2. sa se afiseze numele si prenumele , departamentul si varsta la angajare ordonate descrescator in functie de varsta la angajare.
    SELECT SUBSTRING(nume,1,LOCATE(SUBSTRING_INDEX(nume, ' ', - 1), nume) - 2) as prenume, salariu, pozitie FROM angajati WHERE pozitie = 'Vanzator' ORDER BY salariu DESC LIMIT 1;
    -- CORECTATA
    select substring_index(nume, " ", -1) as "Nume angajat", 
left(nume, locate(substring_index(nume, " ", -1), nume) -2) as "Prenume angajat", 
Departament, 
floor(datediff(data_angajarii, data_nasterii)/365) as Varsta_angajare
from angajati order by Varsta_angajare desc;
    -- 3. sa se afiseze prenumele , salariul si pozitia pentru cel mai bine platit vanzator
      SELECT SUBSTRING(nume,1,LOCATE(SUBSTRING_INDEX(nume, ' ', - 1), nume) - 2) as prenume, salariu, pozitie FROM angajati;
      -- CORECTATA
      select replace(nume,substring_index(nume," ",-1),"") as Prenume,Salariu,Pozitie
	from angajati where salariu=(select max(salariu) from angajati where pozitie = "vanzator") and pozitie = "vanzator"  ;
    -- 4. sa se afiseze nmumele de familie si data_nasterii pentru cea mai veche persoana de pe pozitia de Director.
    SELECT nume, data_nasterii FROM angajati WHERE pozitie = 'Director' ORDER BY data_nasterii ASC LIMIT 1;
    -- CORECTATA
    SELECT  substring_index(nume, " ", -1) as nume , data_nasterii from angajati 
     where pozitie = "director" and floor(datediff(now(), data_angajari)/365) = (select max(floor(datediff(now(), data_angajari)/365)) 
		from angajati where pozitie="director");
    -- 5. sa se afiseze prenumele celei mai tinere persoane de la sales si care are salariul peste 2500.
    -- CORECTATA
    select substring_index(nume, substring_index(nume, " ", -1),1) as prenume,
 floor(datediff(now(), data_nasterii)/356) as varsta from angajati
	where left(departament,1)="s" and salariu>2500  -- departament="sales"
		having varsta=(select min(floor(datediff(now(), data_nasterii)/356)) from angajati
			where left(departament,1)="s" and salariu>2500);
     -- 6. sa se afiseze prenumele celei mai varstnice persoane de la la un departament ce incepe cu litera S  si care are salariul peste 2500
     -- CORECTATA
     select replace(nume, substring_index(nume, " ", -1), " ") as prenume, departament, salariu, 
floor(datediff(now(), data_nasterii)/365) as varsta from angajati where locate("s", departament) = 1
and salariu > 2500 and data_nasterii = (select min(data_nasterii) from angajati where locate("s", departament)= 1
and salariu > 2500);
     -- 7. sa se afiseze prenumele si salariul pentru cea mai veche persoana al carei nume de familie incepe cu H si face parte dintr-un departament ce incepe cu S 
SELECT prenume, salariu FROM angajati WHERE nume LIKE 'H%' AND departament LIKE 'S%' ORDER BY data_nasterii ASC LIMIT 1;
-- CORECTATA
SELECT  substring_index(nume, " ", 1) as prenume, salariu from angajati 
		where left(departament,1)="s" and left(substring_index(nume, " ", -1),1)="H"
			and floor(datediff(now(), data_angajari)/365) = (select max(floor(datediff(now(), data_angajari)/365))  from angajati
				where left(departament,1)="s" and left(substring_index(nume, " ", -1),1)="H");


