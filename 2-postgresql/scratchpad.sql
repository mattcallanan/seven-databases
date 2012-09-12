CREATE TABLE countries ( country_code char(2) PRIMARY KEY, country_name text UNIQUE );  
CREATE TABLE cities ( name text NOT NULL, postal_code varchar(9) CHECK (postal_code <> ''), country_code char(2) REFERENCES countries, PRIMARY KEY (country_code, postal_code) ); 
INSERT INTO countries (country_code, country_name) VALUES ('us','United States'), ('mx','Mexico'), ('au','Australia'), ('gb','United Kingdom'), ('de','Germany'), ('ll','Loompaland'); 
INSERT INTO cities VALUES ('Portland','87200','us'); 
UPDATE cities SET postal_code = '97205' WHERE name = 'Portland'; 
SELECT cities.*, country_name FROM cities INNER JOIN countries ON cities.country_code = countries.country_code; 
CREATE TABLE venues ( venue_id SERIAL PRIMARY KEY, name varchar(255), street_address text, type char(7) CHECK ( type in ('public','private') ) DEFAULT 'public', postal_code varchar(9), country_code char(2), FOREIGN KEY (country_code, postal_code) REFERENCES cities (country_code, postal_code) MATCH FULL ); 
SELECT v.venue_id, v.name, c.name FROM venues v INNER JOIN cities c ON v.postal_code=c.postal_code AND v.country_code=c.country_code; 
INSERT INTO venues (name, postal_code, country_code) VALUES ('Crystal Ballroom', '97205', 'us'); 
insert into events (title, starts, ends, venue_id) values ('Wedding', '2012-02-26 21:00:00', '2012-02-26 23:00:00', (select venue_id from venues where name = 'Voodoo Donuts'));
insert into events (title, starts, ends, venue_id) values ('Dinner with Mom', '2012-02-26 18:00:00', '2012-02-26 20:30:00', (select venue_id from venues where name = 'My Place'));
insert into events (title, starts, ends) values ('Valentine''s Day', '2012-02-14 00:00:00', '2012-02-14 23:59:00');
SELECT count(title) FROM events WHERE title LIKE '%Day%'; 
SELECT min(starts), max(ends) FROM events INNER JOIN venues ON events.venue_id = venues.venue_id WHERE venues.name = 'Crystal Ballroom'; 
SELECT venue_id, count(*) FROM events GROUP BY venue_id; 
SELECT venue_id FROM events GROUP BY venue_id HAVING count(*) >= 2 AND venue_id IS NOT NULL; 
SELECT venue_id FROM events GROUP BY venue_id; 
SELECT DISTINCT venue_id FROM events; 
SELECT title, count(*) OVER (PARTITION BY venue_id) FROM events; 
SELECT v.venue_id, v.name, c.name FROM venues v INNER JOIN cities c ON v.postal_code=c.postal_code AND v.country_code=c.country_code; 
SELECT v.venue_id, v.name, c.name FROM venues v INNER JOIN cities c ON v.postal_code=c.postal_code AND v.country_code=c.country_code; 
delete from venues where venue_id = 2;
SELECT v.venue_id, v.name, c.name FROM venues v INNER JOIN cities c ON v.postal_code=c.postal_code AND v.country_code=c.country_code; 
INSERT INTO venues (name, postal_code, country_code) VALUES ('Voodoo Donuts', '97205', 'us') RETURNING venue_id; 
create table events ( event_id serial primary key, 
title varchar(255), 
starts timestamp, 
ends timestamp,
venue_id integer references venues
insert into events (title, starts, ends, venue_id) values ('LARP Club', '2012-02-15 17:30:00', '2012-02-15 19:30:00', 3);
insert into events (title, starts, ends) values ('April Fools', '2012-04-01 00:00:00', '2012-04-01 23:59:00');
insert into events (title, starts, ends) values ('Christmas', '2012-12-25 00:00:00', '2012-12-25 23:59:00');
delete from events where event_id in (4,5,6);
SELECT e.title, v.name FROM events e JOIN venues v ON e.venue_id = v.venue_id; 
SELECT e.title, v.name FROM events e LEFT JOIN venues v ON e.venue_id = v.venue_id; 
select country_name from countries
    INNER JOIN cities c on c.country_code = countries.country_code
    INNER JOIN venues v ON v.postal_code=c.postal_code AND v.country_code=c.country_code
    INNER JOIN events e ON e.venue_id=v.venue_id AND e.title = 'LARP Club';
INSERT INTO events (title, starts, ends, venue_id) VALUES ('Moby', '2012-02-06 21:00', '2012-02-06 23:00', ( SELECT venue_id FROM venues WHERE name = 'Crystal Ballroom' ) ); 
SELECT add_event('House Party', '2012-05-03 23:00', '2012-05-04 02:00', 'Run''s House', '97205', 'us'); 
CREATE TABLE logs ( event_id integer, old_title varchar(255), old_starts timestamp, old_ends timestamp, logged_at timestamp DEFAULT current_timestamp ); 
CREATE TRIGGER log_events AFTER UPDATE ON events FOR EACH ROW EXECUTE PROCEDURE log_event(); 
UPDATE events SET ends='2012-05-04 01:00:00' WHERE title='House Party'; 
SELECT event_id, old_title, old_ends, logged_at FROM logs; 
CREATE VIEW holidays AS SELECT event_id AS holiday_id, title AS name, starts AS date FROM events WHERE title LIKE '%Day%' AND venue_id IS NULL; 
SELECT name, to_char(date, 'Month DD, YYYY') AS date FROM holidays WHERE date <= '2012-04-01'; 
ALTER TABLE events ADD colors text ARRAY; 
CREATE OR REPLACE VIEW holidays AS SELECT event_id AS holiday_id, title AS name, starts AS date, colors FROM events WHERE title LIKE '%Day%' AND venue_id IS NULL; 
--UPDATE holidays SET colors = '{"red","green"}' where name = 'Christmas Day'; 
EXPLAIN VERBOSE SELECT * FROM holidays; 
-- create_rule.sql
UPDATE holidays SET colors = '{"red","green"}' where name = 'Christmas Day';
CREATE RULE insert_holidays AS ON INSERT TO holidays DO INSTEAD
  INSERT INTO events (title, starts, colors)
  VALUES (NEW.name, NEW.date, NEW.colors);
INSERT INTO holidays (name, date, colors) VALUES ('September 11', '2012-09-11', '{"black"}');
SELECT extract(year from starts) as year, extract(month from starts) as month, count(*) FROM events GROUP BY year, month; 
CREATE TEMPORARY TABLE month_count(month INT); INSERT INTO month_count VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12); 
CREATE EXTENSION tablefunc;
--SELECT * FROM crosstab( 'SELECT extract(year from starts) as year, extract(month from starts) as month, count(*) FROM events GROUP BY year, month', 'SELECT * FROM month_count' ); 
SELECT * FROM crosstab( 'SELECT extract(year from starts) as year, extract(month from starts) as month, count(*) FROM events GROUP BY year, month', 'SELECT * FROM month_count' ) AS ( year int, jan int, feb int, mar int, apr int, may int, jun int, jul int, aug int, sep int, oct int, nov int, dec int ) ORDER BY YEAR; 

--Build a pivot table that displays every day in a single month, where each week of the month is a row and each day name forms a column across the top 
--  (seven days, starting with Sunday and ending with Saturday) like a standard month calendar
--Each day should contain a count of the number of events for that date or should remain blank if no event occurs



-- create_movies.sql
-- movies_data.sql
SELECT COUNT(*) FROM movies WHERE title !~* '^the.*'; 
SELECT levenshtein('bat', 'fad') fad, levenshtein('bat', 'fat') fat, levenshtein('bat', 'bat') bat; 
SELECT movie_id, title FROM movies WHERE levenshtein(lower(title), lower('a hard day nght')) <= 3;
CREATE INDEX movies_title_trigram ON movies USING gist (title gist_trgm_ops);
SELECT * FROM movies WHERE title % 'Avatre'; 
SELECT title FROM movies WHERE title @@ 'night & day'; 
-- same as 
SELECT title FROM movies WHERE to_tsvector(title) @@ to_tsquery('english', 'night & day'); 
-- same as 
SELECT to_tsvector('A Hard Day''s Night'), to_tsquery('english', 'night & day'); 
SELECT to_tsvector('english', 'A Hard Day''s Night'); 
SELECT to_tsvector('simple', 'A Hard Day''s Night'); 
SELECT ts_lexize('english_stem', 'Day''s'); 
SELECT to_tsvector('german', 'was machst du gerade?'); 
EXPLAIN SELECT * FROM movies WHERE title @@ 'night & day';
CREATE INDEX movies_title_searchable ON movies USING gin(to_tsvector('english', title)); 
SELECT title FROM movies NATURAL JOIN movies_actors NATURAL JOIN actors WHERE metaphone(name, 6) = metaphone('Broos Wils', 6);  
SELECT name, dmetaphone(name), dmetaphone_alt(name), metaphone(name, 8), soundex(name) FROM actors; 
SELECT * FROM actors WHERE metaphone(name,8) % metaphone('Robin Williams',8) ORDER BY levenshtein(lower('Robin Williams'), lower(name)); 
SELECT name, cube_ur_coord('(0,7,0,0,0,0,0,0,0,7,0,0,0,0,10,0,0,0)', position) as score FROM genres g WHERE cube_ur_coord('(0,7,0,0,0,0,0,0,0,7,0,0,0,0,10,0,0,0)', position) > 0; 
SELECT *, cube_distance(genre, '(0,7,0,0,0,0,0,0,0,7,0,0,0,0,10,0,0,0)') dist FROM movies ORDER BY dist; 
SELECT cube_enlarge('(1,1)',1,2);
SELECT title, cube_distance(genre, '(0,7,0,0,0,0,0,0,0,7,0,0,0,0,10,0,0,0)') dist FROM movies WHERE cube_enlarge('(0,7,0,0,0,0,0,0,0,7,0,0,0,0,10,0,0,0)'::cube, 5, 18) @> genre ORDER BY dist; 
SELECT m.movie_id, m.title FROM movies m, (SELECT genre, title FROM movies WHERE title = 'Mad Max') s WHERE cube_enlarge(s.genre, 5, 18) @> m.genre AND s.title <> m.title ORDER BY cube_distance(m.genre, s.genre) LIMIT 10; 



