select max(months*salary)||'  '||count(*)
from employee
where  months*salary = (select max(months*salary)
                       from employee);