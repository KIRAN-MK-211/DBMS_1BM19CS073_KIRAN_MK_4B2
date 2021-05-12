CREATE DATABASE BANKING;
USE BANKING;
CREATE TABLE BRANCH(BRANCH_NAME VARCHAR(30), BRANCH_CITY VARCHAR(30), ASSETS FLOAT, PRIMARY KEY(BRANCH_NAME));
CREATE TABLE ACCOUNTS(ACC_NO INT, BRANCH_NAME VARCHAR(30), BALANCE FLOAT, PRIMARY KEY(ACC_NO),FOREIGN KEY(BRANCH_NAME) REFERENCES BRANCH(BRANCH_NAME) ON DELETE CASCADE);
CREATE TABLE CUSTOMER(ACC_NO INT,CUST_NAME VARCHAR(30), CUST_STREET VARCHAR(100), CUST_CITY VARCHAR(30), PRIMARY KEY(CUST_NAME), FOREIGN KEY ACCOUNTS(ACC_NO) REFERENCES ACCOUNTS(ACC_NO) ON DELETE CASCADE ON UPDATE CASCADE);
CREATE TABLE LOAN(LOAN_NO INT, BRANCH_NAME VARCHAR(30), AMOUNT FLOAT, PRIMARY KEY(LOAN_NO), FOREIGN KEY(BRANCH_NAME) REFERENCES BRANCH(BRANCH_NAME) ON DELETE CASCADE);
CREATE TABLE BORROWER(CUST_NAME VARCHAR(30), LOAN_NO INT, FOREIGN KEY(CUST_NAME) REFERENCES CUSTOMER(CUST_NAME) ON DELETE CASCADE, FOREIGN KEY(LOAN_NO) REFERENCES LOAN(LOAN_NO) ON DELETE CASCADE);




#ENTERING THE DATA

INSERT INTO BRANCH VALUES("SBI PD NAGAR", "BANGALORE", 200000),
("SBI RAJAJI NAGAR", "BANGALORE" ,500000),
("SBI JAYANAGAR" ,"BANGALORE", 660000),
("SBI VIJAY NAGAR" ,"BANGALORE", 870000),
("SBI HOSAKEREHALLI" ,"BANGALORE", 550000);

INSERT INTO BRANCH VALUES("CANARA J C ROAD", "BANGALORE", 3000000),
("CANARA-SYNDICATE MANIPAL","MANIPAL",2000000),
("CANARA K M MARG","UDUPI",100000),
("CANARA PAHARGANJ","DELHI",200000),
("CANARA LAJPATHNAGAR","DELHI",300000);

INSERT INTO ACCOUNTS VALUES(1234602, "SBI HOSAKEREHALLI", 5000),
(1234603, "SBI VIJAY NAGAR", 5000),
(1234604, "SBI JAYANAGAR", 5000),
(1234605, "SBI RAJAJI NAGAR", 10000),
(1234503, "SBI VIJAY NAGAR", 40000),
(1234504, "SBI PD NAGAR", 4000);

INSERT INTO ACCOUNTS VALUES(282577, "CANARA J C ROAD", 15000),
(235887, "CANARA J C ROAD", 25000),
(367733,"CANARA J C ROAD",56300),
(462822,"CANARA J C ROAD",23500),
(127298,"CANARA-SYNDICATE MANIPAL", 13000),
(877373,"CANARA-SYNDICATE MANIPAL",19000),
(122933,"CANARA-SYNDICATE MANIPAL",16770),
(544556,"CANARA K M MARG",12000),
(896565,"CANARA K M MARG",12300),
(453433,"CANARA PAHARGANJ",67000),
(453462,"CANARA PAHARGANJ", 34000),
(232377,"CANARA LAJPATHNAGAR", 12000),
(655665,"CANARA LAJPATHNAGAR", 23000);

INSERT INTO CUSTOMER VALUES(1234602,"KEZAR", "M G ROAD", "BANGALORE"),
(1234603,"LAL KRISHNA" ,"ST MKS ROAD" ,"BANGALORE"),
(1234604,"RAHUL" ,"AUGSTEN ROAD" ,"BANGALORE"),
(1234605,"LALLU" ,"V S ROAD" ,"BANGALORE"),
(1234503,"FAIZAL" ,"RESEDENCY ROAD" ,"BANGALORE"),
(1234504,"RAJEEV" ,"DICKNSN ROAD" ,"BANGALORE");

INSERT INTO CUSTOMER VALUES(282577,"KRISHNA","VIJAYNAGAR","BANGALORE"),
(235887,"ANIRUDH","BANASHANKARI 5TH STAGE","BANGALORE"),
(367733,"CHIRANTH","HOSAHALLI 5TH MAIN","BANGALORE"),
(462822,"MAITHILI","RAJAJINAGAR 4TH BLOCK","BANGALORE"),
(127298,"SAHANA","GANDHI ROAD","MANIPAL"),
(877373,"SARIKA","KASTURBA ROAD","MANIPAL"),
(122933,"SANJAY","PAI MARG","MANIPAL"),
(544556,"SHREYA","NEW THARAGUPET","UDUPI"),
(896565,"UDISHA","COURT ROAD","UDUPI"),
(453433,"SHAMBHAVI","KAROLBAGH","DELHI"),
(453462,"PRANAV","PAHARGANJ","DELHI"),
(655665,"VISHVESH","LAJPATHNAGAR","DELHI"),
(232377,"VAISHAK","LAJPATHNAGAR","DELHI");


INSERT INTO LOAN VALUES(10011 ,"SBI JAYANAGAR" ,10000),
(10012 ,"SBI VIJAY NAGAR", 5000),
(10013 ,"SBI HOSAKEREHALLI", 20000),
(10014 ,"SBI PD NAGAR" ,15000),
(10015 ,"SBI RAJAJI NAGAR" ,25000);

INSERT INTO BORROWER VALUES("KEZAR", 10011),
("LAL KRISHNA", 10012),
("RAHUL", 10013),
("LALLU", 10014),
("LAL KRISHNA" ,10015);

CREATE TABLE DEPOSITORS(ACC_NO INT, CUST_NAME VARCHAR(30), FOREIGN KEY(ACC_NO) REFERENCES ACCOUNTS(ACC_NO) ON DELETE CASCADE, FOREIGN KEY(CUST_NAME) REFERENCES CUSTOMER(CUST_NAME) ON DELETE CASCADE);

INSERT INTO DEPOSITORS VALUES(1234602, "KEZAR"),
(1234603, "LAL KRISHNA"),
(1234604,"RAHUL"),
(1234605,"LALLU"),
(1234503,"FAIZAL"),
(1234504,"RAJEEV");

INSERT INTO DEPOSITORS VALUES(282577,"KRISHNA"),
(235887,"ANIRUDH"),
(367733,"CHIRANTH"),
(462822,"MAITHILI"),
(127298,"SAHANA"),
(877373,"SARIKA"),
(122933,"SANJAY"),
(544556,"SHREYA"),
(896565,"UDISHA"),
(453433,"SHAMBHAVI"),
(453462,"PRANAV"),
(655665,"VISHVESH"),
(232377,"VAISHAK");
SELECT CUST_NAME FROM DEPOSITORS D, ACCOUNTS A WHERE D.ACC_NO = A.ACC_NO AND A.BRANCH_NAME = "SBI VIJAY NAGAR" GROUP BY D.CUST_NAME HAVING COUNT(A.ACC_NO)>=2;

SELECT D.CUST_NAME FROM ACCOUNTS A,BRANCH B,DEPOSITORS D WHERE B.BRANCH_NAME=A.BRANCH_NAME AND A.ACC_NO=D.ACC_NO AND
B.BRANCH_CITY='BANGALORE'
GROUP BY D.CUST_NAME
HAVING COUNT(DISTINCT B.BRANCH_NAME)=(SELECT COUNT(BRANCH_NAME)
                FROM BRANCH
                WHERE BRANCH_CITY='BANGALORE');
#DONT EXECUTE THE FOLLOWING STATEMENT UNLESS NEW RECORDS ARE ADDED                
DELETE FROM ACCOUNTS WHERE BRANCH_NAME IN(SELECT BRANCH_NAME FROM BRANCH WHERE BRANCH_CITY='UDUPI');

