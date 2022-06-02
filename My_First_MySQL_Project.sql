CREATE DATABASE IF NOT EXISTS proiect_final_public_speaking;
-- DROP DATABASE proiect_final_public_speaking;
USE proiect_final_public_speaking;

-- traineri = id(pk), nume, prenume, experienta , review-il vom adauga ulterior cu alter table;

CREATE TABLE IF NOT EXISTS traineri(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nume VARCHAR(50) NOT NULL,
prenume VARCHAR(50) NOT NULL,
experienta ENUM ('Incepator', 'Mediu', 'Avansat', 'Expert')
);

-- cursuri = id(PK), denumire, tip_curs( individual/grupe),  durata-->vom insera ulterior cu alter table
--  pret, id_traineri (FK)- ulterior cu alter table.
CREATE TABLE IF NOT EXISTS cursuri(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
denumire VARCHAR(100) NOT NULL,
tip_curs ENUM ('Individual','Grupe'),
pret FLOAT(5,2)
);


-- sttudenti = id(pk), nume, prenume, email, data_nastere; 
CREATE TABLE IF NOT EXISTS studenti (
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
nume VARCHAR(50) NOT NULL,
prenume VARCHAR(50) NOT NULL,
email VARCHAR(50),
data_nastere DATE NOT NULL
);

-- programari = id(pk) , data_achizitie , nr_persoane , discount, data_inceput, data_sfarsit, id_cursuri(FK) , id_studenti(FK)
CREATE TABLE IF NOT EXISTS programari(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
data_achizitie DATE NOT NULL,
nr_persoane TINYINT NOT NULL,
discount  TINYINT,
data_inceput DATE NOT NULL,
data_sfarsit DATE NOT NULL,
id_cursuri INT NOT NULL,
id_studenti INT NOT NULL,
FOREIGN KEY(id_cursuri) REFERENCES cursuri(id),
FOREIGN KEY(id_studenti) REFERENCES studenti(id)
);

-- plata= id(pk), tip_plata, avans, finalizata(da/nu), termen, id_programari(FK);
CREATE TABLE IF NOT EXISTS plata(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
tip_plata ENUM ('CARD','CASH') NOT NULL,
avans TINYINT,
finalizata BOOLEAN NOT NULL,
termen INT NOT NULL,
id_programari INT NOT NULL,
FOREIGN KEY(id_programari) REFERENCES programari(id)
);


ALTER TABLE programari CHANGE data_achizitie data_achizitie DATE;


ALTER TABLE cursuri ADD COLUMN durata DATE NOT NULL AFTER denumire;
ALTER TABLE cursuri CHANGE durata durata TIME;

ALTER TABLE cursuri ADD COLUMN id_traineri INT NOT NULL;
ALTER TABLE cursuri ADD CONSTRAINT FK_TRAINERI
FOREIGN KEY(id_traineri) REFERENCES traineri(id);


ALTER TABLE traineri ADD COLUMN review TINYINT;
ALTER TABLE traineri CHANGE review rating FLOAT(2,1);

DESCRIBE programari;

ALTER table plata drop foreign key plata_ibfk_1;
ALTER table plata add foreign key(id_programari) references programari(id);

ALTER TABLE programari DROP COLUMN data_sfarsit;

ALTER TABLE plata CHANGE termen termen DATE;

ALTER TABLE cursuri CHANGE tip_curs tip_curs VARCHAR(100);

INSERT INTO traineri (nume, prenume, experienta, rating) VALUES
('Tudor','Andreea','Expert', 4.8),
('Ion','Popecu', 'Incepator', 4),
('Damian','Ionut','Mediu', 3.9),
('Tudor', 'George', 'Avansat', 4.5),
('Udrea', 'Simona','Avansat', 4.4),
('Postelnicu','Maria', 'Mediu', 2.9),
('Petre', 'Alina','Avansat', NULL),
('Popa', 'Damian', 'Expert',4.5),
('Draganescu','Sorina','Incepator',3.8),
('Popovici', 'Valentin', 'Mediu', NULL);


SELECT * FROM traineri;

INSERT INTO cursuri (denumire, tip_curs, pret, durata, id_traineri) VALUES 
('Comunicare Asertiva', 'Grupe', 99.99,'2:00:00', 1 ),
('Motivatie Pentru Succes', 'Grupe', 70,'2:30:00', 3),
('De la Idee la Bani', 'Individual', 149.99,' 3:00:00',1),
('Markenting Online', 'Grupe', 49.99, '1:30:00', 4),
('Gestionarea Emotiilor', null, 80, '1:00:00', 7),
('Engleza Pentru Oricine', 'Individual', 70, '2:50:00', 2),
('Prezentari Atractive', 'Grupe', 90, '2:00:00', 1),
('Eflectul Placebo', 'Individual', 120, '1:30:00', 5),
('Codul Emotiilor', null, 70, '1:20:00', 9),
('Limbajul Corpului','Individual',69.99, '2:50:00', 8);

SELECT * FROM cursuri;

INSERT INTO studenti (nume, prenume, email, data_nastere) VALUES
('Carabelea', 'Radu', 'carabelea.radu@email.com', 19931205),
('Popa', 'Alexandru', 'popa.alexandru@email.com', 19941224),
('Neagoe', 'Sorin', 'neagoe.sorin@email.com', 20000513),
('Parcalab','Daniel','parcalab.danie@email.com', 20040514),
('Pustiu', 'Sorin', 'pustiu.sorin@email.com', 19970618),
('Butnaru', 'Bogdan', 'butnaru.bogdan@emailcom', 19950819),
('Butnaru', 'Simona', 'simona.butnaru@email.com', 19970909),
('Basca', 'Petre', 'basca.petre@email.com', 19920725),
('Oceanu', 'Marius', 'oceanu.marius@email.com', 19951230),
('Tanase', 'Oana', 'tanase.oana@email.com', 20050317);

SELECT * from studenti;

INSERT INTO programari (data_achizitie, nr_persoane, discount, data_inceput, id_cursuri, id_studenti) VALUES
(20220303, 2, 10,'2022-04-15', 1,2),
(20220201, 3, null, 20220516,7,3),
(20220206,1,null, 20220606,8,4),
(20211225,4, 15, 20220505,6,5),
(20220115, 6,null, 20220417,1,4),
(20220202,3, null, 20220608,5,8),
(20220219,2,5,20220507,9,1),
(20220417,2,5,20220507,9,6),
(20220117,1,null, 20220707,3,9),
(20220312,1,null, 20220708,2,7);

SELECT * from programari;

INSERT INTO plata (tip_plata, avans, finalizata, termen, id_programari) VALUES
('cash',NULL, 0, 20220415, 1),
('card', 20,  0, 20220303, 3),
('card',NULL, 1, 20220302, 2),
('card',NULL, 1, 20220505, 4),
('cash',20,   1, 20220403, 5),
('card',30,   0, 20220415, 3),
('cash',NULL, 1, 20220416, 6),
('cash',NULL, 0, 20220419, 7),
('card',NULL, 0, 20220516, 8),
('card',50,   1, 20220517, 9);

SELECT * FROM plata;


-- ----- UPDATE + DELETE -----------
INSERT INTO programari (data_achizitie, nr_persoane, discount, data_inceput, id_cursuri, id_studenti) VALUES
(20220204, 3, 5,'2022-03-12', 1,2);
SELECT * FROM PROGRAMaRI;

UPDATE plata SET termen = CURDATE() WHERE id=2;

SELECT * FROM studenti;

set sql_safe_updates=0;
UPDATE studenti SET nume='Juganaru' WHERE nume= 'Butnaru' and prenume ='simona';
set sql_safe_updates=1;

SELECT * FROM programari;
UPDATE programari SET DISCOUNT= 10 WHERE id=2;

-- stergem cursurile care nu au fost achizitionate niciodata
SELECT * FROM cursuri;
set sql_safe_updates=0;
DELETE FROM cursuri  WHERE id = 4;


-- Stergem cursul care nu are asignat un trainer;
DELETE FROM cursuri WHERE id = 11;

set sql_safe_updates =0;
UPDATE cursuri SET tip_curs = 'Individual SAU Grupe' WHERE tip_curs is NULL ;
set sql_safe_updates =1;

set sql_safe_updates =0;
DELETE FROM studenti WHERE data_nastere>=20050101;
set sql_safe_updates =1;

-- -------- Interogari Variate cu select ------------

-- toate cursurile unde pretul<90 lei si tip_curs = grupe;
SELECT * FROM cursuri WHERE pret < 90 AND tip_curs='Grupe';

-- toate cursurile individuale ordonate dupa pret descrescartor
SELECT * FROM cursuri WHERE tip_curs ='Individual' ORDER BY pret DESC;

-- trainerii cu rating >4
SELECT nume, prenume, rating FROM traineri ORDER BY rating;
SELECT * FROM traineri WHERE rating > 4;

-- cursuri cu emotii in denumire;
SELECT * FROM cursuri WHERE denumire LIKE '%EMOTII%';

-- cel mai scump curs si al 2-lea cel mai scump curs
SELECT * FROM cursuri ORDER BY  pret DESC LIMIT 2;

-- pret total al cursurilot unde id trainer este 1;
SELECT SUM(pret) FROM cursuri WHERE id_traineri =1;





--  ----- SUBINTEROGARI ---- !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!


-- cursurile cu pretul mai mare decat pretul mediu 
SELECT * from cursuri where pret > ( SELECT AVG(pret) FROM cursuri);

-- programarile cu acelasi discount ca cel cu id-ul 7;
SELECT * FROM programari WHERE discount = (SELECT discount FROM programari WHERE id=7);

-- programarile cu aceasi data de inceput ca id-ul 8
SELECT * FROM programari WHERE data_inceput = ( SELECT data_inceput FROM programari WHERE id=8);

-- trainerii pentru cursurile pe grupe
SELECT * FROM cursuri;
SELECT * from traineri WHERE id IN ( SELECT id_traineri FROM cursuri WHERE tip_curs='GRUPE');

-- programarile care au cursuri individuale
SELECT * FROM programari WHERE id_cursuri IN ( SELECT id FROM cursuri WHERE tip_curs='Individual');

-- denumirea cursurilor si tipul de curs prentu programarile cu 2 persoane!!!!!!!!!!!!!!!!!!!!!!!!!!!
SELECT cursuri.denumire, cursuri.tip_curs 
FROM cursuri JOIN programari
ON cursuri.id=programari.id_cursuri
WHERE  programari.nr_persoane = 2;



--  -----------JOIN-uri -----------

-- Cursurile care nu au programari
SELECT cursuri.id, denumire FROM cursuri LEFT JOIN programari
ON cursuri.id=programari.id_cursuri
WHERE programari.id is null;


-- suma cursurilor unui anumit trainer
SELECT SUM(pret) FROM cursuri JOIN traineri ON traineri.id= cursuri.id_traineri 
WHERE traineri.nume = 'TUDOR' AND traineri.prenume='Andreea';


-- data achizitie programare, nr persoane, data_inceput , denumire curs , tip_curs
SELECT data_achizitie, nr_persoane, data_inceput, denumire, tip_curs 
FROM programari JOIN cursuri 
ON programari.id_cursuri=cursuri.id;


-- numele cursului, durata, numele trainerului
SELECT denumire, durata, CONCAT(nume,' ',prenume) traineri
FROM cursuri JOIN traineri
ON cursuri.id_traineri= traineri.id;

-- id programari , data_achizitie , termen limita plata , si daca este finalizata sau nu
ALTER TABLE plata CHANGE termen termen_limita DATE;

SELECT programari.id, data_achizitie, termen_limita, finalizata FROM programari JOIN plata
WHERE programari.id=plata.id_programari;


-- nume student , nume curs, numar persoane , unde nr de persoane mai mare sau egal cu 3
SELECT CONCAT(nume,' ',prenume) studenti , denumire, nr_persoane
FROM studenti JOIN programari ON programari.id_studenti=studenti.id
JOIN cursuri ON programari.id_cursuri=cursuri.id
WHERE nr_persoane >=3;


-- nume student , nume curs, nume trainer, si tip de curs individual;
SELECT CONCAT(studenti.nume,' ', studenti.prenume) student, cursuri.denumire , CONCAT(traineri.nume,' ',traineri.prenume) trainer
FROM studenti,programari, cursuri, traineri
WHERE 
studenti.id=programari.id_studenti AND
cursuri.id=programari.id_cursuri AND
traineri.id=cursuri.id_traineri AND 
tip_curs = 'Individual';


-- nume studenti si cate pachete a achizitionat
SELECT CONCAT(studenti.nume,' ', studenti.prenume) student, COUNT(*) nr_cursuri
FROM studenti, programari
WHERE studenti.id=programari.id_studenti
GROUP BY student
ORDER BY nr_cursuri;

-- numele cursurilor si o lista cu numele studentilor care au achizitionat cursul
SELECT denumire, GROUP_CONCAT(CONCAT(studenti.nume,' ', studenti.prenume)) lista_studenti
FROM cursuri,programari,studenti
WHERE 
studenti.id=programari.id_studenti AND
cursuri.id=programari.id_cursuri
GROUP BY denumire;
 

-- TOTI traineri chiar daca nu au cursuri
SELECT CONCAT(nume, ' ', prenume) traineri, denumire
FROM cursuri RIGHT JOIN traineri
ON cursuri.id_traineri=traineri.id;



ALTER TABLE cursuri CHANGE id_traineri id_traineri INT;
INSERT INTO cursuri (denumire, tip_curs, pret, durata, id_traineri) VALUES
 ('Comunicare Verbala', 'Grupe', 95.99,'2:00:00', NULL );


-- traineti fara cursuri 
SELECT CONCAT(nume, ' ', prenume ) traineri, denumire
FROM cursuri RIGHT JOIN traineri
ON cursuri.id_traineri=traineri.id
WHERE denumire is NULL;

-- cursurile care nu au fost achizitionate niciodata
SELECT denumire FROM cursuri LEFT JOIN programari
ON cursuri.id=programari.id_cursuri
WHERE programari.id is null;




--  --------- Functii de Grup ---------------

-- numarul de plati finalizate sau nefinalizate;
SELECT * FROM PLATA;
SELECT finalizata, COUNT(*) NR_plati FROM plata 
GROUP BY finalizata;

SELECT IF(finalizata =1, 'Plata finalizata', 'Plata nefinalizata') finalizata, COUNT(*) NR_plati
FROM plata
GROUP BY finalizata;

-- numele cursurilor grupate dupa tip_curs
SELECT tip_curs , GROUP_CONCAT(denumire) cursuri
FROM cursuri
GROUP BY tip_curs;

-- numele cursurilor grupate dupa tip_curs
SELECT tip_curs , GROUP_CONCAT(denumire) cursuri
FROM cursuri
GROUP BY tip_curs;

-- numarul cursurlor grupate dupa tip si cu pretul mai mare de 50 lei 
SELECT tip_curs, COUNT(*)
FROM cursuri 
WHERE pret > 50
GROUP BY tip_curs;


-- numarul cursurilor grupate duopa tip dar >=3
SELECT tip_curs, COUNT(*) nr_cursuri
FROM cursuri 
GROUP BY tip_curs 
HAVING nr_cursuri >=3;

-- pretul mediu pentru cursuri, dar daca este peste 70 lei
SELECT tip_curs, AVG(pret) pret_mediu
FROM cursuri 
WHERE tip_curs IN ( 'grupe', 'Individual sau grupe')
GROUP BY tip_curs
Having pret_mediu > 70;



-- ----------Funcţii predefinite MySQL: matematice, de comparare, condiţionale, pentru şiruri de caractere---------------

-- ora curenta
SELECT CURTIME();

-- ora, minutul, secunda puse intr-un tabel
select hour(now()) as ora, minute(now()) as minut, second(now()) as secunda;

-- ora peste 2 ore;
SELECT DATE_ADD(curtime(), INTERVAL 2 HOUR);

-- scadem din data de azi 3 saptamani
SELECT date_sub(curdate(), interval 3 week);

-- cea mai mare valoare dintr-o lista
SELECT GREATEST( 65, 80, 76);

--  functia radical
SELECT sqrt(64);

-- returneaza sirul de la pozitia specificata pana la final
SELECT SUBSTR('proiect finalizat', 8);


-- ----- VIEW-URI------------


-- detalii cursuri care contin cuvantul emotii : tip_ curs , pret, trainer, data_inceput
SELECT * FROM cursuri;
CREATE VIEW detalii_curs_Emotii AS
SELECT tip_curs , pret, CONCAT(traineri.nume,' ',traineri.prenume) nume_trainer, data_inceput 
FROM cursuri , traineri, programari 
WHERE cursuri.id_traineri=traineri.id AND
programari.id_cursuri=cursuri.id
AND cursuri.denumire LIKE '%Emotii%';

SELECT * FROM detalii_curs_Emotii;


-- VIEW cu studentii care vor participa la curs cu : nume_student , data_inceput , nume_curs , nume_trainer
CREATE VIEW detalii_studenti AS
SELECT CONCAT(studenti.nume,' ', studenti.prenume) nume_studenti , cursuri.denumire, programari.data_inceput, CONCAT(traineri.nume,' ',traineri.prenume) nume_trainer
FROM studenti, programari, cursuri, traineri 
WHERE 
studenti.id=programari.id_studenti AND
cursuri.id=programari.id_cursuri AND
traineri.id=cursuri.id_traineri;

SELECT * FROM detalii_studenti;





-- ----- FRUNCTII ---------

SELECT * FROM cursuri;
SELECT * FROM traineri;

-- detalii cursuri : durata , pret , trianerul;
DELIMITER //
CREATE FUNCTION detalii_curs(id INT) RETURNS VARCHAR(200)
BEGIN
DECLARE rezultat VARCHAR(200);

SELECT concat('durata:',durata,' pret:',pret, ' nume trainer: ' ,traineri.nume,' ', traineri.prenume) INTO rezultat
FROM cursuri JOIN traineri 
ON cursuri.id_traineri=traineri.id
WHERE cursuri.id=id;

RETURN rezultat;

END;
//
DELIMITER ;


SELECT detalii_curs(3);




-- detalii plata:  studentii, daca a facut [plata integral afiseaza mesajul : plata finalizata integral cu avans sau fara ,
-- daca nu afiseaza plata nefinalizata cu avans sau fara;

DELIMITER //
CREATE FUNCTION detalii_plata(id_plata INT) RETURNS VARCHAR (500)
BEGIN
DECLARE rezultat VARCHAR(500);
DECLARE nume_student VARCHAR(100);
DECLARE nume_cursuri VARCHAR(100);
DECLARE avans1  TINYINT;
DECLARE finalizata1 TINYINT;

SELECT CONCAT(studenti.nume,' ',studenti.prenume), cursuri.denumire, plata.avans, plata.finalizata INTO nume_student, nume_cursuri, avans1, finalizata1
FROM plata , programari , studenti , cursuri
WHERE 
plata.id_programari=programari.id AND
programari.id_studenti=studenti.id AND
programari.id_cursuri=cursuri.id AND
id_plata=plata.id;


IF finalizata1 = 0  AND avans1 is NULL THEN
	  SET rezultat = CONCAT_WS(' ',nume_student,' Nu a facut plata si nu a dat nici avans pentru:', nume_cursuri);
   ELSE 
   IF finalizata1 = 1  AND avans1 is NULL THEN
	  SET rezultat = CONCAT_WS(' ',nume_student,' A facut plata integral fara avans pentru: ', nume_cursuri);
   ELSE
   IF finalizata1 =0 THEN
	  SET rezultat = CONCAT_WS(' ',nume_student, ' a platit avans:',avans1, ':plata nefinalizata prentu: ', nume_cursuri);
ELSE
   SET rezultat = CONCAT_WS(' ',nume_student, ' a platit avans:',avans1, ':plata Finalizata pentru: ', nume_cursuri);
END IF;
END IF;
END IF;
RETURN rezultat;

END;
//
DELIMITER ;

SELECT detalii_plata(6);



-- Detalii id traineri : nume, prenume , ratingul, denumirea cursului
DELIMITER //
CREATE FUNCTION detalii_traineri ( id INT ) RETURNS VARCHAR(500)
BEGIN
DECLARE rezultat VARCHAR(500);

SELECT CONCAT(traineri.nume,' ',traineri.prenume,', are rating: ', rating ,', are cursul: ', cursuri.denumire) INTO rezultat 
FROM traineri, cursuri
WHERE cursuri.id_traineri=traineri.id
AND traineri.id=id;

return rezultat;

END;

//
DELIMITER ;

SELECT detalii_traineri(2);





-- ----- PROCEDURI -------


-- detalii propgramari : nume student, data incepere , cursul 
 DELIMITER //
 CREATE PROCEDURE detalii_programari ( IN id_programari INT)
 BEGIN
 SELECT CONCAT(studenti.nume, ' ', studenti.prenume) as Nume_Student, data_inceput, cursuri.denumire AS Denumire_Curs
 FROM programari JOIN studenti ON programari.id_studenti=studenti.id
 JOIN cursuri ON programari.id_cursuri=cursuri.id
 WHERE programari.id=id_programari;
 END;
 //
 DELIMITER ;


CALL detalii_programari(2);



--  pretul total pe programare : pret * nr persoane
DELIMITER //
CREATE PROCEDURE pret_total ( IN id_programari INT , OUT pret INT)
BEGIN

SELECT programari.nr_persoane*cursuri.pret INTO pret
FROM programari JOIN cursuri ON programari.id_cursuri=cursuri.id
WHERE programari.id=id_programari;

END;
//
DELIMITER ;


CALL pret_total(2,@pret_total);
SELECT @pret_total;





-- actualizeaza pretul unui curs : daca sunt mai mult de 4 persoane pe programare , creste pretul cu 15 %
DELIMITER //
CREATE PROCEDURE creste_pret ( IN id_programari INT)
BEGIN
DECLARE nr_persoane TINYINT;
DECLARE pret_final FLOAT(5,2);
DECLARE id_cursuri INT;

SELECT programari.nr_persoane, cursuri.pret, programari.id_cursuri INTO nr_persoane , pret_final, id_cursuri
FROM programari JOIN cursuri ON programari.id_cursuri=cursuri.id
WHERE programari.id=id_programari;

IF nr_persoane >=4  THEN
    SET pret_final = pret_final + ( pret_final * 0.15);
END IF;

UPDATE cursuri SET pret = pret_final WHERE id = id_cursuri;

END;
//
DELIMITER ;


CALL creste_pret(5);
SELECT * FROM cursuri;
SELECT * FROM programari;

-- ----- CURSORI -------


-- VOM INSERA IN tabela plata_finalizata toate platile finalizate
CREATE TABLE IF NOT EXISTS plata_finalizata(
id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
id_programari INT NOT NULL,
nume_student VARCHAR(100),
nume_curs VARCHAR(100),
data_inceput DATE NOT NULL,
FOREiGN KEY(id_programari) references programari(id)
);

DELIMITER //
CREATE PROCEDURE populeaza_plata_finalizata()
BEGIN
DECLARE id_programari INT;
DECLARE nume_student VARCHAR(100);
DECLARE nume_curs VARCHAR(100);
DECLARE data_inceput DATE;
DECLARE plata_finalizata1 INT;


DECLARE semafor TINYINT DEFAULT 0;

DECLARE cursor_plata_finalizata CURSOR FOR 
SELECT plata.finalizata, programari.id, CONCAT(studenti.nume,' ',studenti.prenume), cursuri.denumire, programari.data_inceput
FROM plata, programari , studenti, cursuri 
WHERE plata.id_programari=programari.id AND
programari.id_studenti=studenti.id AND
programari.id_cursuri=cursuri.id;

DECLARE CONTINUE HANDLER FOR NOT FOUND 
BEGIN
SET semafor =1;
END;

OPEN cursor_plata_finalizata;
TRUNCATE plata_finalizata;

plata: LOOP
   FETCH cursor_plata_finalizata INTO plata_finalizata1, id_programari, nume_student, nume_curs, data_inceput;
   IF semafor=1 THEN 
      LEAVE plata;
   ELSE
      IF plata_finalizata1 = 1 THEN
      INSERT INTO plata_finalizata VALUES(NULL, id_programari, nume_student, nume_curs, data_inceput);
      END IF;
	END IF;
END LOOP plata;

CLOSE cursor_plata_finalizata;

END;
//
DELIMITER ;


CALL populeaza_plata_finalizata;

SELECT * FROM plata_finalizata;



-- lista cu un anumit curs : trainer : nume_curs, pret, modificam pretul doar daca avem trainer cu experienta Incepator aplicam discount 20 la suta
DELIMITER //
CREATE FUNCTION lista_curs(id INT) RETURNS TEXT
BEGIN
 DECLARE nume_trainer VARCHAR(100);
 DECLARE nume_curs VARCHAR(100);
 DECLARE pret INT;
 DECLARE experienta VARCHAR(50);
 DECLARE rezultat TEXT;
 DECLARE semafor VARCHAR(20) DEFAULT 'verde';

 DECLARE cursor_curs CURSOR FOR 
   SELECT CONCAT(traineri.nume,' ', traineri.prenume), traineri.experienta, cursuri.denumire, cursuri.pret
   FROM cursuri, traineri 
   WHERE cursuri.id_traineri=traineri.id
   AND cursuri.id=id;

 DECLARE CONTINUE HANDLER FOR NOT FOUND SET semafor='rosu';
   OPEN cursor_curs;
    cursuri: LOOP
    FETCH cursor_curs INTO nume_trainer, experienta, nume_curs, pret;
    IF semafor = 'rosu' THEN 
       LEAVE cursuri;
	ELSE 
       IF experienta='Incepator' THEN
          SET pret=pret*0.8;
	   END IF;
       SET rezultat= CONCAT(nume_curs,':',nume_trainer,':', experienta, '->', pret);
	END IF;
    END LOOP cursuri;
    
CLOSE cursor_curs;

RETURN rezultat;

END;
//
DELIMITER ;


SELECT lista_curs(6);


-- gaseste cursuri ieftine 
DELIMITER //
CREATE PROCEDURE cursuri_ieftine(pret_maxim FLOAT, discount_minim TINYINT) 
BEGIN
DECLARE pret FLOAT;
DECLARE nume_curs VARCHAR(100);
DECLARE discount TINYINT;
DECLARE curs_ieftin VARCHAR(100) default ' ';
DECLARE rezultat VARCHAR(500) default ' ';

DECLARE semafor VARCHAR(10) DEFAULT 'Verde';

DECLARE c CURSOR FOR 
 SELECT  cursuri.denumire, cursuri.pret, programari.discount 
 FROM cursuri JOIN programari 
 ON programari.id_cursuri=cursuri.id
 WHERE cursuri.pret <= pret_maxim;
 
 DECLARE CONTINUE HANDLER FOR NOT FOUND SET semafor='rosu';
 OPEN c;
  cursuri: LOOP
     FETCH c INTO nume_curs , pret, discount;
     IF semafor='rosu' THEN
        LEAVE cursuri;
	 ELSE 
      IF discount > discount_minim THEN
        SET curs_ieftin = CONCAT( nume_curs,':' , pret,':', discount);
        SET rezultat= CONCAT ( curs_ieftin, '//', rezultat);
	  END IF;
	END IF;
END LOOP;

CLOSE c;

SELECT rezultat;

END;
//
DELIMITER ;


CALL cursuri_ieftine(200,5);



-- ----- TRIGRERI -----------

CREATE TABLE IF NOT EXISTS log_cursuri(
id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
eveniment VARCHAR(100),
detalii TEXT,
id_curs INT NOT NULL,
foreign key(id_curs) references cursuri(id)
);



DELIMITER //
CREATE TRIGGER log_curs AFTER UPDATE 
ON cursuri FOR EACH ROW
BEGIN
   DECLARE nume_curs_vechi VARCHAR(200);
   DECLARE nume_curs_nou VARCHAR(200);
   DECLARE pret_vechi FLOAT(5,2);
   DECLARE pret_nou FLOAT(5,2);
      
      IF old.denumire != new.denumire THEN
         SELECT old.denumire INTO nume_curs_vechi FROM cursuri WHERE id = old.id;
         SELECT new.denumire INTO nume_curs_nou FROM cursuri WHERE id = new.id; 
         INSERT INTO log_cursuri VALUES(NULL, 'curs schimbat' , CONCAT( nume_curs_vechi,'-->', nume_curs_nou), new.id);
      END IF;
      
	IF old.pret != new.pret THEN 
        SELECT old.pret INTO pret_vechi FROM cursuri WHERE  id = old.id;
		SELECT new.pret INTO pret_nou FROM cursuri WHERE id = new.id; 
	   INSERT INTO log_cursuri VALUES (NULL,'pret schimbat', CONCAT(pret_vechi ,'-->',pret_nou),new.id);
	END IF;
   
    
END;
//
DELIMITER ;





UPDATE cursuri SET denumire='De la idee la bani 6 ' WHERE id=3;
UPDATE cursuri SET pret=45 WHERE id=2;
SELECT * FROM log_cursuri;



-- inainte de insert verificam daca s-au introdus bine datele ( daca discount este mai mare de 15 % setam automat 15 %, daca data incepere< curdate adaugam un interval de 2 saptamani
 DELIMITER //
CREATE TRIGGER before_insert_into_programari BEFORE INSERT ON programari FOR EACH ROW
BEGIN
   IF new.discount >15 THEN
     SET new.discount = 15;
   END IF;
   
   IF new.data_inceput < CURDATE() THEN
      SET new.data_inceput = curdate() + INTERVAL 2 WEEK;
   END IF;
   
   END;
//
DELIMITER ;

INSERT INTO programari VALUES (NULL, curdate(), 2, 25, 08052022, 2,3);




-- cand stergem din traineri setam in cursuri id_traineri = NULL
DELIMITER //
CREATE TRIGGER  sterge_traineri BEFORE DELETE ON traineri FOR EACH ROW
BEGIN
    UPDATE cursuri SET id_traineri = NULL WHERE id_traineri= old.id;
END;
//
DELIMITER ;



DELETE FROM traineri WHERE id = 5;
SELECT * FROM cursuri;





