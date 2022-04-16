USE `theatre`;
DROP procedure IF EXISTS `sp_getAllShowingMovies`;

DELIMITER $$
USE `theatre`$$
CREATE PROCEDURE `sp_getAllShowingMovies` ()
BEGIN
	SELECT DISTINCT m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type
			FROM movie m 
			JOIN movie_showing ms ON m.movie_id = ms.movie_id;
END$$

DELIMITER ;