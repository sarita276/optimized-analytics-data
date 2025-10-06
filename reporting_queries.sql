use studentdata;
-- top 5 most active student
SELECT 
    s.StudentID,
    s.FirstName, s. LastName,
    COUNT(DISTINCT e.EnrollmentID) AS TotalEnrollments,
    COUNT(DISTINCT a.AttendanceID) AS TotalAttendances,
    (COUNT(DISTINCT e.EnrollmentID) + COUNT(DISTINCT a.AttendanceID)) AS ActivityScore
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
LEFT JOIN Attendance a ON s.StudentID = a.StudentID
GROUP BY s.StudentID,s.FirstName, s. LastName
ORDER BY ActivityScore DESC
LIMIT 5;

-- most enrolled course
SELECT 
    c.CourseID,
    c.CourseName,
    COUNT(e.EnrollmentID) AS TotalEnrollments
FROM Courses c
JOIN Enrollments e 
    ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName
ORDER BY TotalEnrollments DESC
LIMIT 5;

-- percentage of enrolled student who have completed all modules
SELECT 
    c.CourseID,
    c.CourseName,
    COUNT(DISTINCT e.StudentID) AS TotalEnrolled,
    SUM(CASE 
            WHEN NOT EXISTS (
                SELECT 1
                FROM Lessons l
                LEFT JOIN Attendance a 
                    ON l.LessonID = a.LessonID 
                   AND a.StudentID = e.StudentID
                   AND a.Status = 'Present'
                WHERE l.CourseID = c.CourseID
                GROUP BY l.LessonID
                HAVING COUNT(a.AttendanceID) = 0
            )
            THEN 1 ELSE 0 END
       ) AS StudentsCompleted,
    ROUND(
        SUM(CASE 
                WHEN NOT EXISTS (
                    SELECT 1
                    FROM Lessons l
                    LEFT JOIN Attendance a 
                        ON l.LessonID = a.LessonID 
                       AND a.StudentID = e.StudentID
                       AND a.Status = 'Present'
                    WHERE l.CourseID = c.CourseID
                    GROUP BY l.LessonID
                    HAVING COUNT(a.AttendanceID) = 0
                )
                THEN 1 ELSE 0 END
        ) * 100.0 / COUNT(DISTINCT e.StudentID), 2
    ) AS CompletionPercentage
FROM Courses c
JOIN Enrollments e ON c.CourseID = e.CourseID
GROUP BY c.CourseID, c.CourseName;

-- instructor performance
SELECT 
    i.InstructorID,
    i.FirstName,
    i.LastName,
    ROUND(AVG(g.Grade), 2) AS AvgGrade,
    RANK() OVER (ORDER BY AVG(g.Grade) DESC) AS InstructorRank
FROM Instructors i
JOIN Courses c ON i.InstructorID = c.InstructorID
JOIN Enrollments e ON c.CourseID = e.CourseID
JOIN Grades g ON e.EnrollmentID = g.EnrollmentID
GROUP BY i.InstructorID,  i.FirstName, i.LastName
ORDER BY AvgGrade DESC;

-- student attendance report
SELECT 
    s.StudentID,
    s.FirstName,
    s.LastName,
    c.CourseID,
    c.CourseName,
    l.LessonID,
    l.LessonDate,
    a.Status,
    a.Remarks
FROM Students s
JOIN Attendance a ON s.StudentID = a.StudentID
JOIN Lessons l ON a.LessonID = l.LessonID
JOIN Courses c ON l.CourseID = c.CourseID
WHERE s.StudentID = 5
ORDER BY c.CourseName, l.LessonDate;