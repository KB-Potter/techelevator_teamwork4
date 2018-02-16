-- Write queries to return the following:
-- Make the following changes in the "world" database.

-- 1. Add Superman's hometown, Smallville, Kansas to the city table. The 
-- countrycode is 'USA', and population of 45001. (Yes, I looked it up on 
-- Wikipedia.)

INSERT INTO city (id, name, district, countrycode, population) 
VALUES (4080, 'Smallville', 'Kansas', 'USA', 45001)

-- 2. Add Kryptonese to the countrylanguage table. Kryptonese is spoken by 0.0001
-- percentage of the 'USA' population.

INSERT INTO countrylanguage (countrycode, isofficial, percentage, language)
VALUES ('USA', false, 0.0001, 'Kryptonese') 

-- 3. After heated debate, "Kryptonese" was renamed to "Krypto-babble", change 
-- the appropriate record accordingly.

UPDATE countrylanguage
SET language = 'Krypto-babble'
WHERE language = 'Kryptonese'

-- 4. Set the US captial to Smallville, Kansas in the country table.

UPDATE country 
SET capital = 4080
WHERE name = 'United States'

-- 5. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)

DELETE FROM city
WHERE name = 'Smallville'

--Doesn't work because the city Smallville is referenced in the capital column in the country table. Violates foreign key constraint and leads to an orphaned value/key

-- 6. Return the US captial to Washington.

UPDATE country
SET capital = 3813
WHERE capital = 4080

-- 7. Delete Smallville, Kansas from the city table. (Did it succeed? Why?)

DELETE FROM city
WHERE name = 'Smallville'

--Worked because the primary key in city id was not referenced by the country's foreign key

-- 8. Reverse the "is the official language" setting for all languages where the
-- country's year of independence is within the range of 1800 and 1972 
-- (exclusive). 
-- (590 rows affected)

UPDATE countrylanguage
SET isofficial = false
        WHERE countrycode IN(SELECT code 
        FROM country 
        WHERE indepyear BETWEEN 1801 AND 1971)

-- 9. Convert population so it is expressed in 1,000s for all cities. (Round to
-- the nearest integer value greater than 0.)
-- (4079 rows affected)

SELECT population from city

START TRANSACTION
UPDATE city
SET population = ROUND(population / 1000, 0) 

COMMIT
ROLLBACK

-- 10. Assuming a country's surfacearea is expressed in miles, convert it to 
-- meters for all countries where French is spoken by more than 20% of the 
-- population.
-- (7 rows affected)
Start transaction

update country
set surfacearea = (surfacearea * 1609.344)
WHERE code IN(Select countrycode from countrylanguage where language = 'French' AND percentage > 20)

Rollback
commit 