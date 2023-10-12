SELECT id, NAME, countrycode, district, population
FROM city
where countrycode = 'USA'
AND population > 100000 ;