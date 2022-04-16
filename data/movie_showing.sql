DROP PROCEDURE IF EXISTS sp_insertRowsIntoMovieShowing;
DELIMITER //  
CREATE PROCEDURE sp_insertRowsIntoMovieShowing(IN movieName VARCHAR(255), IN roomId INT, IN showDatetime DATETIME)
BEGIN

    --Get Movie ID, show_length from Movie Name--
    DECLARE movieId, showLength, numAvailSeats INT;
    SELECT movie_id, movie_length_in_mins
        INTO movieId, showLength
        FROM movie
        WHERE movie.name = movieName;
    SELECT num_seats
        INTO numAvailSeats
        FROM room
        WHERE room.room_id = roomId;
        
    INSERT INTO movie_showing ( movie_id, room_id, show_datetime, show_length_in_mins ) VALUES(movieId, roomId, showDatetime, showLength);

END //
DELIMITER ;

-- call sp_insertRowsIntoMovieShowing("Harry Potter and the Philosopher's Stone", 1, '2022-11-04 20:00:00');
-- call sp_insertRowsIntoMovieShowing("Harry Potter and the Philosopher's Stone", 2, '2022-11-04 20:00:00');
-- call sp_insertRowsIntoMovieShowing("Harry Potter and the Philosopher's Stone", 3, '2022-11-06 20:00:00');
-- call sp_insertRowsIntoMovieShowing("Harry Potter and the Philosopher's Stone", 4, '2022-11-06 20:00:00');
-- call sp_insertRowsIntoMovieShowing("Harry Potter and the Chamber of Secrets", 3, '2022-11-04 20:00:00');
-- call sp_insertRowsIntoMovieShowing("Harry Potter and the Chamber of Secrets", 4, '2022-11-04 20:00:00');
-- call sp_insertRowsIntoMovieShowing("The Avengers", 5, '2022-11-04 20:00:00');
-- call sp_insertRowsIntoMovieShowing("Guardians of the Galaxy", 6, '2022-11-04 20:00:00');
-- call sp_insertRowsIntoMovieShowing("Guardians of the Galaxy", 7, '2022-11-04 19:00:00');