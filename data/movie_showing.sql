DROP PROCEDURE IF EXISTS sp_insertRowsIntoMovieShowing;
DELIMITER //  
CREATE PROCEDURE sp_insertRowsIntoMovieShowing(IN movieId BIGINT, IN roomId INT, IN showDatetime DATETIME, IN newPrice DOUBLE)
BEGIN

    --Get Movie ID, show_length from Movie Name--
    DECLARE showLength, numAvailSeats INT;
    SELECT movie_length_in_mins
        INTO showLength
        FROM movie
        WHERE movie.movie_id = movieId;
    SELECT num_seats
        INTO numAvailSeats
        FROM room
        WHERE room.room_id = roomId;
        
    INSERT INTO movie_showing ( movie_id, room_id, show_datetime, num_avail_seats, price, show_length_in_mins ) 
        VALUES ( movieId, roomId, showDatetime, numAvailSeats, newPrice, showLength );

END //
DELIMITER ;

-- call sp_insertRowsIntoMovieShowing(1, 1, '2022-11-04 20:00:00', 6.99);
-- call sp_insertRowsIntoMovieShowing(1, 2, '2022-11-04 20:00:00', 6.99);
-- call sp_insertRowsIntoMovieShowing(1, 3, '2022-11-06 20:00:00', 6.99);
-- call sp_insertRowsIntoMovieShowing(1, 4, '2022-11-06 20:00:00', 6.99);
-- call sp_insertRowsIntoMovieShowing(2, 3, '2022-11-04 20:00:00', 6.99);
-- call sp_insertRowsIntoMovieShowing(2, 4, '2022-11-04 20:00:00', 6.99);
-- call sp_insertRowsIntoMovieShowing(4, 5, '2022-11-04 20:00:00', 7.99);
-- call sp_insertRowsIntoMovieShowing(6, 6, '2022-11-08 20:00:00', 7.99);
-- call sp_insertRowsIntoMovieShowing(18, 7, '2022-11-03 19:00:00', 8.99);
-- call sp_insertRowsIntoMovieShowing(18, 7, '2022-11-01 19:00:00', 5.99);