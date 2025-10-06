use studentdata;

CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    DateOfBirth DATE,
    Email VARCHAR(150) UNIQUE,
    Phone VARCHAR(20),
    Address VARCHAR(255),
    EnrollmentDate DATE
);

CREATE TABLE Instructors (
    InstructorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Email VARCHAR(150) UNIQUE,
    Phone VARCHAR(20),
    HireDate DATE,
    Department VARCHAR(100)
);

CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(150),
    CourseCode VARCHAR(50) UNIQUE,
    Credits INT,
    InstructorID INT,
    FOREIGN KEY (InstructorID) REFERENCES Instructors(InstructorID)
);

CREATE TABLE Lessons (
    LessonID INT PRIMARY KEY AUTO_INCREMENT,
    CourseID INT,
    LessonTitle VARCHAR(200),
    LessonDate DATE,
    DurationMinutes INT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

CREATE TABLE Enrollments (
    EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    UNIQUE(StudentID, CourseID) 
);

CREATE TABLE Grades (
    GradeID INT PRIMARY KEY AUTO_INCREMENT,
    EnrollmentID INT,
    Grade CHAR(2),
    GradeDate DATE,
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID)
);

CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY AUTO_INCREMENT,
    LessonID INT,
    StudentID INT,
    Status ENUM('Present','Absent','Late'),
    Remarks VARCHAR(255),
    FOREIGN KEY (LessonID) REFERENCES Lessons(LessonID),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    UNIQUE(LessonID, StudentID) 
);
