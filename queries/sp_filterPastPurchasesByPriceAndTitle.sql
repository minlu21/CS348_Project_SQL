DROP PROCEDURE IF EXISTS sp_filterPastPurchasesByPriceAndTitle;
DEFINER=`root`@`localhost` 
DELIMITER //
CREATE PROCEDURE `sp_filterPastPurchasesByPriceAndTitle`(IN userID VARCHAR(255), IN lowerPrice DOUBLE, IN higherPrice DOUBLE, IN title VARCHAR(255))
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
	WHERE u.username = userID AND t.price BETWEEN minPrice AND maxPrice AND m.name LIKE CONCAT("%", movieName, "%");        

END //
DELIMITER ;