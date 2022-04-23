CREATE PROCEDURE `sp_getMovieById` (IN movieId BIGINT)
BEGIN
	SELECT name, production_date, mpaa_rating, movie_length_in_mins, movie_poster_url, summary, visual_type, total_ticket_earnings, num_tickets_sold
		FROM movie
        WHERE movie.movie_id = movieId;
END