/* Populate animals table with data. */

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
 VALUES ('Agumon','03/02/2020',0,true,10.23);

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Gabumon','15/11/2018',2,true,8);

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Pikachu','07/01/2021',1,false,15.04);

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Devimon','12/05/2017', 5,true,11);

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Charmander','08/02/2020', 0,false,-11);

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Plantmon','15/11/2022', 2,true,-5.7);

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Squirtle','02/04/1993', 3,false,-12.13);

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Angemon','12/06/2005', 1,true,-45);

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Boarmon','07/06/2005', 7,true,20.4);

INSERT INTO animals (name,date_of_birth,escape_attempts,neutered,weight_kg)
VALUES ('Blossom','13/10/1998', 3,true,17);

/* Populate owners table with data. */
INSERT INTO owners (full_name,age)
VALUES ('Sam Smith',34);

INSERT INTO owners (full_name,age)
VALUES ('Jennifer Orwell',19);

INSERT INTO owners (full_name,age)
VALUES ('Bob',45);

INSERT INTO owners (full_name,age)
VALUES ('Melody Pond',77);

INSERT INTO owners (full_name,age)
VALUES ('Dean Winchester',14);

INSERT INTO owners (full_name,age)
VALUES ('Jodie Whittaker',38);

/* Populate species table with data. */

INSERT INTO species (name)
VALUES ('Pokemon');

INSERT INTO species (name)
VALUES ('Digimon');


-- Updating inserted animals to include species_id 

UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE name NOT LIKE '%mon';


-- Updating inserted animals to include owners_id 
UPDATE animals SET owners_id = 1 WHERE name = 'Agumon';
UPDATE animals SET owners_id = 2 WHERE name = 'Gabumon';
UPDATE animals SET owners_id = 2 WHERE name = 'Pikachu';
UPDATE animals SET owners_id = 3 WHERE name = 'Devimon';
UPDATE animals SET owners_id = 3 WHERE name = 'Plantmon';
UPDATE animals SET owners_id = 4 WHERE name = 'Charmander';
UPDATE animals SET owners_id = 4 WHERE name = 'Squirtle';
UPDATE animals SET owners_id = 4 WHERE name = 'Blossom';
UPDATE animals SET owners_id = 5 WHERE name = 'Angemon';
UPDATE animals SET owners_id = 5 WHERE name = 'Boarmon';

