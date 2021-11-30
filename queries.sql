/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name like '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN '01/01/2016' AND '01/01/2019';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = true and escape_attempts < 3;

-- List date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'pikachu';

-- List name and escape attempts of animals that weigh more than 10.5kg
SELECT name,escape_attempts FROM animals WHERE weight_kg>10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = true;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.4;

-- Inside a transaction 
BEGIN;
    -- update the animals table by setting the species column to unspecified. 
    UPDATE animals SET species = 'unspecified';
    -- Verify that change was made. Then roll back the change and verify that species columns went back to the state before transaction.
ROLLBACK;

-- Inside a transaction : 
BEGIN;
    -- Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
    UPDATE animals SET species = 'digimon' WHERE name like '%mon';
    -- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
    UPDATE animals SET species = 'pokemon' WHERE species='';
    -- Commit the transaction.
COMMIT;
-- Verify that change was made and persists after commit.


-- Inside a transaction delete all records in the animals table, then roll back the transaction.
BEGIN;
    DELETE FROM animals;
ROLLBACK;
-- After the roll back verify if all records in the animals table still exist

BEGIN;
    DELETE FROM animals WHERE date_of_birth > '01/01/2022';
    SAVEPOINT SP1;
    UPDATE animals SET weight_kg = weight_kg * -1;
    ROLLBACK TO SP1;
    UPDATE animals  SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;





