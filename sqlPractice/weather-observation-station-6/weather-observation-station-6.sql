select distinct(city) 
from station 
where UPPER(SUBSTR(CITY,1,1)) IN ('A','E','I','O','U');