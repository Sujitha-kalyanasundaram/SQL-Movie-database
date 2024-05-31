create database movie;
/*Create actor table*/
CREATE TABLE actor (
    act_id INT PRIMARY KEY, 
    act_fname VARCHAR(25),
    act_lname VARCHAR(25),
    act_gender VARCHAR(10)
);
insert into actor( act_id, act_fname,act_lname,act_gender)
values(101, 'John', 'Doe', 'Male'),
    (102, 'Jane', 'Smith', 'Female'),
    (103, 'Bob', 'Johnson', 'Male'),
    (104,' Richard','Adams','Male'),
    (105,'Gigi','Hadid','Female');
    select * from actor;
    
/* Create genres table*/
CREATE TABLE genres (
    gen_id INT PRIMARY KEY,
    gen_title VARCHAR(255)
);
INSERT INTO genres(gen_id, gen_title)
VALUES(201,'Horror'),
(202,'Action'),
(203,'Comedy'),
(204,'sci-fi'),
(205,'Drama');
select * from genres;

/*Create director table*/
CREATE TABLE director (
    dir_id INT PRIMARY KEY,
    dir_fname VARCHAR(25),
    dir_lname VARCHAR(25)
);
INSERT INTO Director(dir_id,dir_fname,dir_lname)
VALUES(301, 'Christopher', 'Nolan'),
(302,' Maggie', 'Smith'),
(303,' Kate' ,'Winslet'),
(304,'Daniel',' Radcliffe'),
(305,'Tom',' Hiddleston');
SELECT * FROM Director;

/*Create movie table*/
CREATE TABLE movie (
    mov_id INT PRIMARY KEY,
    mov_title VARCHAR(255),
    mov_year INT,
    mov_time INT,
    mov_lang VARCHAR(50),
    mov_dt_rel DATE,
    mov_rel_country VARCHAR(255)
);
INSERT INTO movie(mov_id,mov_title,mov_year,mov_time,mov_lang,mov_dt_rel,mov_rel_country)
VALUES(801, 'Titanic', 1997, 136, 'English', '1997-12-19', 'United States'),
    (802, 'Avengers', 2012, 148, 'English', '2012-06-27', 'United States'),
    (803, 'Spider Man', 2021, 154, 'English', '2021-12-14', 'United States'),
    (804,'Toy story',1995,152,'English','1995-04-17','United States'),
    (805,'Bahubali',2015,154,'Telugu','2015-07-09','India');
    SELECT * FROM movie;
    
/*Create movie_genres table*/
CREATE TABLE movie_genres (
    mov_id INT,
    gen_id INT,
    PRIMARY KEY (mov_id, gen_id),
    FOREIGN KEY (mov_id) REFERENCES movie(mov_id),
    FOREIGN KEY (gen_id) REFERENCES genres(gen_id)
);
INSERT INTO movie_genres(mov_id,gen_id)
VALUES(801,201),
(802,'202'),
(803,'203'),
(804,'204');
SELECT * FROM movie_genres;

/*Create movie_direction table*/
CREATE TABLE movie_direction (
    dir_id INT primary key,
    mov_id INT
   );
INSERT INTO movie_direction(dir_id,mov_id)
VALUES(301,801),
(302,'802'),
(303,'803'),
(304,'804');
SELECT * FROM movie_direction;

/*Create reviewer table*/
CREATE TABLE reviewer (
    rev_id INT PRIMARY KEY,
    rev_name VARCHAR(255)
);
INSERT INTO reviewer(rev_id, rev_name) 
values(701,'scott'),
(702,'Bella'),
(703,'Gigi'),
(704,'Selena'),
(705,'Taylore'),
(706,'Megan');
select * from reviewer;

/*Create rating table*/
CREATE TABLE rating (
    mov_id INT,
    rev_id INT,
    rev_stars decimal(10,2), 
    num_o_rating INT,
    PRIMARY KEY (mov_id, rev_id),
    FOREIGN KEY (mov_id) REFERENCES movie(mov_id),
    FOREIGN KEY (rev_id) REFERENCES reviewer(rev_id)
);

INSERT INTO rating(mov_id, rev_id, rev_stars, num_o_rating)
VALUES
    (801, 701, 8.38, 227235),
    (802, 702, 8.38, 537893),
    (803, 703, 8.38, 294727),
    (804, 704, 8.38, 278409),
    (805, 705, 8.38, 472894);
    select * from rating;    

/*Create movie_cast table*/
CREATE TABLE movie_cast (
    act_id INT,
    mov_id INT,
    role VARCHAR(255),
    PRIMARY KEY (act_id, mov_id),
    FOREIGN KEY (act_id) REFERENCES actor(act_id),
    FOREIGN KEY (mov_id) REFERENCES movie(mov_id)
);
insert into movie_cast( act_id, mov_id, role)
values(101,801,'lead_Actor'),
(102,802,'Actress'),
(103,803,'supporting_actor'),
(104,804,'Director'),
(105,805,'Producer');
SELECT * FROM movie_cast;  

SELECT mov_title, mov_year, mov_lang
FROM movie
WHERE mov_rel_country = 'United States';

SELECT m.mov_title, g.gen_title
FROM movie m
JOIN movie_genres mg ON m.mov_id = mg.mov_id
JOIN genres g ON mg.gen_id = g.gen_id
WHERE g.gen_title = 'Horror';

SELECT m.mov_title, m.mov_year
FROM movie_direction md
JOIN movie m ON md.mov_id = m.mov_id
WHERE md.dir_id = 301;

SELECT mc. role, m.mov_title
FROM movie_cast mc
JOIN movie m ON mc.mov_id = m.mov_id
WHERE mc.act_id = 105;

SELECT m.mov_title, AVG(r.rev_stars) AS avg_rating, COUNT(r.rev_id) AS num_ratings
FROM movie m
JOIN rating r ON m.mov_id = r.mov_id
GROUP BY m.mov_title;

SELECT  m.mov_title, r.rev_stars
FROM rating r
JOIN movie m ON r.mov_id = m.mov_id
WHERE r.rev_id = 702;






