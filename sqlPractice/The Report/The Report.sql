SELECT CASE when (select grade 
                 from grades
                 where marks between min_mark and max_mark) > 7 
                 then name else null end name,
                (select grade
                          from grades
                          where marks between min_mark and max_mark) grade ,
                          marks mark
            from students
            ORDER by grade desc, name, mark ;
