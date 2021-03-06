CREATE DATABASE MOVIES;
USE MOVIES;

CREATE TABLE ACTOR(ACT_ID INT, ACT_NAME VARCHAR(30), ACT_GENDER VARCHAR(6), PRIMARY KEY(ACT_ID));
CREATE TABLE DIRECTOR(DIR_ID INT, DIR_NAME VARCHAR(50), DIR_PHONE INT, PRIMARY KEY(DIR_ID));
CREATE TABLE MOVIES(MOV_ID INT, MOV_TITLE VARCHAR(100), MOV_YEAR INT, MOV_LANG VARCHAR(30), DIR_ID INT, PRIMARY KEY(MOV_ID), FOREIGN KEY(DIR_ID) REFERENCES DIRECTOR(DIR_ID) ON DELETE CASCADE ON UPDATE CASCADE);
CREATE TABLE MOVIE_CAST(ACT_ID INT, MOV_ID INT, ROLEP VARCHAR(30), 
FOREIGN KEY(ACT_ID) REFERENCES ACTOR(ACT_ID) ON DELETE CASCADE ON UPDATE CASCADE,
FOREIGN KEY(MOV_ID) REFERENCES MOVIES(MOV_ID) ON DELETE CASCADE ON UPDATE CASCADE);
CREATE TABLE RATING(MOV_ID INT, STARS FLOAT,
 FOREIGN KEY(MOV_ID) REFERENCES MOVIES(MOV_ID) ON DELETE CASCADE ON UPDATE CASCADE);
 
 
#DATA ENTRY
#FIRST 3 IN MURDER! DIR HITCHCOOK 1930 ENGLISH 4.8 001->ACTOR-MANAGER, 002->ACTRESS 003->STAGE-MANAGER
#THE MAN WHO KNEW TOO MUCH, HITCHCOOK 1934 ENGLISH 4.5 4->HERO 5->VILLAIN 
#JURASSIC PARK STEVEN SPIELBERG 1993 ENGLISH 6->HERO 7-HEROINE
INSERT INTO ACTOR VALUES(001, "HERBERT MARSHALL", "MALE"),
(002, "NORAH BURING", "FEMALE"),
(003, "EDWARD CHAPMAN" , "MALE"),
(004, "LESLIE BANKS", "MALE"),
(005, "PETER LORRE", "MALE"),
(006, "SAM NEILL", "MALE"),
(007, "LAURA DERN", "FEMALE"),
(008, "RAJ KUMAR" ,"MALE"),
(009, "ANANT NAG", "MALE");

INSERT INTO ACTOR VALUES(010, "KALPANA", "FEMALE");

INSERT INTO DIRECTOR VALUES(001, "HITCHCOOK", 1234567890),
(002, "STEVEN SPIELBERG", 1345167890),
(003, "DORAI BHAGWAN", 1876543210),
(004, "RISHAB SHETTY", 1789012345);

INSERT INTO MOVIES VALUES(001, "MURDER!", 1930, "ENGLISH", 001),
(002, "THE MAN WHO KNEW TOO MUCH", 1934, "ENGLISH", 001),
(003, "JURASSIC PARK", 1993, "ENGLISH", 002),
(004, "ERADU KANASU", 1974, "KANNADA", 003),
(005, "BAYALU DAARI", 1976, "KANNADA", 003),
(006, "SARKARI HIRIYA PRATHAMIKA SHAALE KASARGOD", 2018, "KANNADA", 004);

INSERT INTO MOVIE_CAST VALUES(001, 001, "ACTOR-MANAGER"),
(002, 001, "ACTRESS"),
(003, 001, "STAGE-MANAGER"),
(004, 002, "HERO"),
(005, 002, "VILLAIN"),
(006, 003, "HERO"),
(007, 003, "HEROINE"),
(008, 004, "HERO"),
(010, 004, "HEROINE"),
(009, 005, "HERO"),
(010, 005, "HEROINE"),
(009, 006, "LAWYER");

INSERT INTO RATING VALUES(001, 4),
(001, 5),
(001, 5),
(002, 4),
(002, 4),
(002, 4),
(003, 5),
(003, 5),
(003, 5),
(004, 4),
(004, 4),
(005, 4),
(005, 4),
(006, 5),
(006, 5),
(006, 5);

#1. List the titles of all movies directed by ???Hitchcock???.
SELECT M.MOV_TITLE FROM MOVIES M, DIRECTOR D
WHERE M.DIR_ID = D.DIR_ID AND D.DIR_NAME = "HITCHCOOK";

#2. Find the movie names where one or more actors acted in two or more movies.
SELECT M.MOV_TITLE FROM MOVIES M, MOVIE_CAST MCT 
WHERE M.MOV_ID = MCT.MOV_ID AND MCT.ACT_ID IN 
(SELECT ACT_ID FROM MOVIE_CAST, MOVIES GROUP BY ACT_ID 
HAVING COUNT(ACT_ID)>1)
GROUP BY MOV_TITLE 
HAVING COUNT(*)>=2;

#List all actors who acted in a movie before 2000 and also in a movie after 2015 (use JOIN operation).
SELECT A.ACT_NAME, M.MOV_TITLE, M.MOV_YEAR
FROM ACTOR A JOIN
MOVIE_CAST MCT
ON A.ACT_ID=MCT.ACT_ID
JOIN MOVIES M
ON MCT.MOV_ID=M.MOV_ID
WHERE M.MOV_YEAR NOT BETWEEN 2000 AND 2015;

/*Find the title of movies and number of stars for each movie that has at least one rating and find the highest
number of stars that movie received. Sort the result by movie title.*/
SELECT MOV_TITLE , MAX(STARS)
FROM MOVIES 
INNER JOIN RATING USING (MOV_ID)
GROUP BY MOV_TITLE
HAVING MAX (STARS)>0
ORDER BY MOV_TITLE;

#Error Code: 1630. FUNCTION movies.MAX does not exist. Check the 'Function Name Parsing and Resolution' section in the Reference Manual
UPDATE RATING
SET STARS=5
WHERE MOV_ID IN (SELECT MOV_ID FROM MOVIES
WHERE DIR_ID IN (SELECT DIR_ID
FROM DIRECTOR
WHERE DIR_NAME='STEVEN SPIELBERG'));

SELECT * FROM RATING;
