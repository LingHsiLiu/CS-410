-- Create socialanalyticsblog database in athena
create database socialanalyticsblog;


-- create tweets table in socialanalyticsblog to store tweets
CREATE EXTERNAL TABLE socialanalyticsblog.tweets (
	coordinates STRUCT<
		type: STRING,
		coordinates: ARRAY<
			DOUBLE
		>
	>,
	retweeted BOOLEAN,
	source STRING,
	entities STRUCT<
		hashtags: ARRAY<
			STRUCT<
				text: STRING,
				indices: ARRAY<
					BIGINT
				>
			>
		>,
		urls: ARRAY<
			STRUCT<
				url: STRING,
				expanded_url: STRING,
				display_url: STRING,
				indices: ARRAY<
					BIGINT
				>
			>
		>
	>,
	reply_count BIGINT,
	favorite_count BIGINT,
	geo STRUCT<
		type: STRING,
		coordinates: ARRAY<
			DOUBLE
		>
	>,
	id_str STRING,
	timestamp_ms BIGINT,
	truncated BOOLEAN,
	text STRING,
	retweet_count BIGINT,
	id BIGINT,
	possibly_sensitive BOOLEAN,
	filter_level STRING,
	created_at STRING,
	place STRUCT<
		id: STRING,
		url: STRING,
		place_type: STRING,
		name: STRING,
		full_name: STRING,
		country_code: STRING,
		country: STRING,
		bounding_box: STRUCT<
			type: STRING,
			coordinates: ARRAY<
				ARRAY<
					ARRAY<
						FLOAT
					>
				>
			>
		>
	>,
	favorited BOOLEAN,
	lang STRING,
	in_reply_to_screen_name STRING,
	is_quote_status BOOLEAN,
	in_reply_to_user_id_str STRING,
	user STRUCT<
		id: BIGINT,
		id_str: STRING,
		name: STRING,
		screen_name: STRING,
		location: STRING,
		url: STRING,
		description: STRING,
		translator_type: STRING,
		protected: BOOLEAN,
		verified: BOOLEAN,
		followers_count: BIGINT,
		friends_count: BIGINT,
		listed_count: BIGINT,
		favourites_count: BIGINT,
		statuses_count: BIGINT,
		created_at: STRING,
		utc_offset: BIGINT,
		time_zone: STRING,
		geo_enabled: BOOLEAN,
		lang: STRING,
		contributors_enabled: BOOLEAN,
		is_translator: BOOLEAN,
		profile_background_color: STRING,
		profile_background_image_url: STRING,
		profile_background_image_url_https: STRING,
		profile_background_tile: BOOLEAN,
		profile_link_color: STRING,
		profile_sidebar_border_color: STRING,
		profile_sidebar_fill_color: STRING,
		profile_text_color: STRING,
		profile_use_background_image: BOOLEAN,
		profile_image_url: STRING,
		profile_image_url_https: STRING,
		profile_banner_url: STRING,
		default_profile: BOOLEAN,
		default_profile_image: BOOLEAN
	>,
	quote_count BIGINT
) ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
LOCATION '<TwitterRawLocation>';

-- create the entities table

CREATE EXTERNAL TABLE socialanalyticsblog.tweet_entities (
	tweetid BIGINT,
	entity STRING,
	type STRING,
	score DOUBLE
) ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
LOCATION '<TwitterEntitiesLocation>';


-- create the sentiments table
CREATE EXTERNAL TABLE socialanalyticsblog.tweet_sentiments (
	tweetid BIGINT,
	text STRING,
	originalText STRING,
	sentiment STRING,
	sentimentPosScore DOUBLE,
	sentimentNegScore DOUBLE,
	sentimentNeuScore DOUBLE,
	sentimentMixedScore DOUBLE
) ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
LOCATION '<TwitterSentimentLocation>'

-- select 10 rows for tweet table to analyse tweets
select * from socialanalyticsblog.tweets limit 10;

-- select 10 positive rows from sentiment table
select * from socialanalyticsblog.tweet_sentiments where sentiment = 'POSITIVE' limit 10;

-- select 10 negative rows from sentiment table
select * from socialanalyticsblog.tweet_sentiments where sentiment = 'NEGATIVE' limit 10;

-- select 10 neutral rows from sentiment table
select * from socialanalyticsblog.tweet_sentiments where sentiment = 'NEUTRAL' limit 10;
