DROP PROCEDURE IF EXISTS sp_getAvailableSeats;
DELIMITER //  
CREATE PROCEDURE sp_getAvailableSeats(IN movieId BIGINT, IN roomId INT, IN showDatetime DATETIME)
BEGIN

    SELECT s.seat_num
		FROM seat s
		WHERE s.room_id = roomId
			AND s.seat_num NOT IN (
				SELECT t.seat_num
					FROM ticket t
					WHERE t.room_id = roomId AND t.show_datetime = showDatetime AND t.movie_id = movieId
				);

END //
DELIMITER ;