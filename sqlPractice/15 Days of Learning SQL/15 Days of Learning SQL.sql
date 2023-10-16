SELECT   a.submission_date,
           each_day_count,
           a.hacker_id,
           name
    FROM         (SELECT   submission_date,
                           hacker_id,
                           sub_count,
                           ROW_NUMBER ()
                              OVER (PARTITION BY submission_date
                                    ORDER BY sub_count DESC, hacker_id ASC)
                               rnk
                    FROM   (  SELECT   submission_date,
                                       hacker_id,
                                       COUNT (DISTINCT submission_id)
                                          AS sub_count
                                FROM   Submissions
                            GROUP BY   submission_date, hacker_id)) a
              LEFT JOIN
                 Hackers h
              ON a.hacker_id = h.hacker_id
           LEFT JOIN
              (  SELECT   submission_date,
                          COUNT (
                             DISTINCT CASE
                                         WHEN hacker_day_count = day_count
                                         THEN
                                            hacker_id
                                      END
                          )
                             AS each_day_count
                   FROM   (  SELECT   DISTINCT
                                      hacker_id,
                                      submission_date,
                                      DENSE_RANK ()
                                         OVER (PARTITION BY hacker_id
                                               ORDER BY submission_date)
                                          hacker_day_count,
                                      DENSE_RANK () OVER (ORDER BY submission_date)
                                         day_count
                               FROM   submissions
                              WHERE   submission_date >= '2016-03-01'
                           GROUP BY   hacker_id, submission_date)
               GROUP BY   submission_date) t3
           ON a.submission_date = t3.submission_date
   WHERE   rnk = 1
ORDER BY   a.submission_date;
