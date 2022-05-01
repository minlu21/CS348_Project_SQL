DROP PROCEDURE IF EXISTS sp_filterPastPurchasesByPriceAndTitle;
DELIMITER //  
CREATE PROCEDURE sp_filterPastPurchasesByPriceAndTitle(IN userID INTEGER, IN lowerPrice DOUBLE, IN higherPrice DOUBLE, IN title VARCHAR(255))
BEGIN
	DECLARE minPrice DOUBLE;
    DECLARE maxPrice DOUBLE;
    DECLARE movieName VARCHAR(255);

	SET minPrice = lowerPrice;
	SET maxPrice = higherPrice;
	SET movieName = title;
    
	SELECT m.name, t.purchase_datetime, t.show_datetime, t.price, t.room_id, t.seat_num
	FROM ticket t JOIN movie m ON t.movie_id = m.movie_id
	JOIN user u ON t.user_id = u.user_id
	WHERE u.user_id = userID AND t.price BETWEEN minPrice AND maxPrice AND m.name LIKE CONCAT("%", movieName, "%");        

END //
DELIMITER ;

-- call sp_filterTicketPurchasesByPriceAndTitle(11, 6, NULL, "");