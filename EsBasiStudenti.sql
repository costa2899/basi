use studenti;

/*Query 1 Mostrare nome e descrizione di tutti i moduli da 9 CFU*/
SELECT 'Query 1' AS '';
SELECT modulo.nome,modulo.descrizione
FROM modulo
WHERE modulo.CFU > 9;

/*Query 2 Mostrare matricola, nome e cognome dei docenti che hanno più di 60 anni*/
SELECT 'Query 2' AS '';
SELECT docente.matricola,docente.nome,docente.cognome
FROM docente
WHERE docente.eta > 60;

/*Query 3 Mostrare nome, cognome e nome del dipartimento di ogni docente, ordinati dal più giovane al più anziano.
Problema-> stampa solo un rigo*/
SELECT 'Query 3' AS '';
SELECT docente.nome,docente.cognome,docente.dipartimento
FROM docente
ORDER BY docente.eta;

/*Query 4 Mostrare città e indirizzo di ogni sede del dipartimento di codice "INFO"*/
SELECT 'Query 4' AS '';
SELECT sede.citta,sede.indirizzo
FROM sede
WHERE sede.codiceSede="INFO";

/*Query 5 Mostrare nome del dipartimento, città e indirizzo di ogni sede di ogni dipartimento, ordinate alfabeticamente prima per nome dipartimento, poi per nome città e infine per indirizzo.*/
SELECT 'Query 5' AS '';
SELECT dipartimento.nomeDipartimento,dipartimento.citta,dipartimento.indirizzo
FROM dipartimento
ORDER BY dipartimento.nomeDipartimento;

SELECT dipartimento.nomeDipartimento,dipartimento.citta,dipartimento.indirizzo
FROM dipartimento
ORDER BY dipartimento.citta;

SELECT dipartimento.nomeDipartimento,dipartimento.citta,dipartimento.indirizzo
FROM dipartimento
ORDER BY dipartimento.indirizzo;

/*Query 6 Mostrare il nome di ogni dipartimento che ha una sede a Bari.*/
SELECT 'Query 6' AS '';
SELECT dipartimento.nomeDipartimento
FROM dipartimento
WHERE dipartimento.citta="Bari" OR dipartimento.citta="bari";

/*Query 7 Mostrare il nome di ogni dipartimento che non ha sede a Brindisi.*/
SELECT 'Query 7' AS '';
SELECT dipartimento.nomeDipartimento
FROM dipartimento
WHERE dipartimento.citta<>"Brindisi";

/*Query 8 Mostrare media, numero esami sostenuti e totale CFU acquisiti dello studente con matricola 123456.*/
select avg(voto),count(voto),sum(CFU)
from studente as s join esame as e on e.matricolaStudente=s.matricolaStudente
join modulo as m on e.codiceModulo=m.codice
where s.matricolaStudente='123456';

/*Query 9 Mostrare nome, cognome, nome del corso di laurea, media e numero esami sostenuti dello studente con matricola 123456*/

select s.nome,s.cognome,c.descrizione,avg(e.voto),count(e.voto)
from studente as s join corsoLaurea as c on s.corsoLaurea=c.nomeCorsoLaurea
join esame as e on e.matricolaStudente=s.matricolaStudente
where s.matricolaStudente='123456';

/*Query 10 Mostrare codice, nome e voto medio di ogni modulo, ordinati dalla media più alta alla più bassa.*/

select codice, nome, avg(voto) as media
from modulo as m join esame as e on m.codice = e.codiceModulo
group by e.codiceModulo
order by avg(voto) desc;

/*Query 11 Mostrare nome e cognome del docente, nome e descrizione del modulo per ogni docente ed ogni modulo di cui quel docente abbia tenuto almeno un esame; 
il risultato deve includere anche i docenti che non abbiano tenuto alcun esame, in quel caso rappresentati con un'unica tupla in cui nome e descrizione del modulo avranno valore NULL.*/

select d.nome, d.cognome,m.nome, m.descrizione,m.codice
from docente as d join esame as e
join modulo as m   
where e.matricolaDocente = d.matricola and m.codice=e.codiceModulo;

/*Query 12 Mostrare matricola, nome, cognome, data di nascita, media e numero esami sostenuti di ogni studente.----non funziona niente ---*/

select distinct s.matricolaStudente, s.nome, s.cognome, s.dataNascita, avg(e.voto), count(e.voto)
from studente as s join esame as e
group by e.codiceModulo;


/*Query 13 Mostrare matricola, nome, cognome, data di nascita, media e numero esami sostenuti di ogni studente del corso di laurea di codice "ICD" che abbia media maggiore di 27.*/

select distinct s.matricolaStudente, s.nome, s.cognome, s.dataNascita, avg(e.voto), count(e.voto)
from studente as s join esame as e
where s.corsoLaurea='ICD'
group by e.codiceModulo
having avg(e.voto) > 27;

/*Query 14 Mostrare nome, cognome e data di nascita di tutti gli studenti che ancora non hanno superato nessun esame.*/

select *
from studente
where matricolaStudente not in ( select matricolaStudente from esame);

/*Query 15 Mostrare la matricola di tutti gli studenti che hanno superato almeno un esame e che hanno preso sempre voti maggiori di 26.*/

select s.matricolaStudente
from studente as s join esame as e
where e.matricolaStudente = s.matricolaStudente and e.voto >=26 and e.voto >= 18;

/*Query 16 Mostrare, per ogni modulo, il numero degli studenti che hanno preso tra 18 e 21, quelli che hanno preso tra 22 e 26 e quelli che hanno preso tra 27 e 30  (con un'unica interrogazione).*/


select count(s.matricolaStudente)
from studente as s join modulo as m join esame as e 
where e.voto >= 18 and e.voto <= 21 
union 
select count(s.matricolaStudente)
from studente as s join modulo as m join esame as e 
where e.voto >= 22 and e.voto <= 26 
union 
select count(s.matricolaStudente)
from studente as s join modulo as m join esame as e 
where e.voto >= 27 and e.voto <= 30 ; 

/*Query 17 Mostrare matricola, nome, cognome e voto di ogni studente che ha preso un voto maggiore della media nel modulo "BDD"*/

select s.matricolaStudente,s.nome,s.cognome,e.voto
from studente as s join esame as e 
where e.voto  >  any (select avg(e.voto) from modulo as m join esame as e where m.nome='BDD');

/*Query 18 Mostrare matricola, nome, cognome di ogni studente che ha preso ad almeno 3 esami un voto maggiore della media per quel modulo.*/

select s.matricolaStudente,s.nome,s.cognome,e.voto
from studente as s join esame as e 
where e.voto  >  any (select avg(e.voto) from modulo as m join esame as e where count(e.voto) > 3  );