DROP PROCEDURE IF EXISTS sp_insertRowsIntoSeats;
DELIMITER //  
CREATE PROCEDURE sp_insertRowsIntoSeats(IN roomId INT)
BEGIN

    DECLARE i INT DEFAULT 1;
    WHILE (i <= 20) DO
        INSERT INTO seat ( room_id, seat_num ) VALUES (roomId, i);
        SET i = i+1;
    END WHILE;

END //
DELIMITER ;

-- call sp_insertRowsIntoSeats(1);
-- call sp_insertRowsIntoSeats(2);
-- call sp_insertRowsIntoSeats(3);
-- call sp_insertRowsIntoSeats(4);
-- call sp_insertRowsIntoSeats(5);
-- call sp_insertRowsIntoSeats(6);
-- call sp_insertRowsIntoSeats(7);
