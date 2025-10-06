use studentdata;

-- Fetch all courses a student is enrolled in
SELECT s.StudentID, s.FirstName, s. LastName, c.CourseID, c.CourseName
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE s.StudentID = 1;  

-- Fetch a student’s grade for a specific course
SELECT s.StudentID, s.FirstName, s. LastName, c.CourseName, g.Grade
FROM Grades g
JOIN Enrollments e ON g.EnrollmentID = e.EnrollmentID
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE s.StudentID = 15     
  AND c.CourseID = 15;     
  
-- Fetch attendance record for a student in a course
SELECT s.StudentID, s.FirstName, s. LastName, c.CourseName, l.LessonTitle, a.Status, a.Remarks
FROM Attendance a
JOIN Lessons l ON a.LessonID = l.LessonID
JOIN Courses c ON l.CourseID = c.CourseID
JOIN Students s ON a.StudentID = s.StudentID
WHERE s.StudentID = 1    
  AND c.CourseID = 5;     

EXPLAIN
SELECT s.StudentID, s.FirstName, s. LastName, c.CourseID, c.CourseName
FROM Enrollments e
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE s.StudentID = 1;


EXPLAIN
SELECT s.StudentID, s.FirstName, s. LastName, c.CourseName, g.Grade
FROM Grades g
JOIN Enrollments e ON g.EnrollmentID = e.EnrollmentID
JOIN Students s ON e.StudentID = s.StudentID
JOIN Courses c ON e.CourseID = c.CourseID
WHERE s.StudentID = 15
  AND c.CourseID = 15;


EXPLAIN
SELECT s.StudentID,s.FirstName, s. LastName, c.CourseName, l.LessonTitle , a.Status, a.Remarks
FROM Attendance a
JOIN Lessons l ON a.LessonID = l.LessonID
JOIN Courses c ON l.CourseID = c.CourseID
JOIN Students s ON a.StudentID = s.StudentID
WHERE s.StudentID = 1
  AND c.CourseID = 5;

-- index creation
CREATE INDEX idx_students_name ON Students(StudentName);

CREATE INDEX idx_courses_name ON Courses(CourseName);

CREATE INDEX idx_instructors_name ON Instructors(InstructorName);

CREATE INDEX idx_enrollments_student ON Enrollments(StudentID);
CREATE INDEX idx_enrollments_course ON Enrollments(CourseID);

CREATE INDEX idx_grades_enrollment ON Grades(EnrollmentID);

CREATE INDEX idx_lessons_course ON Lessons(CourseID);

CREATE INDEX idx_attendance_student ON Attendance(StudentID);
CREATE INDEX idx_attendance_lesson ON Attendance(LessonID);
CREATE INDEX idx_attendance_student_lesson ON Attendance(StudentID, LessonID);
