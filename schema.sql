/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
id BIGSERIAL NOT NULL PRIMARY KEY,
name VARCHAR(100) NOT NULL,
date_of_birth DATE,
escape_attempts INTEGER,
neutered BOOLEAN NOT NULL,
weight_kg NUMERIC NOT NULL);