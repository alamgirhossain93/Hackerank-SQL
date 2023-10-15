  SELECT   c.contest_id,
           c.hacker_id,
           c.name,
           SUM (total_submissions),
           SUM (total_accepted_submissions),
           SUM (total_views),
           SUM (total_unique_views)
    FROM               contests c
                    JOIN
                       colleges k
                    ON c.contest_id = k.contest_id
                 JOIN
                    challenges cha
                 ON k.college_id = cha.college_id
              LEFT JOIN
                 (  SELECT   challenge_id,
                             SUM (total_views)  total_views,
                             SUM (total_unique_views)  total_unique_views
                      FROM   view_stats
                  GROUP BY   challenge_id) vs
              ON cha.challenge_id = vs.challenge_id
           LEFT JOIN
              (  SELECT   challenge_id,
                          SUM (total_submissions)  total_submissions,
                          SUM (total_accepted_submissions)
                              total_accepted_submissions
                   FROM   submission_stats
               GROUP BY   challenge_id) ss
           ON cha.challenge_id = ss.challenge_id
GROUP BY   c.contest_id, c.hacker_id, c.name
  HAVING      SUM (total_submissions) != 0
           OR SUM (total_accepted_submissions) != 0
           OR SUM (total_views) != 0
           OR SUM (total_unique_views) != 0
ORDER BY   contest_id;