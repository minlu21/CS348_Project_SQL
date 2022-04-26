DROP PROCEDURE IF EXISTS sp_filterShowingMoviesByDateAndTitle;
DELIMITER //  
CREATE PROCEDURE sp_filterShowingMoviesByDateAndTitleTicket(IN date1 VARCHAR(5), IN date2 VARCHAR(5), IN title VARCHAR(255))
BEGIN

    DECLARE curr_year VARCHAR(10);
    DECLARE start_range DATETIME;
    DECLARE end_range DATETIME;

    SELECT YEAR(NOW()) INTO curr_year;
    
    IF date1 IS NOT NULL THEN
        SELECT CONCAT(curr_year, "-", date1, "-", "01 00:00:00") INTO start_range;
    END IF;
    
    IF date2 IS NOT NULL THEN
        SELECT CONCAT(LAST_DAY(CONCAT(2022, "-", date2, "-01")), " 23:59:59") INTO end_range;
    END IF;

    IF title IS NOT NULL THEN

        IF date1 IS NOT NULL AND date2 IS NOT NULL THEN
            SELECT m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type, ms.show_datetime
                FROM movie m 
                JOIN movie_showing ms ON m.movie_id = ms.movie_id
                WHERE ms.show_datetime BETWEEN start_range AND end_range
                    AND m.name LIKE CONCAT("%",title,"%");

        ELSEIF date1 IS NOT NULL THEN
            SELECT m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type, ms.show_datetime
                FROM movie m 
                JOIN movie_showing ms ON m.movie_id = ms.movie_id
                WHERE ms.show_datetime >= start_range
                    AND m.name LIKE CONCAT("%",title,"%");

        ELSEIF date2 IS NOT NULL THEN
            SELECT m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type, ms.show_datetime
                FROM movie m 
                JOIN movie_showing ms ON m.movie_id = ms.movie_id
                WHERE ms.show_datetime <= end_range
                    AND m.name LIKE CONCAT("%",title,"%");

        ELSE
            SELECT m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type, ms.show_datetime
                FROM movie m 
                JOIN movie_showing ms ON m.movie_id = ms.movie_id
                WHERE m.name LIKE CONCAT("%",title,"%");
        
        END IF;

    ELSE

        IF date1 IS NOT NULL AND date2 IS NOT NULL THEN
            SELECT m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type, ms.show_datetime
                FROM movie m 
                JOIN movie_showing ms ON m.movie_id = ms.movie_id
                WHERE ms.show_datetime BETWEEN start_range AND end_range;
        ELSEIF date1 IS NOT NULL THEN
            SELECT m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type, ms.show_datetime
                FROM movie m 
                JOIN movie_showing ms ON m.movie_id = ms.movie_id
                WHERE ms.show_datetime >= start_range;

        ELSEIF date2 IS NOT NULL THEN
            SELECT m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type, ms.show_datetime
                FROM movie m 
                JOIN movie_showing ms ON m.movie_id = ms.movie_id
                WHERE ms.show_datetime <= end_range;

        ELSE
            SELECT m.name, m.production_date, m.mpaa_rating, m.movie_length_in_mins, m.movie_poster_url, m.summary, m.visual_type, ms.show_datetime
                FROM movie m 
                JOIN movie_showing ms ON m.movie_id = ms.movie_id;
        
        END IF;

    END IF;
    
END //
DELIMITER ;
