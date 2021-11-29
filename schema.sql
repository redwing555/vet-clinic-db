/* Database schema to keep the structure of entire database. */

CREATE DATABASE vet_clinic;

\c vet_clinic;

CREATE TABLE animals (
    id int NOT NULL GENERATED ALWAYS AS IDENTITY,
    name varchar(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    escape_attempts INT NOT NULL,
    neutered BOOLEAN NOT NULL DEFAULT false,
    weight_kg decimal(5,2) NOT NULL
);
