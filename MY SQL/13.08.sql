--  22.Proiectati o interogare ca va afisa toate pozitiile din cadrul firmei.
use firma;
select distinct pozitie from angajati;
-- 23.Proiectati o interogare care va afisa suma platita lunar pentru salarii.
select sum(salariu) as suma from angajati;
-- 24. Proiectati o interogare care va afisa bugetul pentru fiecare departament.
-- REGULA
-- SELECT -> FROM -> WHERE -> GROUP BY -> HAVING -> ORDER BY -> LIMIT 
-- 25. Proiectati o interogare care va afisa departamentul cu bugetul maxim.
select sum(salariu) as Buget, departament from angajati group by departament having buget = (select sum(salariu) as buget from angajati group by departament order by buget desc limit 1);
-- 26. Proiectati o interogare care va afisa varsta medie si salariul mediu al angajatilor.
select floor(avg( datediff(now(), data_nasterii))) as varsta_medie, round(avg(salariu)) as salariu_mediu from angajati;
-- 27. Proiectati o interogare ce va afisa salariul mediu pentru fiecare departament.
select round(avg(salariu)) as salariu_mediu, departament from angajati group by departament;
-- 28. Proiectati o interogare ce va afisa departamentele cu salariul mediu peste 5000.
select departament, avg(salariu) as sal_mediu from angajati group by departament; /*having sal_mediu>5000;*/
-- 29. Proiectati o interogare care va afisa numarul managerilor din firma.
select sum(pozitie="manager") from angajati;
select count(pozitie) from angajati where pozitie="manager";
-- 30. Proiectati o interogare care va afisa data numele, departamentul si data angajarii tuturor angajatilor, in formatul dd.mm.yyyy, ordonati dupa departament si apoi dupa data angajarii.
select data_nasterii, nume, departament, date_format(data_angajarii, '%D`%M`%Y') from angajati 
order by departament, data_angajarii asc;

-- EXTRA. Sa se treaca angajatul Andrei Ionescu in departamenrtul Soft
update angajati set departament="soft" where id=7;
alter table angajati add column prenume varchar(250) after nume;

update angajati set prenume = ( substring_index(nume, substring_index(nume, " ", -1),1) );
-- nu rulam interogarea de completarea numelui fara sa verificam faptul ca s-a completat corect prenumele!!Riscam sa-l pierdem !

-- EXTRA. Sa se sparga numele si prenumele in 2 coloane diferite.
update angajati set nume = (substring_index(nume, " ", -1));
-- 31. Proiectati o interogare care va modifica numele departamentului Soft in Software.
update angajati set departament="Sofware" where departament="Soft";
-- 32. Proiectati o interogare care va micsora salariile tuturor angajatilor din departamentul Sales cu 10%.
update angajati set salariu=(salariu*0.9) where departament="Sales";
select * from angajati;

-- 11.08.2023
-- 33. Proiectati o interogare care va mari salariul angajatilor din departamentul Software cu 5%.
select * from angajati;
UPDATE angajati SET salariu = salariu * 0.05 WHERE departament = 'Soft';

-- 34. Proiectati o interogare ce va schimba pozitia celui mai vechi Inspector in Manager. 
 select pozitie, nume, prenume, id, floor(datediff(now(), data_angajarii)/365) as vechime from angajati 
	where pozitie = "Inspector" having vechime = (select max(floor(datediff(now(), data_angajarii)/365)) from angajati where pozitie ="Inspector");
update angajati set pozitie="manager" where id=(select id from (select * from angajati) as a
	where pozitie = "Inspector" 
    having  floor(datediff(now(), data_angajarii)/365) = 
    (select max(floor(datediff(now(), data_angajarii)/365)) from (select * from angajati) as a
    where pozitie ="Inspector"));
-- 35. Proiectati o interogare ce va sterge toti angajatii din departamentul de Marketing.


-- Pasi pentru crearea celei de-a doua tabele
-- pas 1: cream tabela noua departamente si numirea coloanelor respective: id deprtament si nume deprtament
CREATE TABLE Departamente ( ID_Departament int primary key auto_increment, Nume_departament varchar(255) not null unique);
-- pas 2: popularea tabelei departamente cu elementele unice din tabela angajati
insert into departamente (nume_departament, id_departament) (select distinct departament, null from angajati);
-- pas 3: creare coloana noua id_departament in tabela angajati
alter table angajati add column id_departament int after pozitie;
-- pas 4: popularea cu date a noii coloane id_departament in corespondenta cu tabela departament
update angajati set id_departament = (select id_departament from departamente where departamente.nume_departament=angajati.departament);
-- pas 5: stergerea coloanei departament din tabela angajati
alter table angajati drop column departament;
-- pas 6: crearea legaturii intre cele doua tabele
select * from angajati;
update angajati set departament="Soft" where id=5;
update angajati set prenume=left(nume,length(nume)-length(substring_index(nume, " ",-1))-1);
update angajati set nume=substring_index(nume, " ",-1);
update angajati set data_angajarii = date_add("2023-07-30", interval -floor(rand() * 2000) day);
select * from departamente;
update departamente set id_departament=4 where id_departament=39;


alter table  angajati add foreign key fk1(id_departament)
	references departamente(id_departament)
		on delete cascade on update cascade; 



-- TEMA PT 11.08
-- sa se afiseze media de varsta si media de vechime pe departamente.
use firma;
select floor(avg( datediff(now(), data_nasterii)/365)) as varsta_medie, floor(avg( datediff(now(), data_angajarii)/365)) as vechime_medie, departament 
from angajati group by departament;
-- sa se afiseze pozitia cu cea mai mare medie a salariilor 
select pozitie, round(avg(salariu)) as medie_salariu from angajati group by pozitie having 
medie_salariu = (select round(avg(salariu)) as medie_salariu from angajati group by pozitie order by medie_salariu desc limit 1);
-- sa se afiseze media salariilor pe departamente tinand cont ca numele departamentului trebuie sa inceapa cu litera S 
select round(avg(salariu)) as salariu_mediu, departament from angajati where left(departament,1)="s" group by departament;
-- sa se afiseze angajatii ce au salariul mai mare decat media salariilor de pe firma
select nume,prenume,salariu from angajati where salariu > (select avg(salariu) from angajati);
-- sa se afiseze angajatii al caror salariu este mai mare decat media salariilor aferente departamentului din care fac parte
select a.salariu, a.nume, a.prenume, a.departament  from angajati as a
	where a.salariu > (select avg(b.salariu)from angajati as b  where b.departament = a.departament);
    
    
    
    -- 12.08.23
    use firma;
    insert into departamente values(5, "Contabilitate");
    select * from departamente;
    
    use firma;
    select * from angajati;
    
    -- Bogdanovici Bogdan 1992-05-08 programator salariu=8600, angajat din 2018-05-08
insert into angajati (nume, prenume, data_nasterii, pozitie, salariu, data_angajarii) values ("Bogdanovici", "Bogdan", "1992-05-08", "Programator", "8600", "2018-05-08"); 
select * from angajati;
select * from departamente;
select * from angajati, departamente;
select * from angajati join departamente;
select * from departamente as d inner join  angajati as a on a.id_departament=d.id_departament; 
select * from departamente as d left join  angajati as a on a.id_departament=d.id_departament; 
select * from angajati as a  left join departamente as d   on a.id_departament=d.id_departament; 

-- sa se afiseze salariul, numele, prenumele si departamentul pentru TOTI angajatii peste 4000
select a.salariu, a.nume, a.prenume , d.nume_departament from angajati as a left join departamente as d on a.id_departament=d.id_departament where a.salariu>4000;

-- 36. Proiectati o interogare care afiseaza o lista a departamentelor ordonate alfabetic
select Nume_departament from departamente order by Nume_departament asc;
-- 37. Proiectati o interogare ce va afisa o lista a departamentelor si numarul de angajati din departamentul respectiv.
select d.nume_departament,count(a.id) from angajati as a right join departamente as d on 
	a.id_departament=d.id_departament group by d.nume_departament;
    
    select count(a.id) , d.nume_departament from angajati as a left join departamente as d on a.id_departament=d.id_departament group by d.nume_departament
union
select count(a.id), d.nume_departament from angajati as a right join departamente as d on a.id_departament=d.id_departament group by d.nume_departament;



select count(*) as nr_angajati_fara_departament from angajati as a right join departamente as d on a.id_departament=d.id_departament where a.id_departament is null;


-- 38. Proiectati o interogare ce va afisa o lista a departamentelor si salariul mediu, minim si maxim din fiecare departament
select d.nume_departament, round(avg(a.salariu)), min(a.salariu), max(a.salariu) from departamente as d left join
angajati as a on d.id_departament=a.id_departament group by d.nume_departament; 
-- 39. Proiectati o interogare ce va afisa toate departamentele ce au mai putin de 2 angajati
select d.nume_departament, count(a.id) as numar_angajati from departamente as d left join angajati as a on a.id_departament = d.id_departament 
group by d.nume_departament having numar_angajati<2 ;
-- sa se afiseze bugetul pe departamente
select d.nume_departament, sum(a.salariu) as buget from departamente as d right join angajati as a on a.id_departament = d.id_departament group by d.nume_departament;
select d.nume_departament, sum(a.salariu) as buget from departamente as d left join angajati as a on a.id_departament = d.id_departament group by d.nume_departament;

-- sa se afiseze bugetul pe departamente
select d.nume_departament, sum(a.salariu) as buget from departamente as d right join angajati as a on a.id_departament = d.id_departament group by d.nume_departament;
select d.nume_departament, sum(a.salariu) as buget from departamente as d left join angajati as a on a.id_departament = d.id_departament group by d.nume_departament;

-- sa se afiseze departamentul cu cei mai multi angajati
select d.nume_departament, count(a.id) as nr_angajati from angajati as a left join departamente as d
	on a.id_departament=d.id_departament group by d.nume_departament having nr_angajati = 
    (select count(id) as nr_ang from angajati group by id_departament order by nr_ang desc limit 1);
    
-- sa se afiseze departamentul cu cei mai multi programatori
select d.nume_departament, count(a.id) as nr_angajati from angajati as a left join departamente as d
	on a.id_departament=d.id_departament
    where pozitie="Programator"
    group by d.nume_departament 
	having nr_angajati = (select count(id) as nr_ang from angajati where pozitie="Programator"
    group by id_departament order by nr_ang desc limit 1); 
    
    
    -- sa se afiseze cine are cel mai mare salariu din departamentul Sales.
    select a.nume, a.prenume, a.salariu, d.nume_departament from angajati as a left join departamente as d on a.id_departament=d.id_departament
		where d.nume_departament='Sales' and salariu=(select max(a.salariu) from angajati as a left join departamente as d on a.id_departament=d.id_departament where d.nume_departament='Sales');
        
	   -- sa se afiseze departamentul/ departamentele cu cei mai putin angajati exceptand departamentul fara nici un angajat
       select * from angajati;
       select * from departamente;
	select d.nume_departament, count(a.id) as nr_angajati from angajati as a inner join departamente as d on a.id_departament=d.id_departament 
    group by d.nume_departament
    having nr_angajati=(select count(id) as nr1_angajati from angajati group by id_departament order by nr1_angajati asc limit 1);
    
    -- sa se afiseze departamentele cu media salariilor mai mare decat media salariilor pe firma
    select d.nume_departament,round(avg(a.salariu))as salariu_mediu from angajati as a inner join departamente as d on a.id_departament=d.id_departament
	group by d.nume_departament
    having salariu_mediu > (select round(avg(salariu)) from angajati );
    
    -- sa se afiseze media salariilor pe departamente unde salariul depaseste 4500
select d.nume_departament, round(avg(a.salariu)) as medie_sal_dep from angajati as a inner join departamente as d
	on a.id_departament = d.id_departament
    where salariu > 4500
    group by d.nume_departament;
    
    -- 40. Proiectati o interogare ce va afisa doar departamentele ce nu au niciun angajat.
    select * from angajati;
       select * from departamente;
       
    select d.nume_departament, count(a.id) as numar_angajati from angajati as a right join departamente as d on a.id_departament=d.id_departament
	group by d.nume_departament
		having numar_angajati = 0;
        
        -- 41. Proiectati o interogare ce va afisa toti angajatii departamentului Software.
        SELECT * FROM angajati AS a RIGHT JOIN departamente AS d ON a.id_departament = d.id_departament WHERE d.nume_departament = 'Soft';
        select * from angajati as a right join departamente as d on a.id_departament=d.id_departament
	where d.Nume_departament="Soft";
        
        
        -- 42. Proiectati o interogare ce va afisa cel mai bine platit angajat din fiecare departament
        SELECT d.nume_departament, a.nume, a.salariu FROM angajati a INNER JOIN (SELECT id_departament, MAX(salariu) as salariu_maxim FROM angajati GROUP BY id_departament) b 
ON a.id_departament = b.id_departament AND a.salariu = b.salariu_maxim INNER JOIN departamente as d where a.id_departament=d.id_departament;

select a.salariu, d.nume_departament , a.nume, a.prenume from angajati as a right join departamente as d on a.id_departament=d.id_departament
	where salariu= (select max(b.salariu) from angajati as b where a.id_departament=b.id_departament);
    
    
    
    -- Sa se afiseze media salariilor persoanelor nascute inainte de 89 si care fac parte din departamentul Soft
        select * from angajati;
       select * from departamente;
SELECT AVG(a.salariu) AS media_salariilor FROM angajati AS a INNER JOIN departamente AS d ON a.id_departament = d.ID_departament
WHERE a.data_nasterii < '1989-01-01' AND d.Nume_departament = 'Soft';

-- CORECTATA
select d.nume_departament,round(avg(a.salariu)) as Media_salariului from angajati as a 
	inner join departamente as d on a.id_departament=d.id_departament
		where year(a.data_nasterii)<1989 and year(a.data_angajari)>2018 and d.nume_departament="Soft";

-- 43. Proiectati o interogare ce va seta id-ul departamentului Software la valoarea 10. Examinati ce se intampla in tabela angajati.

-- 13.08.2023

-- Proiectati o interogare ce va seta id-ul departamentului Software la valoarea 10. Examinati ce se intampla in tabela angajati.
use firma;
update departamente set id_departament=10 where nume_departament="Soft";
select * from departamente;
select * from angajati;
update departamente set id_departament = 10 where nume_departament = "Software";

-- 44. Proiectati o interogare ce va sterge departamentul Sales. Care va fi rezultatul?
DELETE FROM departmente WHERE nume_department = 'Sales';
-- 45. Modificati cheia straina astfel incat, daca dispare un departament, valoarea campului departament din tabela angajati sa fie setata la NULL. Incercati sa stergeti din nou departamentul Sales.
-- alter table angajati
-- drop foreign key  fk1

alter table angajat add foreign key fk2(id_departament)
references departament(id_departament) 
on delete set null on update set null;
-- 46. Proiectati o interogare care va muta angajatul cu id-ul 5 in departamentul Software.
UPDATE angajati SET departament = 'Soft' WHERE id = 5;

update angajati set id_departament=(select id_departament from departamente where nume_departament='Marketing') where id=5;


-- PASI
-- Pasul 1 CREAREA TABELEI ANGAJATI CONFIDENTIALI
-- Pasul 2 POPULARE CU DATE A NOII TABELE
-- Pasul 3 STERGEREA COLOANEI SALARIU DIN TABELA ANGAJATI
-- Pasul 4 CREAREA LEGATURII INTRE TABELE



-- Pas 2 GENERARE DE CNP
-- GENERARE CNP
-- PRIMUL CARACTER (BARBAT SAU FEMEIE INAINTE SAU DUPA 2000)
-- URMATOARELE 6 CARACTERE DIN DATA NASTERII


-- ULTIMELE 6 CARACTERE PE BAZA DE ID (DACA ID=1 => 000001 ; DACA ID=10 => 000010 ; DACA ID =1000 => 001000)
create table angajati_confidential (
	id int primary key auto_increment,
    salariu int,
    CNP char(13) unique
);
describe angajati_confidential;
select * from angajati;

select if(right(prenume,1)="a", "F", "B") , prenume from angajati;
select case
			when year(data_nasterii)<2000 and right(prenume,1)="a" then "2"
            when year(data_nasterii)>=2000 and right(prenume,1)="a" then "6"
            when year(data_nasterii)<2000 and right(prenume,1)!="a" then "1"
            when year(data_nasterii)>=2000 and right(prenume,1)!="a" then "5"
		else "-"
        end as prima_cifra, data_nasterii, prenume from angajati;
select data_nasterii, date_format(data_nasterii, '%y%m%d') from angajati ;

select concat(
				case
					when year(data_nasterii)<2000 and right(prenume,1)="a" then "2"
					when year(data_nasterii)>=2000 and right(prenume,1)="a" then "6"
					when year(data_nasterii)<2000 and right(prenume,1)!="a" then "1"
					when year(data_nasterii)>=2000 and right(prenume,1)!="a" then "5"
				else "-"  end, 
                date_format(data_nasterii, '%y%m%d'),
				right(concat("00000", id),6)
        ) as cnp from angajati;
        
  insert into angajati_confidential( select id, salariu, concat(
				case
					when year(data_nasterii)<2000 and right(prenume,1)="a" then "2"
					when year(data_nasterii)>=2000 and right(prenume,1)="a" then "6"
					when year(data_nasterii)<2000 and right(prenume,1)!="a" then "1"
					when year(data_nasterii)>=2000 and right(prenume,1)!="a" then "5"
				else "-"  end, 
                date_format(data_nasterii, '%y%m%d'),
				right(concat("00000", id),6)
        ) from angajati
);
select * from angajati_confidential;
alter table angajati_confidential add foreign key fk2(id)
references angajati(id)
	on delete cascade on update cascade;

 -- sa se afiseze numele, prenumele , departamentul si salariul fiecarui angajat
    select a.nume, a.prenume, d.nume_departament, ac.salariu 
		from angajati as a left join departamente as d 
									on a.id_departament=d.id_departament 
						   left join angajati_confidential as ac 
									on a.id=ac.id;
                                    
                                    
-- sa se afiseze bugetul pe departamente
select sum(ac.salariu) as buget, d.nume_departament from departamente as d left join angajati as a on a.id_departament=d.id_departament 
	left join angajati_confidential as ac on a.id=ac.id group by d.nume_departament;
    
-- sa se afiseze departamentele din care fac parte barbatii conform cnp
 select distinct d.nume_departament from departamente as d left join angajati as a on d.id_departament=a.id_departament
															left join angajati_confidential as ac on ac.id=a.id
															where left(CNP,1) in (1,5);
-- FEMEI                                  
select distinct d.nume_departament from departamente as d left join angajati as a on d.id_departament=a.id_departament
																					left join angajati_confidential as ac on ac.id=a.id
																						where left(CNP,1) in (2,6);
-- 47. Proiectati o interogare ce va afisa o lista a departamentelor, numele intreg al angajatilor din fiecare departament (intr-o singura coloana) si salariul acestora (cu sufixul RON).
select concat(a.nume," " ,a.prenume) as Nume_angajat,d.nume_departament, concat (ac.salariu," RON") as salariu 
										from angajati as a right join departamente as d on a.id_departament=d.id_departament
														left join angajati_confidential as ac on a.id=ac.id;
-- 48. Proiectati o interogare ce va afisa salariul mediu, minim si maxim din fiecare departament.
select * from departamente;
select * from angajati;
SELECT departamente,AVG(salariu) AS Salariu_Mediu,MIN(salariu) AS Salariu_Minim,MAX(salariu) AS Salariu_Maxim
FROM angajati GROUP BY departament;

-- 49. Proiectati o interogare care va afisa toti angajatii de sex masculin (folosind CNP-ul).
select * from departamente;
select * from angajati;
SELECT d.nume_departament,a.nume, a.prenume
FROM angajati AS a
JOIN departamente AS d ON a.id_departament = d.id_departament
WHERE LEFT(a.cnp, 1) IN ('1', '5');



select round(avg(ac.salariu))as salariu_mediu, min(ac.salariu) as salariu_minim, max(ac.salariu) as salariu_maxim, d.nume_departament 
	from angajati_confidential as ac left join angajati as a on ac.id=a.id
		left join departamente as d on d.id_departament=a.id_departament 
			group by d.nume_departament;


-- 49. Proiectati o interogare care va afisa toti angajatii de sex masculin (folosind CNP-ul).
select * from angajati_confidential;
SELECT a.nume, a.prenume from angajati as a left join angajati_confidential as ac on a.id=ac.id where left(ac.cnp,1) in (1,5);
-- 50. Proiectati o interogare ce va extrage data nasterii din CNP.
select concat(if(left(cnp,1) in (1,2), "19", "20"), mid(ac.cnp,2,2),".", mid(ac.cnp,4,2),".", mid(ac.cnp,6,2)) as data_nasterii from angajati_confidential as ac;
-- 51. Proiectati o interogare care va afisa numele, prenumele si sexul fiecarui angajat.

-- VIEWS
select a.nume, a.prenume, a.data_nasterii, a.data_angajarii, ac.salariu, ac.cnp, d.nume_departament, a.pozitie from
		angajati as a left join departamente as d on a.id_departament=d.id_departament
					  left join angajati_confidential as ac on a.id=ac.id;
                      
                      create or replace view date_ang as  
select a.nume, a.prenume, a.data_nasterii, a.data_angajarii, ac.salariu, ac.cnp, d.nume_departament, a.pozitie from
		angajati as a left join departamente as d on a.id_departament=d.id_departament
					  left join angajati_confidential as ac on a.id=ac.id;
                      
                      select * from date_ang;


select sum(salariu) as buget, nume_departament from date_ang group by  nume_departament;

create or replace view salmaxdep as 
    select max(ac.salariu) as maxim , a.id_departament from angajati as a left join angajati_confidential as ac 
    on a.id=ac.id group by a.id_departament;

-- TRIGGERI
delimiter $$
	drop trigger if exists verificare_cnp $$
    create trigger verificare_cnp before update on angajati_confidential for each row
		begin
			select  length(new.cnp) into @lungime;
            if(@lungime!=13) then 
				signal sqlstate '10001' set message_text="Atentie vezi ca ai introdus gresit CNP-ul";
			end if;
        end;$$
delimiter ;
delimiter $$
	drop trigger if exists verificare_cnp $$
    create trigger verificare_cnp before update on angajati_confidential for each row
		begin
			select  length(new.cnp) into @lungime;
            if(@lungime!=13) then 
				signal sqlstate '10001' set message_text="Atentie vezi ca ai introdus gresit CNP-ul";
			end if;
        end;$$
delimiter ;

delimiter $$
	drop trigger if exists verificare_cnp2 $$
    create trigger verificare_cnp2 before insert on angajati_confidential for each row
		begin
			select  length(new.cnp) into @lungime;
            if(@lungime!=13) then 
				signal sqlstate '10001' set message_text="Atentie vezi ca ai introdus gresit CNP-ul";
			end if;
        end;$$
delimiter ;

                      
                      -- sa se creeze o procedura ce insearaza departamente
delimiter //
	drop procedure if exists insdep//
    create procedure insdep(in pnume varchar(255))
		begin
			insert into departamente values(null, pnume);
            select concat("A fost inserat cu succes departamentul ", pnume);
        end;//
delimiter ;

call insdep("Financiar");

select * from departamente;
                      
													









/*SELECT DISTINCT departament
FROM angajati
WHERE SUBSTR(cnp, 1, 1) IN ('1', '5');*/



/*SELECT 
    CASE 
        WHEN id < 10 THEN '00000'
        WHEN id < 100 THEN '0000' 
        WHEN id < 1000 THEN '000' 
        WHEN id < 10000 THEN '00' 
        WHEN id < 100000 THEN '0' 
    END AS formatted_id
FROM your_table;*/


    
