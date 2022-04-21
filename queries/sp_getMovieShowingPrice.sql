DROP PROCEDURE IF EXISTS sp_getMovieShowingPrice;
DELIMITER //  
CREATE PROCEDURE sp_getMovieShowingPrice(IN movieId BIGINT, IN roomId INT, IN showDatetime DATETIME, OUT price DOUBLE)
BEGIN

    SELECT ms.price 
        INTO price
        FROM movie_showing ms
        WHERE ms.movie_id = movieId AND ms.room_id = roomId AND ms.show_datetime = showDatetime;

END //
DELIMITER ;