CREATE INDEX movieNameIndex USING BTREE ON movie(name);
CREATE INDEX movieDateIndex USING BTREE ON movie(production_date);
CREATE INDEX movieIDIndex ON movie(movie_id);
CREATE INDEX movieTicketsSoldIndex USING BTREE ON movie(num_tickets_sold);
CREATE INDEX movieTicketEarningsIndex USING BTREE ON movie(total_ticket_earnings);
CREATE INDEX movieShowingIdIndex ON movie_showing(movie_id);
CREATE INDEX movieShowingDateIndex USING BTREE ON movie_showing(show_datetime);
CREATE INDEX roomIDIndex ON room(room_id);
CREATE INDEX seatRIDIndex ON seat(room_id);
CREATE INDEX ticketPriceIndex USING BTREE ON ticket(price);
CREATE INDEX ticketUserIDIndex USING BTREE ON ticket(user_id);
CREATE INDEX userIDIndex ON user(user_id);
CREATE INDEX usernameIndex ON user(username);