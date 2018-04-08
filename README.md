1. Please fill other sql files. and package everything else up and upload for testing. 

2. For missing data, please use the delete strategy to handle such issue. For example,

    in `AllstarFull` table, we have a `playerID` as `carperma0` which can't be found in `Master` table. 
    
    So your `AllstarFull.sql` has to contain a 
    
    ```sql
    
        DELETE FROM AllstarFull
        WHERE playerID NOT IN (
          SELECT DISTINCT playerID
          FROM `Master`);
    
    ```
    
    before adding foreign keys. 

3. Test will print pass or fail if the primary keys and foreign keys structure in the student's solution matches the primary keys and foreign keys structure in the canonical solution.

4. Please note that some test could give an `TIMEOUT` error, maybe because your query is too slow, try to optimize it as a faster one(e.g. don't use `not in`)
   or add some indexes on some specific columns such as `playerID`. `AllstarFull.sql` gives an example. 
