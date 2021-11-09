--Assignment-9
SELECT * FROM COURSE WHERE CourseID LIKE 'ISM%';


SELECT Q.CourseID, C.CourseName FROM QUALIFIED Q
JOIN FACULTY F ON Q.FacultyID = F.FacultyID
JOIN COURSE C ON Q.CourseID = C.CourseID
WHERE FacultyName = 'Berndt';

SELECT r.StudentID, ST.StudentName, r.SectionNo, s.CourseID FROM REGISTRATION R
JOIN SECTION S ON R.SectionNo = S.SectionNo
JOIN STUDENT ST ON R.StudentID = ST.StudentID
WHERE S.CourseID = 'ISM 4212' and r.SectionNo = 2714;

SELECT Q.FacultyID, F.FacultyName FROM QUALIFIED Q
JOIN FACULTY F ON Q.FacultyID = F.FacultyID
WHERE Q.CourseID = 'ISM 3113';

--3
SELECT Q.FacultyID, F.FacultyName FROM QUALIFIED Q
JOIN FACULTY F ON Q.FacultyID = F.FacultyID
WHERE Q.CourseID = 'ISM 3113' AND Q.CourseID <> 'ISM 4930';

SELECT COUNT(*) as Student_Count FROM REGISTRATION R
WHERE r.Semester = 'I-2008' and r.SectionNo = 2714;

SELECT COUNT(*) as Student_Count FROM REGISTRATION R
JOIN SECTION S ON R.SectionNo = S.SectionNo
WHERE r.Semester = 'I-2008' and S.CourseID = 'ISM 3113';



SELECT [emp_fname] ,[emp_lname], [dept_name], [location], w.[enter_date], [job],[project_name],[budget]
FROM [dbo].[employee] e 
JOIN [dbo].[department] d on e.dept_no = d.dept_no
LEFT JOIN  [dbo].[works_on] w on e.emp_no = w.emp_no
LEFT JOIN [dbo].[project] p on w.[project_no] = p.[project_no]
WHERE e.dept_no = 'D2'
--d.dept_name ='Finance' /* we can use where clause on dept name as well */