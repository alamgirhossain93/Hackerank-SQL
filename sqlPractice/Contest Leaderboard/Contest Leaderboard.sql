SELECT g.hacker_id, h.name, SUM(g.high) 
FROM
    (SELECT hacker_id, challenge_id, MAX(score) high
    FROM submissions
    GROUP BY hacker_id, challenge_id) g
        , hackers h
      where g.hacker_id = h.hacker_id
GROUP BY g.hacker_id, h.name
HAVING SUM(g.high) > 0
ORDER BY SUM(g.high)  DESC, g.hacker_id;