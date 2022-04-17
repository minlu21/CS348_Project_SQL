CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getAllShowingMovies`(IN beforeDate DATETIME, IN afterDate DATETIME)
BEGIN
    IF beforeDate IS NULL AND afterDate IS NULL THEN
        SELECT DISTINCT m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type
			FROM movie m 
			JOIN movie_showing ms ON m.movie_id = ms.movie_id;
    ELSEIF beforeDate IS NOT NULL AND afterDate IS NULL THEN
        SELECT DISTINCT m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type
			FROM movie m 
			JOIN movie_showing ms ON m.movie_id = ms.movie_id
            WHERE ms.show_datetime < beforeDate;
    ELSEIF beforeDate IS NULL AND afterDate IS NOT NULL THEN
        SELECT DISTINCT m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type
			FROM movie m 
			JOIN movie_showing ms ON m.movie_id = ms.movie_id
            WHERE ms.show_datetime > afterDate;
    ELSE
        SELECT DISTINCT m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type
			FROM movie m 
			JOIN movie_showing ms ON m.movie_id = ms.movie_id
            WHERE ms.show_datetime BETWEEN beforeDate AND afterDate;
    END IF;
END