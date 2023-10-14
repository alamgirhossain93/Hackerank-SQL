SELECT Name || '(' || SUBSTR(Occupation, 1, 1) || ')' Result 
FROM OCCUPATIONS 
ORDER BY Name;

SELECT 'There are a total of ' || COUNT(Occupation) || ' ' || LOWER(Occupation) || 's.'  Result 
FROM OCCUPATIONS 
GROUP BY Occupation 
ORDER BY COUNT(Occupation), LOWER(Occupation);