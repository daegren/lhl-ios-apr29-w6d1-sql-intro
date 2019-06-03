-- SELECTING w/ Joins

select artists.name as artist_name, albums.title as album_title, year, tracks.number, tracks.title as track_title from artists
join albums on albums.artist_id = artists.id 
join tracks on tracks.album_id = albums.id
where artists.id = 4;

-- SELECTING w/ implicit join

select artists.name as artist_name, albums.title as album_title, year, tracks.number, tracks.title as track_title 
from artists, albums, tracks
where artists.id = 4
and artists.id = albums.artist_id
and albums.id = tracks.album_id;

-- SELECTING w/ aggregation & WHERE & HAVING
select name, count(albums.id) as album_count
from artists
join albums on artists.id = artist_id
where albums.year > 2005
group by artists.id
having album_count >= 1;
