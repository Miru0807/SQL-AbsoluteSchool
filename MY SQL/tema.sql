--  Modificati interogarea anterioara si ordonati rezultatele dupa nume, crescator. Similar, ordonati dupa varsta, crescator.
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

--  Adaugati departamentul in interogarea anterioara si ordonati rezultatele dupa departament, iar in cadrul departamentului dupa nume.
select id, nume, data_nasterii, floor(datediff(now(), data_nasterii)/365) as varsta, departament from angajati order by departament asc, nume asc;

-- sa se afiseze angajatii nascuti in 1983 din departamentul Soft
select nume, data_nasterii, departament from angajati where year(data_nasterii)= 1983 AND departament='Soft'


select  true and true ; -- true 
select true and false ; -- false
select false and true ; -- false 
select false and false ; -- false 

select true or true ; -- true 
select true or false; -- true 
select false or true ; -- true 
select false or false ; -- false 


-- sa se afiseze persoanele din departamentul Soft si Sales
select nume, departament from angajati where departament = 'Soft' or 'Sales';

-- sa se afiseze persoanele din departamentul Soft si Sales cu salariul peste 6000
select nume, departament, salariu from angajati where (departament ='Sales'or departament ='Soft') AND salariu > 6000; -- AND> OR


-- sa se afiseze persoanele din departamentul Sales ordonate dupa salariu crescator
select nume, departament, salariu from angajati where departament = 'Sales' order by salariu asc;

-- sa se afiseze persoanele din departamentul Sales cu salariu intre 2500 si 5000
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
-- 14.  Proiectati o interogare ce va afisa angajatii ce urmeaza sa isi serbeze ziua de nastere in luna curenta.
 select * from angajati where month(data_nasterii)=month(now()) and day(data_nasterii)>day(now());
 
 -- sa se afiseze persoanele cu cel mai mare salariu de la un departament care incepe cu litera  S
 select * from angajati where salariu= (select salariu from angajati where (left(departament,1)="s") order by salariu desc limit 1) and left(departament,1)="s";
 
 select * from angajati where data_nasterii = (select data_nasterii from angajati where pozitie = "director" order by data_nasterii desc limit 1) and pozitie = "director";
 
 
 -- TEMA 

-- Sa se afiseze persoanele al caror nume incepe cu litera C si au salariul peste 4900.

use firma;
select * from angajati where left(nume,1)="C";
select * from angajati where salariu> 3000;


select * from angajati where mid(nume, 1,1)='C';
select * from angajati where locate('C',nume)=1;
select * from angajati where ascii(nume)=ascii('C');

-- sa se afiseze persoanele nascute in luna decembrie si au salariul sub 5000
use firma;
SELECT * FROM angajati WHERE MONTH(Data_Nasterii) = 12 AND Salariu < 5000;
-- sa se afiseze persoanele cu cel mai mare salariul si care s-au nascut dupa 2000 
SELECT * 
FROM Angajati 
WHERE YEAR(DataNasterii) > 2000 AND Salariu = (SELECT MAX(Salariu) FROM Angajati WHERE YEAR(DataNasterii) > 2000);
-- sa se afiseze persoana care s-a angajat la cea mai mica varsta si sa se afiseze varsta de angajare 
SELECT *, YEAR(DataAngajarii) - YEAR(DataNasterii) AS VarstaAngajare 
FROM Angajati 
WHERE YEAR(DataAngajarii) - YEAR(DataNasterii) = (SELECT MIN(YEAR(DataAngajarii) - YEAR(DataNasterii)) FROM Angajati);
-- sa se afiseze salariul minim pentru angajatii din departamentul sales nascuti dupa 2000 
SELECT MIN(Salariu) 
FROM Angajati 
WHERE Departament = 'sales' AND YEAR(DataNasterii) > 2000;
-- sa se afiseze persoanele nascute in zodia leu
SELECT * 
FROM Angajati 
WHERE (MONTH(DataNasterii) = 7 AND DAY(DataNasterii) >= 23) OR (MONTH(DataNasterii) = 8 AND DAY(DataNasterii) <= 22);
