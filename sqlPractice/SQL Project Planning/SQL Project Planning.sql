select ed_dt - lvl, ed_dt
from ( 
select distinct max(level) as lvl,  
    start_date as st_dt, end_date as ed_dt, 
    LEAD(max(level)) OVER (order by start_date) next_lvl
from projects
connect by prior end_date = start_date
group by start_date, end_date
order by start_date
) a
where a.lvl != a.next_lvl -1 or a.next_lvl is null
order by lvl, ed_dt-lvl;