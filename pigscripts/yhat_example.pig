
/**
 * hottest_song_of_the_decade: Find the hottest songs from each decade!
 *
 * Required parameters:
 *
 * -param OUTPUT_PATH Output path for script data (e.g. s3n://my-output-bucket/hottest_song_of_the_decade)
 */


%default OUTPUT_PATH 's3n://yhat-mortar/yhat_output.tsv'


-- User-Defined Functions (UDFs)
REGISTER '../udfs/python/yhat_udfs.py' USING streaming_python AS yhat_udfs;

inputs = LOAD 's3n://yhat-mortar/example_input.tsv' 
       USING PigStorage('\t') 
          AS (x:int, y:int, z:int);


calculated_values = FOREACH inputs 
                   GENERATE x, y, z, 
                            yhat_udfs.mean(x, y, z) AS mean;

ordered_values = ORDER calculated_values BY x ASC, y ASC, z ASC;


-- output to S3
rmf $OUTPUT_PATH;
STORE ordered_values 
 INTO '$OUTPUT_PATH' 
USING PigStorage('\t');
