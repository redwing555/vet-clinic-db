/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;


CREATE TABLE animals (
    id int NOT NULL GENERATED ALWAYS AS IDENTITY,
    name varchar(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL DEFAULT false,
    weight_kg decimal(5,2) NOT NULL
);
-- adding species column of type string 
ALTER TABLE animals ADD species VARCHAR(100);

-- creating owners table
CREATE TABLE owners (
    id  SERIAL PRIMARY KEY,
    full_name varchar(100) NOT NULL,
    age INT NOT NULL
);
-- creating species table
CREATE TABLE species (
    id  SERIAL PRIMARY KEY,
    name varchar(100) NOT NULL
);

-- id is set as autoincremented PRIMARY KEY and dropping species column
ALTER TABLE animals DROP COLUMN id;
ALTER TABLE animals ADD COLUMN id SERIAL  PRIMARY KEY;
ALTER TABLE animals DROP COLUMN species;


-- adding species foreign key to animals table
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species(id);

-- adding owners foreign key to animals table
ALTER TABLE animals ADD COLUMN owners_id INT;
ALTER TABLE animals ADD FOREIGN KEY (owners_id) REFERENCES owners(id);
ALTER TABLE animals ADD CONSTRAINT fk_owners_id FOREIGN KEY (owners_id) REFERENCES owners(id);

-- create table vets

CREATE TABLE vets (
    id serial NOT NULL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT NOT NULL,
    date_of_graduation DATE NOT NULL
    
);

-- table specializations to handle many-to-many relation between species and vets

CREATE TABLE specializations (
    vet_id INT ,
    species_id INT,
    CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id),
    CONSTRAINT fk_vets FOREIGN KEY(vet_id) REFERENCES vets(id)

);

-- table visits to handle many-to-many relation between animals and vets

CREATE TABLE visits (
   animal_id INT ,
    vet_id INT,
    date_of_visit DATE,
    CONSTRAINT fk_animals FOREIGN KEY(animal_id) REFERENCES animals(id),
    CONSTRAINT fk_vets FOREIGN KEY(vet_id) REFERENCES vets(id)

);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

ALTER TABLE owners ALTER COLUMN age DROP NOT NULL;

CREATE INDEX animal_id on visits (animal_id ASC);
CREATE INDEX vet_id_asc on visits (vet_id ASC);
CREATE INDEX email_id on owners(email ASC); 
