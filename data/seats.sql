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