CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getFilteredMovies`(IN year1 VARCHAR(5), IN title VARCHAR(255))
BEGIN
    DECLARE start_range DATETIME;
    DECLARE end_range DATETIME;
    
    IF year1 IS NOT NULL THEN
        SELECT CONCAT(year1, "-", "01", "-", "01 00:00:00") INTO start_range;
		SELECT CONCAT(year1, "-", "12", "-", "31 23:59:59") INTO end_range;
    END IF;

    IF title IS NOT NULL THEN

        IF year1 IS NOT NULL THEN
            SELECT m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type
                FROM movie m
                WHERE m.production_Date BETWEEN start_range AND end_range
                    AND m.name LIKE CONCAT("%",title,"%");

        ELSE
            SELECT m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type
                FROM movie m 
                WHERE m.name LIKE CONCAT("%",title,"%");
        
        END IF;

    ELSE

        IF year1 IS NOT NULL THEN
            SELECT m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type
                FROM movie m 
                WHERE m.production_date BETWEEN start_range AND end_range;

        ELSE
            SELECT m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type
                FROM movie m;
        
        END IF;

    END IF;
END