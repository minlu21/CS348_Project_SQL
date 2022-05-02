CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getAllShowingMoviesWithAvail`(IN beforeDate DATETIME, IN afterDate DATETIME)
BEGIN
    IF beforeDate IS NULL AND afterDate IS NULL THEN
        SELECT DISTINCT m.movie_id, m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type
			FROM movie m 
			JOIN movie_showing ms ON m.movie_id = ms.movie_id
            GROUP BY m.movie_id, m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type
            HAVING SUM(ms.num_avail_seats) != 0;
    ELSEIF beforeDate IS NOT NULL AND afterDate IS NULL THEN
        SELECT DISTINCT m.movie_id, m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type
			FROM movie m 
			JOIN movie_showing ms ON m.movie_id = ms.movie_id
            WHERE ms.show_datetime < beforeDate
            GROUP BY m.movie_id, m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type
            HAVING SUM(ms.num_avail_seats) != 0;
    ELSEIF beforeDate IS NULL AND afterDate IS NOT NULL THEN
        SELECT DISTINCT m.movie_id, m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type
			FROM movie m 
			JOIN movie_showing ms ON m.movie_id = ms.movie_id
            WHERE ms.show_datetime > afterDate
            GROUP BY m.movie_id, m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type
            HAVING SUM(ms.num_avail_seats) != 0;
    ELSE
        SELECT DISTINCT m.movie_id, m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type
			FROM movie m 
			JOIN movie_showing ms ON m.movie_id = ms.movie_id
            WHERE ms.show_datetime BETWEEN beforeDate AND afterDate
            GROUP BY m.movie_id, m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type
            HAVING SUM(ms.num_avail_seats) != 0;
    END IF;
END