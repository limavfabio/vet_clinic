/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Agumon', DATE '2020-02-03', 0, TRUE, 10.23);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Gabumon', DATE '2018-11-15', 2, TRUE, 8);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Pikachu', DATE '2021-01-07', 1, FALSE, 15.04);
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES ('Devimon', DATE '2017-05-12', 5, TRUE, 11);

-- Second round of insertions

INSERT INTO animals(name, date_of_birth, escape_attempts, neutered, weight_kg)
	VALUES
	( 'Charmander', '2020-02-8', 0, FALSE ,-11 ),
	( 'Plantmon', '2021-11-15', 2, TRUE ,-5.7 ),
	( 'Squirtle', '1993-04-2', 3, FALSE ,-12.13 ),
	( 'Angemon', '2005-06-12', 1, TRUE ,-45 ),
	( 'Boarmon', '2005-06-7', 7, TRUE ,20.4 ),
	( 'Blossom', '1998-10-13', 3, TRUE ,17 ),
	( 'Ditto', '2022-05-14', 4, TRUE ,22 );

	-- owners table data

INSERT INTO owners(full_name, age)
	VALUES
	('Sam Smith' ,34),
	('Jennifer Orwell' ,19),
	('Bob' ,45),
	('Melody Pond' ,77),
	('Dean Winchester' ,14),
	('Jodie Whittaker' ,38);


-- species table data

INSERT INTO species(name)
	VALUES
	('Pokemon'),
	('Digimon');

-- Inclus species_id in animals table

BEGIN;

UPDATE animals
SET species_id = (SELECT id FROM species WHERE name = 'Digimon')
WHERE name like '%mon';

UPDATE animals 
SET species_id = (SELECT id FROM species WHERE name = 'Pokemon')
WHERE species_id IS NULL;

COMMIT;

-- Add owner information to animals table

BEGIN;

/* Sam Smith owns Agumon. */
UPDATE animals
    SET owners_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
    WHERE  name = 'Agumon';

/* Jennifer Orwell owns Gabumon and Pikachu. */
UPDATE animals
    SET owners_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
    WHERE name = 'Gabumon'
		OR name =  'Pikachu';

/* Bob owns Devimon and Plantmon. */
UPDATE animals
    SET owners_id = (SELECT id FROM owners WHERE full_name = 'Bob')
    WHERE name = 'Devimon'
		OR name =  'Plantmon';

/* Melody Pond owns Charmander, Squirtle, and Blossom. */
UPDATE animals
    SET owners_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
    WHERE name = 'Charmander'
		OR name =  'Squirtle'
		OR name =  'Blossom';

/* Dean Winchester owns Angemon and Boarmon. */
UPDATE animals
    SET owners_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
    WHERE name = 'Angemon'
		OR name =  'Boarmon';

COMMIT;
