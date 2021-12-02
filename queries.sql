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


-- TRANSACTIONS :


-- Inside a transaction :
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






-- Inside a transaction : 
BEGIN;
--  delete all records in the animals table, then roll back the transaction.
    DELETE FROM animals;
ROLLBACK;
-- After the roll back verify if all records in the animals table still exist





-- Inside a transaction :
BEGIN;
-- Delete all animals born after Jan 1st, 2022.
    DELETE FROM animals WHERE date_of_birth > '01/01/2022';
-- Create a savepoint for the transaction.
    SAVEPOINT SP1;
-- Update all animals' weight to be their weight multiplied by -1.
    UPDATE animals SET weight_kg = weight_kg * -1;
-- Rollback to the savepoint
    ROLLBACK TO SP1;
-- Update all animals' weights that are negative to be their weight multiplied by -1.
    UPDATE animals  SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
-- Commit transaction
COMMIT;

-- ANALYTICS:


-- How many animals are there?
 SELECT count(*) FROM animals; -- 9

--  How many animals have never tried to escape?
SELECT count(*) FROM animals WHERE escape_attempts = 0; -- 2

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals; --16.6444444444444444


-- Who escapes the most, neutered or not neutered animals?
SELECT neutered , SUM (escape_attempts) FROM animals GROUP BY neutered ORDER BY SUM (escape_attempts) DESC; 

--  neutered | total escape attempts
-- ----------+----------------------
--      t    |          18
--      f    |           4


-- What is the minimum and maximum weight of each type of animal?
SELECT species , max (weight_kg), min (weight_kg) FROM animals GROUP BY species ; 

--  species     |  max(Kg)    |    min(Kg)
-- -------------+-------------+-------------
--  pokemon     |   17.00Kg   |     11.00Kg
--  digimon     |   45.00Kg   |     8.00Kg


-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?

SELECT species , AVG(escape_attempts) FROM animals WHERE date_of_birth > '01/01/1990' AND date_of_birth < '01/01/2000'  GROUP BY species  ;

--  species |        avg
-- ---------+--------------------
--  pokemon | 3.0000000000000000


-- All animals belonging to 'Melody Pond'
SELECT name FROM animals 
JOIN owners ON animals.owners_id = owners.id 
WHERE full_name = 'Melody Pond';

--     name
-- ------------
--  Blossom
--  Squirtle
--  Charmander

--  all animals that are pokemon (their type is Pokemon).

SELECT animals.name , species.name AS species_type FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

--     name    | species_type
-- ------------+--------------
--  Pikachu    | Pokemon
--  Charmander | Pokemon
--  Squirtle   | Pokemon
--  Blossom    | Pokemon
-- (4 rows)

-- List all owners and their animals, remember to include those that don't own any animal.

SELECT animals.name AS animal_name, owners.full_name AS owner_name FROM owners
LEFT JOIN animals ON owners.id = animals.owners_id;

--  animal_name |   owner_name
-- -------------+-----------------
--  Agumon      | Sam Smith
--  Pikachu     | Jennifer Orwell
--  Gabumon     | Jennifer Orwell
--  Devimon     | Bob
--  Blossom     | Melody Pond
--  Squirtle    | Melody Pond
--  Charmander  | Melody Pond
--  Boarmon     | Dean Winchester
--  Angemon     | Dean Winchester
--              | Jodie Whittaker
-- (10 rows)

-- How many animals are there per species?

SELECT species.name as species_type , COUNT(*) from animals
JOIN species ON species.id = animals.species_id
GROUP BY species_type;

--  species_type | count
-- --------------+-------
--  Pokemon      |     4
--  Digimon      |     5
-- (2 rows)

-- List all Digimon owned by Jennifer Orwell.

SELECT owners.full_name AS owners_name,
        animals.name AS animal_name,
        species.name AS type
FROM animals
JOIN species ON species.id = animals.species_id
JOIN owners ON owners.id = animals.owners_id
WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';

--    owners_name   | animal_name |  type
-- -----------------+-------------+---------
--  Jennifer Orwell | Gabumon     | Digimon
-- (1 row)

-- List all animals owned by Dean Winchester that haven't tried to escape.

SELECT animals.name AS animal_name FROM animals
JOIN owners ON owners.id = animals.owners_id
WHERE animals.escape_attempts = 0 AND owners.full_name = 'Dean Winchester';

--  animal_name
-- -------------
-- (0 rows)

-- Who owns the most animals?

SELECT owners.full_name as owners_name , COUNT(animals.name) as animal_count from owners
LEFT JOIN animals ON owners.id = animals.owners_id
GROUP BY owners_name
 ORDER BY animal_count DESC;

--     owners_name   | animal_count
-- -----------------+--------------
--  Melody Pond     |            3
--  Dean Winchester |            2
--  Jennifer Orwell |            2
--  Bob             |            1
--  Sam Smith       |            1
--  Jodie Whittaker |            0
-- (6 rows)





