CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_getMovieShowingsWithAvail`(IN movieId BIGINT)
BEGIN

    SELECT ms.room_id, ms.show_datetime 
        FROM movie m
        JOIN movie_showing ms ON m.movie_id = ms.movie_id
        WHERE m.movie_id = movieId AND ms.num_avail_seats <> 0;

END