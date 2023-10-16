select hacker_id,name,challenges_created 
    from (select h.hacker_id, h.name, count(c.challenge_id)  challenges_created ,
    count(*) over (partition by count(c.challenge_id))  total ,DENSE_RANK () OVER ( ORDER BY count(c.challenge_id) DESC
    ) rank  
    from hackers  h
    inner join challenges  c 
    on h.hacker_id=c.hacker_id
   group by h.name, h.hacker_id)A
   where total < 2 or rank = 1
  order by challenges_created desc,hacker_id ;