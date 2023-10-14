select w.id, p.age, w.coins_needed, w.power 
from wands w, wands_property p
where w.code= p.code
and p.is_evil = 0
and w.coins_needed = (select min(coins_needed)
                                from wands a, wands_property b
                                where a.code = b.code
                                and a.power = w.power
                                 and b.age = p.age)
                                 order by w.power desc, p.age desc ;