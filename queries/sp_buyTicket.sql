DROP PROCEDURE IF EXISTS sp_buyTicket;
DELIMITER //  
CREATE PROCEDURE sp_buyTicket(IN movieName VARCHAR(255), IN roomId INT, IN showDatetime DATETIME, IN seatNum INT, IN userId BIGINT, OUT exit_code INT)
BEGIN

    DECLARE avail INT;
    DECLARE movieId BIGINT;
    DECLARE insertPrice DOUBLE;
    DECLARE curr_time DATETIME;
    DECLARE isAvail TINYINT(1) DEFAULT false; 

    SELECT NOW() INTO curr_time;

    SELECT num_avail_seats, price, m.movie_id
        INTO avail, insertPrice, movieId
        FROM movie_showing ms
        JOIN movie m ON ms.movie_id = m.movie_id
        WHERE ms.room_id = roomId AND m.name = movieName AND ms.show_datetime = showDatetime;

    IF avail > 0 THEN
        -- check if seat is available --
        IF seatNum NOT IN(SELECT seat_num FROM ticket WHERE room_id = roomId) THEN
            INSERT INTO ticket ( is_used, price, purchase_datetime, show_datetime, movie_id, room_id, seat_num, user_id )
                VALUES ( 0, insertPrice, curr_time, showDatetime, movieId, roomId, seatNum, userId );
            UPDATE movie_showing ms
                SET ms.num_avail_seats = ms.num_avail_seats - 1 
                WHERE ms.room_id = roomId AND ms.movie_id = movieId AND ms.show_datetime = showDatetime;
            SELECT 0 INTO exit_code;
        ELSE
            SELECT 1 INTO exit_code;
        END IF;
    ELSE
        SELECT 1 INTO exit_code;
    END IF;
END //
DELIMITER ;

-- call sp_buyTicket("Harry Potter and the Philosopher's Stone", 1, '2022-11-04 20:00:00', 15, 1, @exit);
-- call sp_buyTicket("Harry Potter and the Philosopher's Stone", 1, '2022-11-04 20:00:00', 15, 1, @exit);
-- call sp_buyTicket("Harry Potter and the Philosopher's Stone", 1, '2022-11-04 20:00:00', 2, 1, @exit);
