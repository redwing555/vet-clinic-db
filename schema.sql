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

CREATE TABLE owners (
    id  SERIAL PRIMARY KEY,
    full_name varchar(100) NOT NULL,
    age INT NOT NULL
);

CREATE TABLE species (
    id  SERIAL PRIMARY KEY,
    name varchar(100) NOT NULL
);

ALTER TABLE animals DROP COLUMN id;
ALTER TABLE animals ADD COLUMN id SERIAL  PRIMARY KEY;
ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD CONSTRAINT fk_species_id FOREIGN KEY (species_id) REFERENCES species(id);


ALTER TABLE animals ADD COLUMN owners_id INT;
ALTER TABLE animals ADD FOREIGN KEY (owners_id) REFERENCES owners(id);
ALTER TABLE animals ADD CONSTRAINT fk_owners_id FOREIGN KEY (owners_id) REFERENCES owners(id);
