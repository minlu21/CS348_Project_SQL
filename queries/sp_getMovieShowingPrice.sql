CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getMovieShowingPrice`(IN movieId BIGINT, IN roomId INT, IN showDatetime DATETIME, OUT ticket_prc DOUBLE)
BEGIN

    SELECT ms.price 
		INTO ticket_prc
        FROM movie_showing ms
        WHERE ms.movie_id = movieId AND ms.room_id = roomId AND ms.show_datetime = showDatetime;

END