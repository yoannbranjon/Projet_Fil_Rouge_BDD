-- CREATION DE LA BASE DE DONNEES CINEMA
CREATE DATABASE IF NOT EXISTS CINEMA_DATABASE;

DROP DATABASE IF EXISTS CINEMA_DATABASE;

-- FONCTIONS UTILITAIRES DE SUPPRESSION
DROP TABLE IF EXISTS users
DROP TABLE IF EXISTS status;
DROP TABLE IF EXISTS users_status;
DROP TABLE IF EXISTS sessions;
DROP TABLE IF EXISTS rooms;
DROP TABLE IF EXISTS types;
DROP TABLE IF EXISTS films;
DROP TABLE IF EXISTS types_films;
DROP TABLE IF EXISTS products;

-- CREATION DE LA TABLE USERS
CREATE TABLE IF NOT EXISTS users(
  id int NOT NULL AUTO_INCREMENT,
  mail varchar(255)  NOT NULL,
  password varchar(255)  NOT NULL,
  firstname varchar(255)  NOT NULL,
  lastname varchar(255)  NOT NULL,
  birthday date  NOT NULL,
  address varchar(255),
  PRIMARY KEY (id)
);


-- CREATION DE LA TABLE STATUS
CREATE TABLE IF NOT EXISTS status(
  id TINYINT NOT NULL AUTO_INCREMENT,
  title varchar(255) NOT NULL,
  PRIMARY KEY (id)
 );


-- CREATION DE LA TABLE UTILISATEURS STATUS
CREATE TABLE IF NOT EXISTS users_status(
 status_id TINYINT NOT NULL,
  users_id int NOT NULL,
  PRIMARY KEY (status_id,users_id)
);


-- CREATION DES DEUX CLES ETRANGERES DE USERS_STATUS
ALTER TABLE users_status
ADD CONSTRAINT fk_status_id 
FOREIGN KEY (status_id) REFERENCES status(id);

ALTER TABLE users_status
ADD CONSTRAINT fk_users_id 
FOREIGN KEY (users_id) REFERENCES users(id);


-- CREATION DE LA TABLE ROOM
CREATE TABLE IF NOT EXISTS rooms(
  id tinyint NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL,
  sit_number smallint NOT NULL,
  max_capacity varchar(255) NOT NULL,
  audio_system varchar(255) DEFAULT 'Dolby Surround',
  PRIMARY KEY (id)
);


-- CREATION DE LA TABLE RESERVATIONS
CREATE TABLE IF NOT EXISTS reservations(
reservations_id int NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL,
  price decimal(5,2) NOT NULL,
  sessions_id int NOT NULL,
  users_id int NOT NULL,
  PRIMARY KEY (reservations_id)
 );


-- CREATION DES DEUX CLES ETRANGERES DE LA TABLE RESERVATIONS
ALTER TABLE reservations 
ADD CONSTRAINT fk_sessions_id
FOREIGN KEY (sessions_id) REFERENCES sessions(id);

ALTER TABLE reservations 
ADD CONSTRAINT fk_users_reservations_id
FOREIGN KEY (users_id) REFERENCES users(id);


-- CREATION DE LA TABLE SESSIONS
CREATE TABLE IF NOT EXISTS sessions(
id int NOT NULL AUTO_INCREMENT,
  date_time DATETIME NOT NULL,
  films_id mediumint NOT NULL,
  rooms_id TINYINT NOT NULL,
  PRIMARY KEY (id)
 );

-- CREATION DES DEUX CLES ETRANGERES DE LA TABLE SESSIONS
ALTER TABLE sessions 
ADD CONSTRAINT fk_films_sessions_id
FOREIGN KEY (films_id) REFERENCES films(id);

ALTER TABLE sessions 
ADD CONSTRAINT fk_rooms_sessions_id
FOREIGN KEY (rooms_id) REFERENCES rooms(id);


-- CREATION DE LA TABLE FILMS
CREATE TABLE IF NOT EXISTS films (
id mediumint NOT NULL AUTO_INCREMENT,
  name varchar(255) NOT NULL,
  duration smallint NOT NULL,
  film_version varchar(255) NOT NULL,
  display varchar(255) NOT NULL,
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
