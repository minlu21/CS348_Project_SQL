DROP PROCEDURE IF EXISTS sp_insertRowsIntoMovieShowing;
DELIMITER //  
CREATE PROCEDURE sp_insertRowsIntoMovieShowing(IN movieName VARCHAR(255), IN roomId INT, IN showDatetime DATETIME)
BEGIN

    --Get Movie ID, show_length from Movie Name--
    DECLARE movieId, showLength INT;
    SELECT movie_id, movie_length_in_mins
        INTO movieId, showLength
        FROM movie
        WHERE movie.name = movieName;
    
   INSERT INTO movie_showing ( movie_id, room_id, show_datetime, show_length_in_mins ) VALUES(movieId, roomId, showDatetime, showLength);

END //
DELIMITER ;

-- call sp_insertRowsIntoMovieShowing("Harry Potter and the Philosopher's Stone", 1, '2022-11-04 20:00:00');
-- call sp_insertRowsIntoMovieShowing("Harry Potter and the Chamber of Secrets", 2, '2022-11-04 20:00:00');
-- call sp_insertRowsIntoMovieShowing("Harry Potter and the Chamber of Secrets", 3, '2022-11-05 19:00:00');
-- call sp_insertRowsIntoMovieShowing("Harry Potter and the Prisoners of Azkaban", 3, '2022-11-05 18:30:00');