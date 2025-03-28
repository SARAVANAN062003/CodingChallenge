use careerhub;
--question 1,2,3
CREATE TABLE Companies (
    CompanyID INT PRIMARY KEY,
    CompanyName VARCHAR(255) NOT NULL,
    Location VARCHAR(255) NOT NULL
);

CREATE TABLE Jobs (
    JobID INT PRIMARY KEY,
    CompanyID INT,
    JobTitle VARCHAR(255) NOT NULL,
    JobDescription TEXT NOT NULL,
    JobLocation VARCHAR(255) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL,
    JobType VARCHAR(50) NOT NULL,
    PostedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CompanyID) REFERENCES Companies(CompanyID)
);

CREATE TABLE Applicants (
    ApplicantID INT PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Phone VARCHAR(20) NOT NULL,
    Resume TEXT NOT NULL
);

CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY,
    JobID INT,
    ApplicantID INT,
    ApplicationDate DATETIME DEFAULT GETDATE(),
    CoverLetter TEXT NOT NULL,
    FOREIGN KEY (JobID) REFERENCES Jobs(JobID),
    FOREIGN KEY (ApplicantID) REFERENCES Applicants(ApplicantID)
);

-- Insert data into Companies
INSERT INTO Companies (CompanyID, CompanyName, Location) VALUES
(1, 'Google', 'California'),
(2, 'Microsoft', 'Washington'),
(3, 'Amazon', 'Seattle'),
(4, 'Facebook', 'California'),
(5, 'Apple', 'California'),
(6, 'Tesla', 'Texas'),
(7, 'IBM', 'New York'),
(8, 'Netflix', 'California'),
(9, 'Uber', 'San Francisco'),
(10, 'Adobe', 'California');

-- Insert data into Jobs
INSERT INTO Jobs (JobID, CompanyID, JobTitle, JobDescription, JobLocation, Salary, JobType, PostedDate) VALUES
(1, 1, 'Software Engineer', 'Develop web applications.', 'California', 120000.00, 'Full-time', GETDATE()),
(2, 2, 'Data Scientist', 'Analyze large datasets.', 'Washington', 115000.00, 'Full-time', GETDATE()),
(3, 3, 'Product Manager', 'Manage software products.', 'Seattle', 110000.00, 'Full-time', GETDATE()),
(4, 4, 'UI/UX Designer', 'Design user interfaces.', 'California', 105000.00, 'Full-time', GETDATE()),
(5, 5, 'DevOps Engineer', 'Maintain cloud infrastructure.', 'California', 130000.00, 'Full-time', GETDATE()),
(6, 6, 'Electrical Engineer', 'Work on electric vehicles.', 'Texas', 125000.00, 'Full-time', GETDATE()),
(7, 7, 'Cybersecurity Analyst', 'Ensure network security.', 'New York', 95000.00, 'Full-time', GETDATE()),
(8, 8, 'Backend Developer', 'Develop backend APIs.', 'California', 110000.00, 'Full-time', GETDATE()),
(9, 9, 'Mobile Developer', 'Develop mobile apps.', 'San Francisco', 105000.00, 'Full-time', GETDATE()),
(10, 10, 'AI Engineer', 'Work on AI models.', 'California', 135000.00, 'Full-time', GETDATE());

-- Insert data into Applicants
INSERT INTO Applicants (ApplicantID, FirstName, LastName, Email, Phone, Resume) VALUES
(1, 'John', 'Doe', 'john.doe@example.com', '1234567890', 'Experienced software developer'),
(2, 'Jane', 'Smith', 'jane.smith@example.com', '1234567891', 'Data scientist with 5 years of experience'),
(3, 'Robert', 'Brown', 'robert.brown@example.com', '1234567892', 'Product manager with a strong background in Agile'),
(4, 'Emily', 'Davis', 'emily.davis@example.com', '1234567893', 'UI/UX designer with 3 years of experience'),
(5, 'Michael', 'Johnson', 'michael.johnson@example.com', '1234567894', 'DevOps engineer skilled in AWS'),
(6, 'Sarah', 'Miller', 'sarah.miller@example.com', '1234567895', 'Electrical engineer specialized in battery tech'),
(7, 'David', 'Wilson', 'david.wilson@example.com', '1234567896', 'Cybersecurity expert with hands-on experience'),
(8, 'Laura', 'Moore', 'laura.moore@example.com', '1234567897', 'Backend developer proficient in Python'),
(9, 'James', 'Taylor', 'james.taylor@example.com', '1234567898', 'Mobile developer with expertise in Flutter'),
(10, 'Sophia', 'Anderson', 'sophia.anderson@example.com', '1234567899', 'AI engineer working with deep learning models');

-- Insert data into Applications
INSERT INTO Applications (ApplicationID, JobID, ApplicantID, ApplicationDate, CoverLetter) VALUES
(1, 1, 1, GETDATE(), 'I am excited to apply for the Software Engineer position.'),
(2, 2, 2, GETDATE(), 'I have experience in machine learning and analytics.'),
(3, 3, 3, GETDATE(), 'I am a great fit for this role due to my experience in product management.'),
(4, 4, 4, GETDATE(), 'I love designing user-friendly applications.'),
(5, 5, 5, GETDATE(), 'I have extensive experience in DevOps and cloud computing.'),
(6, 6, 6, GETDATE(), 'I am interested in working on electric vehicles.'),
(7, 7, 7, GETDATE(), 'I specialize in penetration testing and network security.'),
(8, 8, 8, GETDATE(), 'I have developed multiple scalable backend systems.'),
(9, 9, 9, GETDATE(), 'I am proficient in React Native and Flutter.'),
(10, 10, 10, GETDATE(), 'I have worked with AI models and deep learning frameworks.');

--question 5

select count(A.ApplicantID),j.jobTitle from Applications a
join Jobs j
on j.jobId=a.jobId group by JobTitle;

--question 6

select j.JobTitle,c.companyName,c.Location,j.salary
from Jobs j
join Companies c
on j.CompanyID=c.companyId
where j.Salary between 10000 and 120000
order by salary asc;

--question 7

select j.jobtitle,
c.companyName,
a.applicationDate
from applications a
join jobs j on j.jobId=A.jobId
join companies c on c.CompanyId=j.companyId
where a.applicantId=2;

--question 8

select j.jobId,c.companyName,Avg(j.salary) as avgsalary from jobs j
join  companies c on c.companyId=j.companyId WHERE j.Salary > 0 group by companyName,jobId ORDER BY avg(salary),jobid DESC;


--question 9

select top 1 c.companyName,count(j.jobId) as jobcount
from companies c
left join jobs j on c.companyId=j.companyId group by companyName order by jobcount desc;

--question 10

select a.ApplicantID,a.firstName from applicants a
join companies c on c.location='texas' ;

--question 11

select distinct JobTitle from Jobs where salary between 60000 and 800000; 

--question 12

select j.jobid from jobs j
left join Applications a
on j.jobId=a.jobId
where a.jobId is null;

--question 13

select a.applicantID,c.CompanyName,j.jobTitle 
from applications a
join jobs j on j.JobID=a.jobID
join companies c on c.companyId=j.companyId;

--question 14

select c.companyName, COUNT(j.jobId) AS jobCount
FROM companies c
left join jobs j ON j.companyId = c.companyId
GROUP BY c.companyName;

--question 15

select a.applicationid,a.jobId 
from Applications a
left join jobs j on j.jobId=a.jobId;

--question 16

select c.companyName 
from companies c
join jobs j on j.CompanyID=c.CompanyID
where j.salary>(select AVG(salary) from jobs );

--question 17

select Applicantid, concat(firstname,lastname) as fullname from applicants;

--question 18

select jobId, jobTitle FROM jobs 
WHERE jobTitle IN ('Frontend Developer', 'Software Engineer');

---question 19

select a.applicantId, a.firstName, j.jobId, j.jobTitle, c.companyName
FROM applicants a
left join applications app ON a.applicantId = app.applicantId
right join jobs j ON app.jobId = j.jobId
left join companies c ON j.companyId = c.companyId;

--question 20

select a.applicantId, a.firstName, c.companyId, c.companyName
from applicants a
cross join companies c
where c.location = 'texas' ;








































































	



