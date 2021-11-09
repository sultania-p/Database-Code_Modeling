--create Student
CREATE TABLE STUDENT 
(
	StudentID int not null,
	StudentName nvarchar(25)
	CONSTRAINT Student_PK Primary Key (StudentID)
);

--create Faculty
CREATE TABLE FACULTY
(
	FacultyID int not null,
	FacultyName nvarchar(25)
	CONSTRAINT Faculty_PK Primary Key (FacultyID)
);

--create Course
CREATE TABLE COURSE
(
	CourseID varchar(8) not null,
	CourseName nvarchar(15)
	CONSTRAINT Course_PK Primary Key (CourseID)
);

--create Qualified
CREATE TABLE QUALIFIED
(
	FacultyID int not null,
	CourseID varchar(8) not null,
	DateQualified Datetime
	CONSTRAINT Qualified_PK Primary Key (FacultyID, CourseID)
	/* foreign key references */
	CONSTRAINT Qualified_FK1 foreign key (FacultyID) references FACULTY(FacultyID),
	CONSTRAINT Qualified_FK2 foreign key (CourseID) references COURSE(CourseID)
);

--create Section
CREATE TABLE SECTION
(
	SectionNo int not null,
	Semester varchar(7),
	CourseID varchar(8) not null
	CONSTRAINT Section_PK Primary Key (SectionNo)
	/* foreign key references */
	CONSTRAINT Section_FK1 foreign key (CourseID) references COURSE(CourseID),
);

--create Registration
CREATE TABLE REGISTRATION
(
	StudentID int not null,
	SectionNo int not null,
	Semester varchar(7)
	CONSTRAINT Registration_PK Primary Key (StudentID, SectionNo, Semester)
	/* foreign key references */
	CONSTRAINT Registration_FK1 foreign key (StudentID) references STUDENT(StudentID),
	CONSTRAINT Registration_FK2 foreign key (SectionNo) references SECTION(SectionNo),
);

------------------------

/* Select scripts */
select * from [dbo].[STUDENT];
select * from [dbo].[FACULTY];
select * from [dbo].[COURSE];
select * from [dbo].[QUALIFIED];
select * from [dbo].[SECTION];
select * from [dbo].[REGISTRATION];

-------------------------

/* Insert scripts */
INSERT INTO STUDENT VALUES (38214,'Letersky');
INSERT INTO STUDENT VALUES (54907,'Altvater');
INSERT INTO STUDENT VALUES (66324,'Aiken');
INSERT INTO STUDENT VALUES (70542,'Marra');

INSERT INTO FACULTY VALUES (2143,'Birkin');
INSERT INTO FACULTY VALUES (3467,'Berndt');
INSERT INTO FACULTY VALUES (4756,'Collins');

INSERT INTO COURSE VALUES ('ISM 3113','Syst Analysis');
INSERT INTO COURSE VALUES ('ISM 3112','Syst Design');
INSERT INTO COURSE VALUES ('ISM 4212','Database');
INSERT INTO COURSE VALUES ('ISM 4930','Networking');

INSERT INTO QUALIFIED VALUES (2143,'ISM 3112','1988-09-01');
INSERT INTO QUALIFIED VALUES (2143,'ISM 3113','1988-09-01');
INSERT INTO QUALIFIED VALUES (3467,'ISM 4212','1995-09-01');
INSERT INTO QUALIFIED VALUES (3467,'ISM 4930','1986-09-01');
INSERT INTO QUALIFIED VALUES (4756,'ISM 3113','1991-09-01');
INSERT INTO QUALIFIED VALUES (4756,'ISM 3112','1991-09-01');

INSERT INTO SECTION VALUES (2712,'I-2008','ISM 3113');
INSERT INTO SECTION VALUES (2713,'I-2008','ISM 3113');
INSERT INTO SECTION VALUES (2714,'I-2008','ISM 4212');
INSERT INTO SECTION VALUES (2715,'I-2008','ISM 4930');

INSERT INTO REGISTRATION VALUES (38214,2714,'I-2008');
INSERT INTO REGISTRATION VALUES (54907,2714,'I-2008');
INSERT INTO REGISTRATION VALUES (54907,2715,'I-2008');
INSERT INTO REGISTRATION VALUES (66324,2713,'I-2008');

---
/* Create view */
CREATE VIEW [VIEW_Student_Registration]
AS
(
	SELECT R.StudentID, S.StudentName
	from REGISTRATION R join STUDENT S on R.StudentID=S.StudentID
);

SELECT * FROM [VIEW_Student_Registration];

ALTER TABLE SECTION
ADD CONSTRAINT Section_FK1 foreign key (CourseID) references COURSE(CourseID);

ALTER TABLE STUDENT ADD Class varchar(20); 

SELECT * FROM STUDENT;

DROP TABLE REGISTRATION;

SELECT * FROM REGISTRATION;

ALTER TABLE FACULTY ALTER COLUMN FacultyName varchar(40);

/* Method-1 */
INSERT INTO STUDENT (StudentID, StudentName) VALUES (65798, 'Lopez');

/* Method-2 */
INSERT INTO STUDENT VALUES (65798, 'Lopez');

DELETE FROM STUDENT WHERE StudentID = 65798;


SELECT * FROM [DBO].[STUDENT] WHERE StudentID = 65798;



ALTER TABLE COURSE ALTER COLUMN CourseName varchar(40);

UPDATE COURSE
SET CourseName = 'Introduction to Relational Databases'
WHERE CourseID = 'ISM 4212';

UPDATE COURSE
SET CourseName = 'Database'
WHERE CourseID = 'ISM 4212';

SELECT * FROM COURSE WHERE COURSEID = 'ISM 4212';

SELECT * FROM STUDENT WHERE StudentID < 50000;

SELECT FacultyName FROM FACULTY WHERE FacultyID = 4756;


SELECT * FROM SECTION;


/* Method-1 */
SELECT TOP 1 SectionNo FROM SECTION WHERE Semester = 'I-2008' ORDER BY SectionNo ASC;

/* Method-2 */
SELECT SectionNo from 
(
	SELECT SectionNo, RANK() OVER (PARTITION BY SEMESTER ORDER BY SectionNo) as RN FROM SECTION
	where Semester = 'I-2008'
) SQ where RN = 1;


SELECT COUNT(*) as Enrollment_Count FROM REGISTRATION WHERE Semester = 'I-2008' and SectionNo = 2714;

SELECT * FROM QUALIFIED;

SELECT * FROM QUALIFIED WHERE DateQualified >= '1993-01-01';

Update QUALIFIED
set DateQualified = '1996-09-01'
where FacultyID = 3467 and CourseID = 'ISM 4930';



SELECT SQ.StudentID, S.StudentName from
(
	SELECT R.StudentID, --C.CourseID, C.CourseName,
	COUNT(*) Subject_Count FROM REGISTRATION R
	JOIN SECTION S ON R.SectionNo = S.SectionNo and R.Semester = S.Semester
	JOIN COURSE C ON S.CourseID = C.CourseID
	WHERE C.CourseName in ('Networking','Database')
	GROUP BY R.StudentID
)
SQ JOIN STUDENT S ON SQ.StudentID = S.StudentID where SQ.Subject_Count >1;

SELECT DISTINCT Q.FacultyID, F.FacultyName FROM QUALIFIED Q 
JOIN COURSE C on C.CourseID = Q.CourseID
JOIN FACULTY F ON Q.FacultyID = F.FacultyID
where CourseName not in ('Syst Analysis','Syst Design')

