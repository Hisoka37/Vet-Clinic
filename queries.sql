/*Queries that provide answers to the questions from all projects.*/

-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon';

-- List the name of all animals born between 2016 and 2019.
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

-- List the name of all animals that are neutered and have less than 3 escape attempts.
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

-- List the date of birth of all animals named either "Agumon" or "Pikachu".
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

-- List name and escape attempts of animals that weigh more than 10.5kg.
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

-- Find all animals that are neutered.
SELECT * FROM animals WHERE neutered = true;

-- Find all animals not named Gabumon.
SELECT * FROM animals WHERE name != 'Gabumon';

-- Find all animals with a weight between 10.4kg and 17.3kg 
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


____________________________________________________________________________________________

BEGIN;
UPDATE animals
SET species = 'unspecified';

SELECT * from animals;

ROLLBACK;

SELECT * from animals;

BEGIN;
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;

SELECT * from animals;

COMMIT;
SELECT * from animals;

BEGIN;
DELETE FROM animals;

SELECT * from animals;

ROLLBACK;

SELECT * from animals;

BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-1-1';

SAVEPOINT m-_savepoint;

UPDATE animals
SET weight_kg = weight_kg * -1;

SELECT * from animals;

ROLLBACK TO my_savepoint;

SELECT * from animals;

UPDATE animals
SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;

SELECT * from animals;

COMMIT;

SELECT * from animals;
 

___________________________________________________________________________________


SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;

SELECT AVG(weight_kg) FROM animals;

SELECT neutered, SUM(escape_attempts) FROM animals GROUP BY neutered;

SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-1-1' AND '2000-12-31' GROUP BY species;

___________________________________________________________________________________


SELECT animals.name, owners.full_name 
FROM animals 
JOIN owners 
ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Melody';

SELECT animals.name AS animal_name, species.name AS species_type 
FROM animals 
JOIN species 
ON animals.species_id = species.id 
WHERE species.name = 'Pokemon';

SELECT owners.full_name, animals.name 
FROM owners 
LEFT JOIN animals 
ON animals.owner_id = owners.id;

SELECT species.name, count(animals) 
FROM animals 
JOIN species 
ON animals.species_id = species.id 
GROUP BY species.name;

SELECT animals.name 
FROM animals 
JOIN owners 
ON animals.owner_id = owners.id 
WHERE owners.full_name = 'Jennifer Orwell';

SELECT animals.name FROM animals
JOIN owners ON animals.owner_id = owners.id WHERE escape_attempts = 0 AND owners.full_name = 'Dean Winchester';


SELECT owners.full_name, COUNT(animals.name) AS total_animals 
FROM owners 
JOIN animals 
ON animals.owner_id = owners.id 
GROUP BY owners.full_name 
ORDER BY total_animals DESC 
LIMIT 1;