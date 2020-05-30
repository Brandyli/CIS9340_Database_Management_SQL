• STUDENT(SSN, SNAME, MAJOR, DOB, ADDRESS)
• COURSE(CID, CNAME, CREDIT)
• ENROLLED(SSN, CID, GRADE)
• FACULTY(SSN, NAME, DOB)
• TEACHING(FACULTYSSN, CID)
• PREQ(CID, PREREQUISITECID, PASSINGGRADE)

A. (10 points) Write a series of SQL statements for creating the university database completely.
Each statement should end with a semicolon. The statements need to be in a proper order, so
the foreign key referent exists before a foreign key is declared. Please use appropriate data
types.

CREATE TABLE student
(SSN CHAR (9),
SNAME CHAR(15),
MAJOR CHAR(15),
DOB CHAR(9),
ADDRESS CHAR(35);
CREATE TABLE course
(CID CHAR(9),
CNAME CHAR(15),
CREDIT CHAR(16);
CREATE TABLE enrolled
(SSN CHAR (9),
CID CHAR(9),
GRADE CHAR(2);
CREATE TABLE faculty
(SSN CHAR (9),
NAME CHAR(15),
DOB CHAR(9);
CREATE TABLE teaching
(FACULTYSSN CHAR (9),
CID CHAR(9);

CREATE TABLE preq
(CID CHAR (9),
PREREQUISITECID CHAR(15),
PASSINGGRADE CHAR(2);
Alter table enrolled
add foreign key(ssn) references student(ssn);
Alter table enrolled
add foreign key(cid) references course(cid);
Alter table teaching
add foreign key(ssn) references faculty(ssn);
Alter table teaching
add foreign key(cid) references course(cid);
Alter table preq
add foreign key(cid) references course(cid);
• STUDENT(SSN, SNAME, MAJOR, DOB, ADDRESS)
• COURSE(CID, CNAME, CREDIT)
• ENROLLED(SSN, CID, GRADE)
• FACULTY(SSN, NAME, DOB)
• TEACHING(FACULTYSSN, CID)
• PREQ(CID, PREREQUISITECID, PASSINGGRADE)
INSERT INTO student
VALUES
(&#39;201710170&#39;,&#39;eddy&#39;,&#39;education&#39;, 10172017,’1370888rdflushing’);
INSERT INTO course
VALUES
(&#39;9340&#39;,&#39;sql&#39;,&#39;3&#39;);
INSERT INTO enrolled
VALUES
(&#39;201710170&#39;,&#39;9340&#39;,&#39;99&#39;);
INSERT INTO faculty
VALUES
(&#39;199010170&#39;,&#39;wang&#39;,&#39;11031990&#39;);
INSERT INTO teaching
VALUES
(&#39;199010170&#39;,&#39;wang&#39;,&#39;9340&#39;);
INSERT INTO preo
VALUES

(&#39;9340,&#39;9000&#39;,&#39;60&#39;);
B. (8 points) What are the names of students who enrolled in a course without enrolling in that
course’s prerequisite?

SELECT sname
From student s
Where prerequisitecid not in (
Select prerequisitecid
From student s, course c, enrolled e, preq p
Where s.ssn=e.ssn and
c.cid=e.cid and
p.prerequisitecid= s.cid);
C. (5 points) What is the most popular major?
Select top1 major, count(major)
From student
Group by major
Order by count(major) desc;
D. (5 points) Retrieve a summary: for each prerequisite course id, show the number of courses
that require it as a prerequisite course.
SELECT p.cid, count(p.cid)
From preq p;
E. (6 points) What are the names of courses that have at least two prerequisites?
SELECT cname, count(p.prerequisitecid)
From course c, preq p
Where c.cid=p.cid
Group by cname
Having count(p.prerequisitecid) &gt;=2;
F. (6 points) What are the names of courses that have less than five students enrolled in?
SELECT cname
From course c, student s, enrolled e
Where s.ssn=e.ssn and
c.cid=e.cid and
Having count(ssn) &lt;=5;

Select cname
From course
Where cid in(
Select course.cid
From enrolled
Group by cid
Having count(ssn)&lt;=5);
G. (8 points) What are the names of faculties who teach a course and also its prerequisite
course?
SELECT name
From faculty f, teaching t1, teaching t2 preq p,
Where f.ssn=t.facultyssn and
T1.cid=p.cid and
T2.cid=p. prerequisitecid and
T1.ssn=t2.ssn;
