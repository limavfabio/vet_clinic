/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
id BIGSERIAL NOT NULL PRIMARY KEY,
name VARCHAR(100) NOT NULL,
date_of_birth DATE,
escape_attempts INTEGER,
neutered BOOLEAN NOT NULL,
weight_kg NUMERIC NOT NULL);

-- Add a column species of type string to your animals table.

ALTER TABLE animals 
ADD COLUMN species VARCHAR(100);

--  Create owners Table

CREATE TABLE owners(
id BIGSERIAL NOT NULL,
full_name VARCHAR(100) NOT NULL,
age INT NOT NULL,
PRIMARY KEY (id),
CONSTRAINT age_positive CHECK (age > 0) NOT VALID);

--  CREATE TABLE species

CREATE TABLE species(
id BIGSERIAL PRIMARY KEY NOT NULL,
name VARCHAR(100));

-- Alter animals table to reference owners and species tables through a foreign key

BEGIN;

ALTER TABLE animals 
DROP COLUMN species;

ALTER TABLE animals 
ADD COLUMN species_id BIGINT,
ADD CONSTRAINT fk_animals_species
FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals 
ADD COLUMN owners_id BIGINT,
ADD CONSTRAINT fk_animals_owners
FOREIGN KEY (owners_id) REFERENCES owners(id);

COMMIT;
