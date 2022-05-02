DROP PROCEDURE IF EXISTS sp_getAllMovies;
DEFINER=`root`@`localhost` 
DELIMITER //
CREATE PROCEDURE `sp_getAllMovies`()
BEGIN
		SELECT DISTINCT movie_id, name, production_date, mpaa_rating, movie_length_in_mins, movie_poster_url, summary, visual_type, total_ticket_earnings, num_tickets_sold
		FROM movie;
END