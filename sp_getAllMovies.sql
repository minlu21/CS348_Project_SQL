CREATE PROCEDURE `sp_getAllMovies`()
BEGIN
	SELECT DISTINCT name, production_date, mpaa_rating, movie_length_in_mins, movie_poster_url, summary, visual_type
		FROM movie;
END