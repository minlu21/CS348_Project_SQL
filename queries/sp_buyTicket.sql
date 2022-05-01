DROP PROCEDURE IF EXISTS sp_buyTicket;
DELIMITER //  
CREATE PROCEDURE sp_buyTicket(IN movieId BIGINT, IN roomId INT, IN showDatetime DATETIME, IN seatNum INT, IN userId BIGINT, OUT exit_code INT)
BEGIN

    DECLARE avail INT;
    DECLARE insertPrice DOUBLE;
    DECLARE curr_time DATETIME;

    SELECT NOW() INTO curr_time;
    
    SELECT num_avail_seats
		INTO avail
        FROM movie_showing ms
        JOIN movie m ON ms.movie_id = m.movie_id
        WHERE ms.room_id = roomId AND m.movie_id = movieId AND ms.show_datetime = showDatetime;

    SELECT price
		INTO insertPrice
        FROM movie_showing ms 
        JOIN movie m ON ms.movie_id = m.movie_id
        WHERE ms.room_id = roomId AND m.movie_id = movieId AND ms.show_datetime = showDatetime;

    IF avail > 0 THEN
        -- check if seat is available --
        IF seatNum NOT IN(SELECT seat_num FROM ticket WHERE room_id = roomId AND movie_id = movieId AND show_datetime = showDatetime) THEN
            INSERT INTO ticket ( is_used, price, purchase_datetime, show_datetime, movie_id, room_id, seat_num, user_id )
                VALUES ( 0, insertPrice, curr_time, showDatetime, movieId, roomId, seatNum, userId );
            UPDATE movie_showing ms
                SET ms.num_avail_seats = ms.num_avail_seats - 1 
                WHERE ms.room_id = roomId AND ms.movie_id = movieId AND ms.show_datetime = showDatetime;
			UPDATE movie m
				SET m.num_tickets_sold = m.num_tickets_sold + 1
                WHERE m.movie_id = movieId;
			UPDATE movie m
				SET m.total_ticket_earnings = m.total_ticket_earnings + insertPrice
                WHERE m.movie_id = movieId;
            SELECT 0 INTO exit_code;
        ELSE
            SELECT 1 INTO exit_code;
        END IF;
	ELSE
        SELECT 2 INTO exit_code;
    END IF;
    
END //
DELIMITER ;

-- USE MOVIE ID instead of MOVIE NAME for FIRST PARAMETER:
-- call sp_buyTicket("Harry Potter and the Philosopher's Stone", 1, '2022-11-04 20:00:00', 15, 1, @exit);
-- call sp_buyTicket("Harry Potter and the Philosopher's Stone", 1, '2022-11-04 20:00:00', 15, 1, @exit);
-- call sp_buyTicket("Harry Potter and the Philosopher's Stone", 1, '2022-11-04 20:00:00', 2, 1, @exit);
