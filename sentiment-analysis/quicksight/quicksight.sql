-- Import data from athena to quicksight

SELECT  s.*,
        e.entity,
        e.type,
        e.score,
         t.lang as language,
         coordinates.coordinates[1] AS lon,
         coordinates.coordinates[2] AS lat ,
         place.name,
         place.country,
         t.timestamp_ms / 1000 AS timestamp_in_seconds,
         regexp_replace(source,
         '\<.+?\>', '') AS src
FROM socialanalyticsblog.tweets t
JOIN socialanalyticsblog.tweet_sentiments s
    ON (s.tweetid = t.id)
JOIN socialanalyticsblog.tweet_entities e
    ON (e.tweetid = t.id)
