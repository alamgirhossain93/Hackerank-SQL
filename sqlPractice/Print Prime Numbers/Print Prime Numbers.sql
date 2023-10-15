select listagg(t, '&') within group (order by t)  p 
from ( select case 
    when a =1 then null
    when a =2 then 2
    when a =3 then 3
    when 0 not in (select mod(a,level+1) 
                   from dual connect by level <= sqrt(a)) then a
else null end  t 
from (
select level as a from dual
connect by level <=1000
    )
    );