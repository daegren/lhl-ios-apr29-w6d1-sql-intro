## Intro to SQL

### ERD

![DB Scheema](https://i.imgur.com/5LYKCdw.png)

### What is SQL?

Structured Query Language. Standard syntax of querying & manipulating data in relational databases. Used by many RDMS, such as Oracle, PostgreSQL, MySQL, etc.

### CRUD

INSERT
SELECT
UPDATE
DELETE

#### Cheat Sheet

##### Create syntax

```sql
CREATE TABLE artists (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  name VARCHAR(50) NOT NULL
);

CREATE TABLE albums (
  id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
  title VARCHAR(50) NOT NULL,
  year INTEGER NOT NULL,
  artist_id INTEGER NOT NULL REFERENCES artists(id) ON DELETE CASCADE
);

INSERT INTO "artists" (id, name) VALUES(4, "Daft Punk");

INSERT INTO "albums" (id, title, year, artist_id) VALUES (5, "Discovery", 2001, 4);
```

##### SELECT Syntax

Choose columns to display from table...

```sql
SELECT col1, col2, col3, ... FROM table1
```

...choose which rows to display...

```sql
WHERE col4 = 1 AND col5 = 2
```

...aggregate the data...

```sql
GROUP BY ...
```

...limit the aggregated data...

```sql
HAVING COUNT(*) > 1
```

...order the results

```sql
ORDER BY col2
```

##### UPDATE Syntax

```sql
UPDATE table_name
SET column1=value, column2=value,...
WHERE some_column=some_value
```

##### DELETE Syntax

```sql
DELETE FROM table_name
WHERE some_column = some_value
```

### What is SQLite?

- It's a RDMS.
- Doesn't require a server unlike other RDMS.
- The DB is a single file.

#### SQLite Data Types

https://www.sqlite.org/datatype3.html

- `NULL` - no value (use IS NULL)
- `INTEGER` - signed integer
- `REAL` - 8 byte floating point integer
- `TEXT` - UTF-8/16BE/16LE string
- `BLOB` - binary data

#### Joins

Combine records from more than 1 table by using some common value(s) shared between the tables.

For example: Employee & Department tables

How do we list the department each employee is in?

Do INNER JOIN on the department's primary key and the employee's foreign key.

#### Inner vs Outer Joins

An inner join focuses on the commonality between two tables. When using an inner join, there must be at least some matching data between two (or more) tables that are being compared. An inner join searches tables for matching or overlapping data. Upon finding it, the inner join combines and returns the information into one new table.

An outer join returns a set of records (or rows) that include what an inner join would return but also includes other rows for which no corresponding match is found in the other table.

There are three types of outer joins:

- Left Outer Join (or Left Join)
- Right Outer Join (or Right Join)
- Full Outer Join (or Full Join)

Each of these outer joins refers to the part of the data that is being compared, combined, and returned. Sometimes nulls will be produced in this process as some data is shared while other data is not.

Note that Sqlite only supports left outer joins.

For more details, see: https://www.diffen.com/difference/Inner_Join_vs_Outer_Join

#### Exercises In Class

List all artists along with their albums (INNER JOIN example)

```sql
SELECT artists.name, albums.title, albums.year
  FROM artists
  JOIN albums ON artists.id = albums.artist_id;
```

List all artists and the number of albums each. (GROUP BY w/ JOIN)

```sql
SELECT artists.name, count(albums.id)
  FROM artists
  JOIN albums ON artists.id = albums.artist_id
  GROUP BY artists.id;
```

List all artists and albums along with the count of tracks per album, order results by number of tracks descending.

```sql
SELECT artists.name, albums.title, count(tracks.id) as track_count
  FROM artists
  JOIN albums ON artists.id = albums.artist_id
  JOIN tracks ON albums.id = tracks.album_id
  GROUP BY artists.id, albums.title
  ORDER BY track_count DESC;
```

#### Files

##### Getting Started

To import the database seed use the following command:

```bash
$ sqlite3 db_name.db < setup.sql
```

You can the use the `sqlite3` command to also enter a query REPL for the database:

```bash
$ sqlite3 db_name.db
sqlite> SELECT * FROM artists;
1|Explosions in the Sky
2|God is an Astronaut
3|Ratatat
4|Daft Punk
sqlite>
```

You may download all the files used in class here: https://github.com/daegren/lhl-ios-apr29-w6d1-sql-intro

The online tool we used for ERDs is draw.io.
