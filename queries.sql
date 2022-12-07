/*Queries that provide answers to the questions FROM all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name <> 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/* Inside a transaction update the animals table by setting the species column to unspecified. Verify that change was made. Then roll back the change and verify that the species columns went back to the state before the transaction. */
BEGIN;

UPDATE animals
	SET species = 'unspecified';
  SELECT name, species FROM animals;

ROLLBACK;
  SELECT name, species FROM animals;

/* Update the animals table by setting the species column to digimon for all animals that have a name ending in mon. */
BEGIN;

UPDATE animals
	SET species = 'digimon'
WHERE name LIKE '%mon';

SELECT * FROM animals;

/* Update the animals table by setting the species column to pokemon for all animals that don't have species already set. */

UPDATE animals
	SET species = 'pokemon'
WHERE species IS NULL;

SELECT * FROM animals;

/*  Commit the transaction. */
COMMIT;

SELECT name, species FROM animals;

/* Inside a transaction delete all records in the `animals` table, then roll back the transaction. */

BEGIN;

DELETE FROM animals;

SELECT * FROM animals;

/* After the rollback verify if all records in the `animals` table still exists.*/

ROLLBACK;

SELECT * FROM animals;

/*  Delete all animals born after Jan 1st, 2022. */

BEGIN;

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SELECT * FROM animals;

/* Create a savepoint for the transaction. */

SAVEPOINT  SP1;

/* Update all animals' weight to be their weight multiplied by -1. */

UPDATE animals
	SET weight_kg = weight_kg * (-1);

SELECT * FROM animals;

/* Rollback to the savepoint */

ROLLBACK TO SAVEPOINT SP1;


/* Update all animals' weights that are negative to be their weight multiplied by -1. */

UPDATE animals
	SET weight_kg = weight_kg * (-1)
WHERE weight_kg < 0;

SELECT * FROM animals;

/*  Commit transaction */

COMMIT;

/* Second part of queries */

/* How many animals are there? */

SELECT COUNT(*) AS animals
FROM animals;

/* How many animals have never tried to escape? */

SELECT COUNT(*) AS animals_never_escape
FROM animals
WHERE escape_attempts = 0;

/* What is the average weight of animals */

SELECT AVG(weight_kg) AS average_weight_kg
FROM animals;

/* Who escapes the most, neutered or not neutered animals? */

SELECT MAX(escape_attempts) FROM animals GROUP BY neutered;

/* What is the minimum and maximum weight of each type of animal? */
SELECT species,
	MIN(weight_kg),
	MAX(weight_kg)
FROM animals
GROUP BY species;

/*  What is the average number of escape attempts per animal type
of those born between 1990 and 2000? */
SELECT species,
	AVG(escape_attempts) AVG_escape_attempts
FROM animals
 WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

/* What animals belong to Melody Pond? */

SELECT animals.name as animal, owners.full_name as owner
FROM animals JOIN owners
ON owners.id = animals.owners_id
WHERE owners.full_name = 'Melody Pond';

/* List of all animals that are pokemon (their type is Pokemon). */

SELECT animals.name AS animal, species.name AS specie
FROM animals JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

/* List all owners and their animals, remember to include those that don't own any animal. */

SELECT owners.full_name AS owner,
animals.name AS animal
FROM owners LEFT JOIN animals ON owners.id = animals.owners_id;

/* How many animals are there per species? */

SELECT COUNT(*) species_count,
species.name as species
FROM animals RIGHT JOIN species ON species.id = animals.species_id
GROUP BY species;

/* List all Digimon owned by Jennifer Orwell. */

SELECT animals.name AS animal,
species.name AS specie,
owners.full_name AS owner
FROM animals JOIN owners ON owners.id = animals.owners_id
JOIN species ON species.id = animals.species_id
WHERE owners.full_name = 'Jennifer Orwell'
AND species.name = 'Digimon';

/* List all animals owned by Dean Winchester that haven't tried to escape. */

SELECT animals.name as animal,
owners.full_name as owner,
species.name as species
FROM animals JOIN owners ON owners.id = animals.owners_id
JOIN species ON species.id = animals.species_id
WHERE owners.full_name = 'Dean Winchester'
AND animals.escape_attempts = 0;


/* Who owns the most animals? */

SELECT owners.full_name,
COUNT(*)
FROM owners JOIN animals ON owners.id = animals.owners_id
GROUP BY owners.full_name
ORDER BY count DESC LIMIT 1;
