CREATE DATABASE BOOKDEALER;
USE BOOKDEALER;
CREATE TABLE AUTHOR(AUTHOR_ID INT,NAME VARCHAR(30),CITY VARCHAR(30),COUNTRY VARCHAR(30));
CREATE TABLE PUBLISHER(PUBLISHER_ID INT,NAME VARCHAR(30),CITY VARCHAR(30),COUNTRY VARCHAR(30));
CREATE TABLE AUTHOR(AUTHOR_ID INT,NAME VARCHAR(30),CITY VARCHAR(30),COUNTRY VARCHAR(30),PRIMARY KEY(AUTHOR_ID));
CREATE TABLE PUBLISHER(PUBLISHER_ID INT,NAME VARCHAR(30),CITY VARCHAR(30),COUNTRY VARCHAR(30),PRIMARY KEY(PUBLISHER_ID));
CREATE TABLE CATEGORY(CATEGORY_ID INT,DESCRIPTION VARCHAR(200), PRIMARY KEY(CATEGORY_ID));
CREATE TABLE CATALOG(BOOK_ID INT,TITLE VARCHAR(50), AUTHOR_ID INT, PUBLISHER_ID INT,CATEGORY_ID INT,AYEAR INT,PRICE INT,FOREIGN KEY(AUTHOR_ID) REFERENCES AUTHOR(AUTHOR_ID) ON DELETE CASCADE, FOREIGN KEY(PUBLISHER_ID) REFERENCES PUBLISHER(PUBLISHER_ID) ON DELETE CASCADE, FOREIGN KEY(CATEGORY_ID) REFERENCES CATEGORY(CATEGORY_ID) ON DELETE CASCADE);
CREATE TABLE CATALOG(BOOK_ID INT,TITLE VARCHAR(50), AUTHOR_ID INT, PUBLISHER_ID INT,CATEGORY_ID INT,AYEAR INT,PRICE INT,FOREIGN KEY(AUTHOR_ID) REFERENCES AUTHOR(AUTHOR_ID) ON DELETE CASCADE, FOREIGN KEY(PUBLISHER_ID) REFERENCES PUBLISHER(PUBLISHER_ID) ON DELETE CASCADE, FOREIGN KEY(CATEGORY_ID) REFERENCES CATEGORY(CATEGORY_ID) ON DELETE CASCADE, PRIMARY KEY(BOOK_ID));
CREATE TABLE ORDERDETAILS(ORDER_NO INT,BOOK_ID INT, QUANTITY INT, FOREIGN KEY(BOOK_ID) REFERENCES CATALOG(BOOK_ID));

insert into author values(1001,"Teras Chan","CA","USA");
insert into author values(1002,"Stevens","Zombi","Uganda");
insert into author values(1003,"M Mano","Cair","Canada");
insert into author values(1004,"Karthik B P","New York","USA");
insert into author values(1005,"Willian Stalling","Las Vegas","USA");

insert into publisher values(1,"Pearson","New York","USA");
insert into publisher values(2,"EEE","New South Vales","USA");
insert into publisher values(3,"PHI","Delhi","India");
insert into publisher values(4,"Willey","Berlin","Germany");
insert into publisher values(5,"MGH","New York","USA");

insert into category values(1001,"Computer Science");
insert into category values(1002,"Algorithm Design");
insert into category values(1003,"Electronics");
insert into category values(1004,"Programming");
insert into category values(1005,"Operating Systems");

insert into catalog values(11,"Unix System",1001,1,1001,2000,251);
insert into catalog values(12,"Digital Signals",1002,2,1003,2001,425);
insert into catalog values(13,"Logic Design",1003,3,1002,1999,225);
insert into catalog values(14,"Server Prg",1004,4,1004,2001,333);
insert into catalog values(15,"Linux OS",1005,5,1005,2003,326);
insert into catalog values(16,"C++ Bible",1005,5,1001,2000,526);
insert into catalog values(17,"Cobol Handbook",1005,4,1001,2000,658);

insert into orderdetails values(1,11,5);
insert into orderdetails values(2,12,8);
insert into orderdetails values(3,13,15);
insert into orderdetails values(4,14,22);
insert into orderdetails values(5,15,3);
insert into orderdetails values(6,17,10);

/*Give the details of the authors who have 2 or more books in the catalog and the price of the books in the
catalog and the year of publication is after 2000.*/

SELECT * FROM AUTHOR WHERE AUTHOR_ID IN (SELECT AUTHOR_ID FROM CATALOG WHERE AYEAR>2000 AND PRICE> (SELECT AVG(PRICE) FROM CATALOG) GROUP BY AUTHOR_ID HAVING COUNT(*)>1);

/*Find the author of the book which has maximum sales.*/

SELECT NAME FROM AUTHOR A,CATALOG C WHERE A.AUTHOR_ID=C.AUTHOR_ID AND BOOK_ID IN (SELECT BOOK_ID FROM ORDERDETAILS WHERE QUANTITY= (SELECT MAX(QUANTITY) FROM ORDERDETAILS));

#Demonstrate how you increase the price of books published by a specific publisher by 10%.
UPDATE CATALOG SET PRICE=1.1*PRICE WHERE PUBLISHER_ID IN (SELECT PUBLISHER_ID FROM PUBLISHER WHERE NAME='PEARSON');
