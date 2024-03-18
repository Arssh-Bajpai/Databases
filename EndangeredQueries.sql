--Query 1 returns all of the sightings and the people involved with the
-- sighting as well as the role they played

SELECT Sighting.sightingID, Sighting.date, Sighting.location, People.first_Name, People.last_Name, People.role
FROM Sighting
JOIN PeopleSighters ON Sighting.sightingID = PeopleSighters.sightingID
JOIN People ON PeopleSighters.peopleID = People.peopleID;


--Query 2 this query gets the information about conservation Efforts including the description, date initiated and the scientists involved
-- as well as the species of animals related to the effort

SELECT ConservationEfforts.description, ConservationEfforts.dateInitiated, ConservationScientists.first_name, ConservationScientists.last_name, Animal.species
FROM ConservationEfforts
JOIN ConservationScientists ON ConservationEfforts.conservationID = ConservationScientists.scientistID
JOIN ConserveEfforts ON ConservationEfforts.conservationID = ConserveEfforts.conservationID
JOIN Animal ON ConserveEfforts.conservationID = Animal.animalID;

-- Query 3: This query helps us find all of the conservation efforts related to the ring dove
-- 
SELECT description, dateInitiated
FROM ConservationEfforts
WHERE conservationID IN (
    SELECT conservationID
    FROM AnimalResearch
    WHERE animalID IN (
        SELECT animalID
        FROM Animal
        WHERE species = 'Ring dove'
    )
);

--Query 4: returns all the species and the population trend for them if its positive
--as in increasing or stable
-- 
SELECT species, populationTrend, COUNT(*) AS trend_count
FROM Animal
GROUP BY species, populationTrend
HAVING populationTrend = 'Increasing' OR populationTrend = 'Stable';


--Query 5: returns sightings that happened in China and involved Veterinarians

SELECT Sighting.sightingID, Sighting.date, Sighting.location
FROM Sighting
JOIN PeopleSighters ON Sighting.sightingID = PeopleSighters.sightingID
JOIN ConservationScientists ON PeopleSighters.peopleID = ConservationScientists.scientistID
WHERE Sighting.location = 'China'
  AND ConservationScientists.expertise = 'biological technician'
GROUP BY Sighting.sightingID, Sighting.date, Sighting.location