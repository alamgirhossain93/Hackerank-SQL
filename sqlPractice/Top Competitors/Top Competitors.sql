select h.hacker_id, h.name
from hackers h, submissions s, challenges c, difficulty d
where h.hacker_id = s.hacker_id
and s.score = d.score
and d.difficulty_level = c.difficulty_level
and s.challenge_id = c.challenge_id
group by  h.hacker_id, h.name
having count(*) > 1
order by count(*) desc, h.hacker_id ;