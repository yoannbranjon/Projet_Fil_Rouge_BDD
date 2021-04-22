-- CREATION DE LA BASE DE DONNEES CINEMA
CREATE DATABASE IF NOT EXISTS CINEMA_DATABASE;

-- FONCTIONS UTILITAIRES DE SUPPRESSION
DROP TABLE IF EXISTS utilisateurs;
DROP TABLE IF EXISTS statuts;
DROP TABLE IF EXISTS utilisateurs_statuts;
DROP TABLE IF EXISTS seances;
DROP TABLE IF EXISTS salles;
DROP TABLE IF EXISTS types;
DROP TABLE IF EXISTS films;
DROP TABLE IF EXISTS types_films;

-- CREATION DE LA TABLE UTILISATEURS
CREATE TABLE IF NOT EXISTS utilisateurs(
  id int NOT NULL AUTO_INCREMENT,
  mail varchar(255)  NOT NULL,
  mdp varchar(255)  NOT NULL,
  nom varchar(255)  NOT NULL,
  prenom varchar(255)  NOT NULL,
  date_de_naissance date  NOT NULL,
  adresse varchar(255),
  PRIMARY KEY (id)
);


-- CREATION DE LA TABLE STATUTS
CREATE TABLE IF NOT EXISTS statuts(
  id TINYINT NOT NULL AUTO_INCREMENT,
  titre varchar(255) NOT NULL,
  PRIMARY KEY (id)
 );


-- CREATION DE LA TABLE UTILISATEURS STATUTS
CREATE TABLE IF NOT EXISTS utilisateurs_statuts(
 statuts_id TINYINT NOT NULL,
  utilisateurs_id int NOT NULL,
  PRIMARY KEY (statuts_id,utilisateurs_id)
);


-- CREATION DES DEUX CLES ETRANGERES DE UTILISATEURS_STATUTS
ALTER TABLE utilisateurs_statuts
ADD CONSTRAINT fk_statuts_id 
FOREIGN KEY (statuts_id) REFERENCES statuts(id);

ALTER TABLE utilisateurs_statuts
ADD CONSTRAINT fk_utilisateurs_id 
FOREIGN KEY (utilisateurs_id) REFERENCES utilisateurs(id);


-- CREATION DE LA TABLE SALLES
CREATE TABLE IF NOT EXISTS salles(
  id tinyint NOT NULL AUTO_INCREMENT,
  nom varchar(255) NOT NULL,
  nbr_siege smallint NOT NULL,
  capacite_max varchar(255) NOT NULL,
  systeme_audio varchar(255) DEFAULT 'Dolby Surround',
  PRIMARY KEY (id)
);


-- CREATION DE LA TABLE RESERVATIONS
CREATE TABLE IF NOT EXISTS reservations(
reservations_id int NOT NULL AUTO_INCREMENT,
  nom varchar(255) NOT NULL,
  tarif decimal(5,2) NOT NULL,
  seances_id int NOT NULL,
  utilisateurs_id int NOT NULL,
  PRIMARY KEY (reservations_id)
 );


-- CREATION DES DEUX CLES ETRANGERES DE LA TABLE RESERVATIONS
ALTER TABLE reservations 
ADD CONSTRAINT fk_seances_id
FOREIGN KEY (seances_id) REFERENCES seances(id);

ALTER TABLE reservations 
ADD CONSTRAINT fk_utilisateurs_reservations_id
FOREIGN KEY (utilisateurs_id) REFERENCES utilisateurs(id);


-- CREATION DE LA TABLE SEANCES
CREATE TABLE IF NOT EXISTS seances(
id int NOT NULL AUTO_INCREMENT,
  date_heure DATETIME NOT NULL,
  films_id mediumint NOT NULL,
  salles_id TINYINT NOT NULL,
  PRIMARY KEY (id)
 );

-- CREATION DES DEUX CLES ETRANGERES DE LA TABLE SEANCES
ALTER TABLE seances 
ADD CONSTRAINT fk_films_seances_id
FOREIGN KEY (films_id) REFERENCES films(id);

ALTER TABLE seances 
ADD CONSTRAINT fk_salles_seances_id
FOREIGN KEY (salles_id) REFERENCES salles(id);


-- CREATION DE LA TABLE FILMS
CREATE TABLE IF NOT EXISTS films (
id mediumint NOT NULL AUTO_INCREMENT,
  nom varchar(255) NOT NULL,
  duree smallint NOT NULL,
  version_film varchar(255) NOT NULL,
  affiche varchar(255) NOT NULL,
  PRIMARY KEY (id)
);


-- CREATION DE LA TABLE TYPES
CREATE TABLE IF NOT EXISTS types(
	id int NOT NULL AUTO_INCREMENT,
	designation varchar(255) NOT NULL,
	pegi TINYINT DEFAULT 0,
	PRIMARY KEY (id)
);

-- CREATION DE LA TABLE TYPES FILMS
CREATE TABLE IF NOT EXISTS types_films(
  types_id int NOT NULL,
  films_id mediumint NOT NULL,
  PRIMARY KEY (types_id,films_id)
 );


-- CREATION DES DEUX CLES ETRANGERES DE LA TABLE TYPES_FILMS
ALTER TABLE types_films 
ADD CONSTRAINT fk_types_films_id
FOREIGN KEY (types_id) REFERENCES types(id);

ALTER TABLE types_films 
ADD CONSTRAINT fk_films_types_id
FOREIGN KEY (films_id) REFERENCES films(id);
