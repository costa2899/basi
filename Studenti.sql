drop database studenti;
/*----------------Creazione e popolamento database--------------------*/
create database if not exists studenti;
use studenti;

create table if not exists studente(
    matricolaStudente INT PRIMARY KEY,
    corsoLaurea VARCHAR(50) NOT NULL,
    nome VARCHAR(30),
    cognome VARCHAR(30),
    dataNascita DATE,
    codiceFiscale VARCHAR(20) UNIQUE,
    esamiSostenuti int,
    foto BLOB DEFAULT NULL
);

create table if not exists docente(
matricola int primary key,
dipartimento varchar(50),
nome varchar(30),
cognome varchar(30),
eta int,
dataNascita date,
codiceFiscale varchar(20) unique,
foto blob default null
);

create table if not exists modulo(
codice varchar(10) primary key,
nome varchar(30) not null,
descrizione varchar(80),
CFU int not null
);

create table if not exists esame(
matricolaStudente int references studente(matricolaStudente),
codiceModulo varchar(10) references modulo(codice),
matricolaDocente int references docente(matricolaDocente),
dataEsame date,
voto int,
primary key(matricolaStudente,codiceModulo)
);

create table if not exists corsoLaurea(
codiceCorso varchar(10) primary key,
nomeCorsoLaurea varchar(30) unique,
descrizione varchar(80)
);

create table if not exists dipartimento(
codiceDipartimento varchar(10) primary key,
nomeDipartimento varchar(30) unique,
indirizzo varchar(40),
citta varchar(20)
);

create table if not exists sede(
codiceSede varchar(10) primary key,
indirizzo varchar(40),
citta varchar(20)
);

create table if not exists sedeDipartimento(
codiceSede varchar(10) references sede(codiceSede),
codiceDipartimento varchar(10) references dipartimento(codiceDipartimento),
note varchar(80),
primary key(codiceSede,codiceDipartimento)
);





insert into studente(matricolaStudente,corsoLaurea,nome,cognome,dataNascita,codiceFiscale,esamiSostenuti,foto)
		values('123456','ICD','Cosimo','Gennaro', '1999-10-20', 'GNNCSM99R20L049W','12', NULL);
insert into studente(matricolaStudente,corsoLaurea,nome,cognome,dataNascita,codiceFiscale,esamiSostenuti,foto)
		values('66720','ICD','Simone','Marchitelli','1999-06-21','MRCSMN99H21S067L','4','');
        
insert into docente(matricola,dipartimento,nome,cognome,dataNascita,eta,codiceFiscale,foto)
		values('23400','Uniba','Riley','Reyd','1988-03-22','65','RYDRED43G27453A','');
insert into docente(matricola,dipartimento,nome,cognome,dataNascita,codiceFiscale,foto)	
		values('69123','Unisa','Abella','Denger','1975-11-12','24','ABEDEN32T23546U','');
        
insert into modulo(codice,nome,descrizione,CFU)
		values('34420','BDD','Basi di dati','6');
insert into modulo(codice,nome,descrizione,CFU)
		values('57490','LDP','linguaggi di programmazione','12');
        
insert into esame(matricolaStudente,codiceModulo,matricolaDocente,dataEsame,voto)
        values('123456','57490','69123','2020-04-08','27');
insert into esame(matricolaStudente,codiceModulo,matricolaDocente,dataEsame,voto)
        values('66900','34420','23400','2019-08-14','23');
        
insert into corsoLaurea(codiceCorso,nomeCorsoLaurea,descrizione)
        values('48723','PSI','Professioni sanitarie infermieristica');
insert into corsoLaurea(codiceCorso,nomeCorsoLaurea,descrizione)
        values('43590','ICD','Informatica e comuncazione digitale');

insert into dipartimento(codiceDipartimento,nomeDipartimento,indirizzo,citta)
        values('3408','Uniba','via Martiri Otranto','Galatone');
insert into dipartimento(codiceDipartimento,nomeDipartimento,indirizzo,citta)
        values('5532','Unisalerno',"Via Toselli","Torricella");
        
insert into sede(codiceSede,indirizzo,citta)
        values('INFO','via Alcide de Gasperi','Taranto');
insert into sede(codiceSede,indirizzo,citta)
        values('MEC','Via Garibaldi','Salerno');
        
insert into sedeDipartimento(codiceSede,codiceDipartimento,note)
        values('5634','5532','andratuttobene');
insert into sedeDipartimento(codiceSede,codiceDipartimento,note)
        values('7698','3408','restateacasa');

/*----------------Fine primo database--------------------*/