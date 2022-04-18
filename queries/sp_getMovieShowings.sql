DROP PROCEDURE IF EXISTS sp_getMovieShowings;
DELIMITER //  
CREATE PROCEDURE sp_getMovieShowings(IN movieId BIGINT)
BEGIN

    SELECT ms.room_id, ms.show_datetime 
        FROM movie m
        JOIN movie_showing ms ON m.movie_id = ms.movie_id
        WHERE m.movie_id = movieId;

END //
DELIMITER ;

