--********************************************************************
-- Bierverwaltung: Skript zum Erstellen der Datenbank mit allen Tabellen
--********************************************************************

----------------------------------------------------------------------
-- Datenbank erstellen
----------------------------------------------------------------------

use master
go
drop database if exists Bierverwaltung
go
create database Bierverwaltung
go
use Bierverwaltung
go

----------------------------------------------------------------------
-- Tabellen erstellen (alphabetisch, ohne Beziehungen)
----------------------------------------------------------------------

create table Bier (
  BierId integer identity,
  fk_SorteId integer,
  fk_HerstellerId integer,
  fk_RezepturId integer,
  primary key(BierId)
);

create table Hersteller (
  HerstellerId integer identity,
  fk_StandortId integer,
  fk_SorteId integer,
  SwissMade bit,
  Name varchar(50),
  primary key(HerstellerId)
);

create table Rezeptur (
  RezepturId integer identity,
  Preis decimal(9,2),
  Ablaufsdatum date,
  Herstellungsdatum date,
  primary key(RezepturId)
);

create table Sorte (
  SorteId integer identity,
  fk_HerstellerId integer,
  Name varchar(50),
  primary key(SorteId)
);

create table SorteHersteller (
  SorteHerstellerId integer identity,
  fk_SorteId integer,
  fk_HerstellerId integer,
  primary key(SorteHerstellerId)
);

create table Standort (
  StandortId integer identity,
  Strasse varchar(40),
  PLZ varchar(10),
  Ortschaft varchar(40),
  primary key(StandortId)
);
go 

----------------------------------------------------------------------
-- Beziehungen erstellen
----------------------------------------------------------------------
alter table Bier add
  foreign key(fk_SorteId) references Sorte(SorteId),
  foreign key(fk_HerstellerId) references Hersteller(HerstellerId),
  foreign key(fk_RezepturId) references Rezeptur(RezepturId);

alter table Hersteller add
  foreign key(fk_SorteId) references Sorte(SorteId),
  foreign key(fk_StandortId) references Standort(StandortId);

alter table Sorte add
  foreign key(fk_HerstellerId) references Hersteller(HerstellerId);

alter table SorteHersteller add
  foreign key(fk_SorteId) references Sorte(SorteId),
  foreign key(fk_HerstellerId) references Hersteller(HerstellerId);
go
