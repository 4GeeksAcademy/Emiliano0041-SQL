-- queries.sql
-- Complete each mission by writing your SQL query below the instructions.
-- Don't forget to end each query with a semicolon ;

SELECT * FROM regions;
SELECT * FROM species;
SELECT * FROM climate;
SELECT * FROM observations;


-- MISSION 1
-- Your query here;
--**Misión 1:** Queremos conocer la biodiversidad de cada región. ¿Qué regiones tienen más especies registradas?;
SELECT 
    regions.name,
    regions.country,
    COUNT(DISTINCT species.id) AS total_species
FROM observations
JOIN species ON observations.species_id = species.id
JOIN regions ON observations.region_id = regions.id
GROUP BY regions.name
ORDER BY total_species DESC;



-- MISSION 2
-- Your query here:
--¿Qué meses tienen mayor actividad de observación? Agrupa por mes a partir de las fechas de observación reales. Es útil para detectar estacionalidad;
SELECT 
    strftime('%m', observations.observation_date) AS month,
    COUNT(*) AS total
FROM observations
GROUP BY month
ORDER BY total DESC;


-- MISSION 3
-- Your query here
--Detecta las especies con pocos individuos registrados (posibles casos raros);
SELECT species.scientific_name, species.common_name, SUM(observations.count) AS total_count
FROM species
JOIN observations ON species.id = observations.species_id
GROUP BY scientific_name
HAVING total_count < 3;






-- MISSION 4 ¿Qué región tiene el mayor número de especies distintas observadas?;

SELECT 
    regions.name,
    regions.country,
    COUNT(DISTINCT species.id) AS total_species
FROM observations
JOIN species ON observations.species_id = species.id
JOIN regions ON observations.region_id = regions.id
GROUP BY regions.name
ORDER BY total_species DESC
LIMIT 1;
 


-- MISSION 5 ¿Qué especies han sido observadas con mayor frecuencia?
-- Your query here:;
SELECT  species.id, species.scientific_name, species.common_name, COUNT(*) AS species_frecuencia
FROM observations
JOIN species ON observations.species_id = species.id
GROUP BY species.id
ORDER BY species_frecuencia DESC
LIMIT 10

;





-- MISSION 6 Queremos identificar a los observadores más activos. ¿Quiénes son las personas que más registros de observación han realizado?
-- Your query here:;
SELECT observations.observer, COUNT(*) AS total_observations
FROM observations
GROUP BY observations.observer
ORDER BY total_observations DESC
LIMIT 5;

-- MISSION 7 ¿Qué especies no han sido observadas nunca? Comprueba si existen especies en la tabla species que no aparecen en observations
-- Your query here;
SELECT scientific_name, common_name
FROM species
LEFT JOIN observations ON observations.species_id = species.id
WHERE observations.species_id IS NULL
;


-- MISSION 8 ¿En qué fechas se observaron más especies distintas? Esta informacion es ideal para explorar la biodiversidad máxima en días específicos.
-- Your query here;

SELECT observations.observation_date, COUNT(DISTINCT observations.species_id) AS distinct_species
FROM observations
GROUP BY observations.observation_date
ORDER BY distinct_species DESC
LIMIT 5




;
