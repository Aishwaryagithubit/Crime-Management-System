DROP TABLE VolunteerHour CASCADE CONSTRAINTS;
DROP TABLE VolunteerSkill CASCADE CONSTRAINTS;
DROP TABLE TaskSkill CASCADE CONSTRAINTS;
DROP TABLE Skill CASCADE CONSTRAINTS;
DROP TABLE Task CASCADE CONSTRAINTS;
DROP TABLE Equipment CASCADE CONSTRAINTS;
DROP TABLE CrimeProjectSupport CASCADE CONSTRAINTS;
DROP TABLE VolunteerProject CASCADE CONSTRAINTS;
DROP TABLE Volunteer CASCADE CONSTRAINTS;
DROP TABLE Project CASCADE CONSTRAINTS;
DROP TABLE Evidence CASCADE CONSTRAINTS;
DROP TABLE CrimeOfficer CASCADE CONSTRAINTS;
DROP TABLE Crime CASCADE CONSTRAINTS;



-- CRIME
CREATE TABLE Crime (
  Crime_id    VARCHAR2(10) NOT NULL,
  CrimeCode   NUMBER NOT NULL,
  Type        VARCHAR2(50) NOT NULL,
  CrimeDate   DATE NOT NULL,
  Location    VARCHAR2(50) NOT NULL,
  Status      VARCHAR2(10),
  DateSolved  DATE,
  Person_id   VARCHAR2(10),
  CONSTRAINT pk_crime PRIMARY KEY (Crime_id),
  CONSTRAINT fk_crime_person FOREIGN KEY (Person_id) REFERENCES Person(Person_id)
);

INSERT INTO Crime VALUES ('C001',101,'Fraud',DATE '2025-08-15','Leeds','Open',NULL,'P01');
INSERT INTO Crime VALUES ('C002',102,'Robbery',DATE '2024-07-05','York','Closed',DATE '2024-09-01','P02');
INSERT INTO Crime VALUES ('C003',103,'Burglary',DATE '2023-05-03','Sheffield','Closed',NULL,'P03');
INSERT INTO Crime VALUES ('C004',104,'Fraud',DATE '2025-04-03','Leeds','Open',NULL,'P04');
INSERT INTO Crime VALUES ('C005',105,'Vandalism',DATE '2022-09-03','Leeds','Closed',DATE '2023-09-10','P05');
INSERT INTO Crime VALUES ('C006',106,'Arson',DATE '2024-11-10','Bradford','Open',NULL,'P06');
INSERT INTO Crime VALUES ('C007',107,'Cyber Crime',DATE '2025-01-15','Leeds','Open',NULL,'P07');
INSERT INTO Crime VALUES ('C008',108,'Assault',DATE '2023-12-19','York','Closed',DATE '2024-02-10','P08');


-- CRIMEOFFICER
CREATE TABLE CrimeOfficer (
  Crime_id    VARCHAR2(10) NOT NULL,
  Officer_id  VARCHAR2(10) NOT NULL,
  Role        VARCHAR2(20) NOT NULL,
  AssignDate  DATE NOT NULL,
  CONSTRAINT pk_crimeofficer PRIMARY KEY (Crime_id, Officer_id),
  CONSTRAINT fk_co_crime FOREIGN KEY (Crime_id) REFERENCES Crime(Crime_id),
  CONSTRAINT fk_co_officer FOREIGN KEY (Officer_id) REFERENCES Officer(Officer_id)
);

INSERT INTO CrimeOfficer VALUES ('C001','O1','Investigator',DATE '2025-08-15');
INSERT INTO CrimeOfficer VALUES ('C002','O2','Detective',DATE '2024-07-05');
INSERT INTO CrimeOfficer VALUES ('C003','O3','Detective',DATE '2023-05-03');
INSERT INTO CrimeOfficer VALUES ('C004','O4','Inspector',DATE '2025-04-03');
INSERT INTO CrimeOfficer VALUES ('C005','O5','Inspector',DATE '2022-09-03');
INSERT INTO CrimeOfficer VALUES ('C006','O6','Inspector',DATE '2024-11-10');
INSERT INTO CrimeOfficer VALUES ('C007','O7','Investigator',DATE '2025-01-15');
INSERT INTO CrimeOfficer VALUES ('C008','O8','Detective',DATE '2023-12-19');


-- EVIDENCE
CREATE TABLE Evidence (
  Evidence_id VARCHAR2(10) NOT NULL,
  Type        VARCHAR2(20) NOT NULL,
  Description VARCHAR2(100),
  Crime_id    VARCHAR2(10) NOT NULL,
  CONSTRAINT pk_evidence PRIMARY KEY (Evidence_id),
  CONSTRAINT fk_evidence_crime FOREIGN KEY (Crime_id) REFERENCES Crime(Crime_id)
);

INSERT INTO Evidence VALUES ('EV01','Digital','Fake ID card','C001');
INSERT INTO Evidence VALUES ('EV02','Weapon','Broken glass','C005');
INSERT INTO Evidence VALUES ('EV03','CCTV','Stolen purse','C002');
INSERT INTO Evidence VALUES ('EV04','Photo','Knife found','C003');
INSERT INTO Evidence VALUES ('EV05','Digital','Fake documents','C004');
INSERT INTO Evidence VALUES ('EV06','CCTV','Arson footage','C006');
INSERT INTO Evidence VALUES ('EV07','Digital','Hacked login logs','C007');
INSERT INTO Evidence VALUES ('EV08','Medical','Injury report','C008');

-- PROJECT
CREATE TABLE Project (
  Project_id  VARCHAR2(10) NOT NULL,
  Name        VARCHAR2(50) NOT NULL,
  StartDate   DATE         NOT NULL,
  Ptype       VARCHAR2(20) NOT NULL,
  DateSolved  DATE,
  CONSTRAINT pk_project PRIMARY KEY (Project_id)
);

INSERT INTO Project VALUES ('PT01','Fraud Prevention',DATE '2025-01-01','Prevention',NULL);
INSERT INTO Project VALUES ('PT02','Victim Support',DATE '2024-03-01','Support',DATE '2024-09-01');
INSERT INTO Project VALUES ('PT03','Evidence Review',DATE '2023-01-10','Support',NULL);
INSERT INTO Project VALUES ('PT04','Community Safety',DATE '2025-02-15','Support',NULL);
INSERT INTO Project VALUES ('PT05','Traffic Safety',DATE '2024-08-01','Prevention',NULL);
INSERT INTO Project VALUES ('PT06','Cyber Security Awareness',DATE '2025-03-15','Training',NULL);
INSERT INTO Project VALUES ('PT07','Forensics Upgrade',DATE '2024-11-20','Support',NULL);
INSERT INTO Project VALUES ('PT08','Community Policing',DATE '2023-04-10','Prevention',DATE '2023-12-01');

-- VOLUNTEER
CREATE TABLE Volunteer (
  Volunteer_id VARCHAR2(10) NOT NULL,
  Name         VARCHAR2(50) NOT NULL,
  Role         VARCHAR2(30) NOT NULL,
  Phone        VARCHAR2(20),
  Email        VARCHAR2(50),
  CONSTRAINT pk_volunteer PRIMARY KEY (Volunteer_id)
);

INSERT INTO Volunteer VALUES ('V01','Rimi','Coordinator','982345678','rimi@gmail.com');
INSERT INTO Volunteer VALUES ('V02','Nilu','Trainer','9823765432','nilu@gmail.com');
INSERT INTO Volunteer VALUES ('V03','Siya','Assistant','98768906753','siya@gmail.com');
INSERT INTO Volunteer VALUES ('V04','Aaku','Medical Support','9876547823','aaku@gmail.com');
INSERT INTO Volunteer VALUES ('V05','Rehan','Field Assistant','9871234567','rehan@gmail.com');
INSERT INTO Volunteer VALUES ('V06','Sujata','Data Analyst','9845432132','sujata@gmail.com');
INSERT INTO Volunteer VALUES ('V07','Tina','Community Helper','9867543123','tina@gmail.com');

-- VOLUNTEERPROJECT
CREATE TABLE VolunteerProject (
  Volunteer_id VARCHAR2(10) NOT NULL,
  Project_id   VARCHAR2(10) NOT NULL,
  Start_Date   DATE         NOT NULL,
  End_Date     DATE,
  Role         VARCHAR2(30),
  CONSTRAINT pk_volunteerproject PRIMARY KEY (Volunteer_id, Project_id),
  CONSTRAINT fk_vp_vol FOREIGN KEY (Volunteer_id) REFERENCES Volunteer(Volunteer_id),
  CONSTRAINT fk_vp_proj FOREIGN KEY (Project_id) REFERENCES Project(Project_id)
);

INSERT INTO VolunteerProject VALUES ('V01','PT01',DATE '2025-01-05',DATE '2025-02-20','Technical');
INSERT INTO VolunteerProject VALUES ('V02','PT02',DATE '2025-02-06',DATE '2025-05-18','Assistant');
INSERT INTO VolunteerProject VALUES ('V03','PT03',DATE '2025-06-09',DATE '2025-07-25','Trainer');
INSERT INTO VolunteerProject VALUES ('V04','PT04',DATE '2025-09-08',DATE '2025-12-03','Field Support');
INSERT INTO VolunteerProject VALUES ('V05','PT06',DATE '2025-03-20',DATE '2025-04-15','Outreach');
INSERT INTO VolunteerProject VALUES ('V06','PT07',DATE '2024-11-25',NULL,'Analyst');
INSERT INTO VolunteerProject VALUES ('V07','PT08',DATE '2023-04-15',DATE '2023-10-01','Community Support');

-- SKILL
CREATE TABLE Skill (
  Skill_id VARCHAR2(10) NOT NULL,
  Name     VARCHAR2(50) NOT NULL,
  CONSTRAINT pk_skill PRIMARY KEY (Skill_id)
);

INSERT INTO Skill VALUES ('SK01','Communication');
INSERT INTO Skill VALUES ('SK02','Technical Analysis');
INSERT INTO Skill VALUES ('SK03','Evidence Handling');
INSERT INTO Skill VALUES ('SK04','First Aid');
INSERT INTO Skill VALUES ('SK05','Report Writing');
INSERT INTO Skill VALUES ('SK06','Investigation Skills');
INSERT INTO Skill VALUES ('SK07','Leadership');
INSERT INTO Skill VALUES ('SK08','Problem Solving');
INSERT INTO Skill VALUES ('SK09','Teamwork');


-- TASK
CREATE TABLE Task (
  Task_id    VARCHAR2(10) NOT NULL,
  Description VARCHAR2(100) NOT NULL,
  Project_id VARCHAR2(10) NOT NULL,
  CONSTRAINT pk_task PRIMARY KEY (Task_id),
  CONSTRAINT fk_task_proj FOREIGN KEY (Project_id) REFERENCES Project(Project_id)
);

INSERT INTO Task VALUES ('T001','Collect witness statement','PT01');
INSERT INTO Task VALUES ('T002','Review CCTV footage','PT02');
INSERT INTO Task VALUES ('T003','Document evidence items','PT03');
INSERT INTO Task VALUES ('T004','Conduct community awareness session','PT04');
INSERT INTO Task VALUES ('T005','Prepare fraud prevention plan','PT05');
INSERT INTO Task VALUES ('T006','Monitor traffic pathways','PT06');
INSERT INTO Task VALUES ('T007','Cybersecurity awareness session','PT06');
INSERT INTO Task VALUES ('T008','First aid training','PT07');
INSERT INTO Task VALUES ('T009','Fire safety drills','PT08');

-- TASKSKILL 
CREATE TABLE TaskSkill (
  Task_id  VARCHAR2(10) NOT NULL,
  Skill_id VARCHAR2(10) NOT NULL,
  skill_level    VARCHAR2(20),
  CONSTRAINT pk_taskskill PRIMARY KEY (Task_id, Skill_id),
  CONSTRAINT fk_ts_task FOREIGN KEY (Task_id) REFERENCES Task(Task_id),
  CONSTRAINT fk_ts_skill FOREIGN KEY (Skill_id) REFERENCES Skill(Skill_id)
);

INSERT INTO TaskSkill VALUES ('T001','SK01','Intermediate');
INSERT INTO TaskSkill VALUES ('T002','SK02','Advanced');
INSERT INTO TaskSkill VALUES ('T003','SK03','Intermediate');
INSERT INTO TaskSkill VALUES ('T004','SK01','Basic');
INSERT INTO TaskSkill VALUES ('T005','SK05','Advanced');
INSERT INTO TaskSkill VALUES ('T006','SK06','Intermediate');
INSERT INTO TaskSkill VALUES ('T007','SK06','Intermediate');
INSERT INTO TaskSkill VALUES ('T008','SK04','Basic');
INSERT INTO TaskSkill VALUES ('T009','SK08','Advanced');

-- VOLUNTEER SKILL
CREATE TABLE VolunteerSkill (
  Volunteer_id VARCHAR2(10) NOT NULL,
  Skill_id     VARCHAR2(10) NOT NULL,
  Trained_Date DATE,
  CONSTRAINT pk_volunteerskill PRIMARY KEY (Volunteer_id, Skill_id),
  CONSTRAINT fk_vs_vol FOREIGN KEY (Volunteer_id) REFERENCES Volunteer(Volunteer_id),
  CONSTRAINT fk_vs_skill FOREIGN KEY (Skill_id) REFERENCES Skill(Skill_id)
);

INSERT INTO VolunteerSkill VALUES ('V01','SK01',DATE '2024-05-12');
INSERT INTO VolunteerSkill VALUES ('V02','SK05',DATE '2024-08-20');
INSERT INTO VolunteerSkill VALUES ('V03','SK02',DATE '2024-09-15');
INSERT INTO VolunteerSkill VALUES ('V04','SK03',DATE '2025-01-10');
INSERT INTO VolunteerSkill VALUES ('V05','SK04',DATE '2025-02-05');
INSERT INTO VolunteerSkill VALUES ('V06','SK06',DATE '2025-03-01');
INSERT INTO VolunteerSkill VALUES ('V07','SK07',DATE '2025-05-10');

-- VOLUNTEER HOUR
CREATE TABLE VolunteerHour (
  Hour_id     VARCHAR2(10) NOT NULL,
  Volunteer_id VARCHAR2(10),
  Project_id   VARCHAR2(10),
  Entry_Date        DATE,
  Hours       NUMBER,
  CONSTRAINT pk_volunteerhour PRIMARY KEY (Hour_id),
  CONSTRAINT fk_vh_vol FOREIGN KEY (Volunteer_id) REFERENCES Volunteer(Volunteer_id),
  CONSTRAINT fk_vh_proj FOREIGN KEY (Project_id) REFERENCES Project(Project_id)
);

INSERT INTO VolunteerHour VALUES ('H001','V01','PT01',DATE '2025-01-10',5);
INSERT INTO VolunteerHour VALUES ('H002','V02','PT02',DATE '2025-02-15',4);
INSERT INTO VolunteerHour VALUES ('H003','V03','PT03',DATE '2025-06-20',6);
INSERT INTO VolunteerHour VALUES ('H004','V04','PT04',DATE '2025-09-15',7);
INSERT INTO VolunteerHour VALUES ('H005','V05','PT01',DATE '2025-02-05',3);
INSERT INTO VolunteerHour VALUES ('H006','V06','PT02',DATE '2025-02-01',5);
INSERT INTO VolunteerHour VALUES ('H007','V07','PT06',DATE '2025-03-15',4);

-- EQUIPMENT
CREATE TABLE Equipment (
  Equipment_id VARCHAR2(10) NOT NULL,
  Name         VARCHAR2(50) NOT NULL,
  Type         VARCHAR2(50),
  Quantity     NUMBER NOT NULL,
  Status       VARCHAR2(20),
  CONSTRAINT pk_equipment PRIMARY KEY (Equipment_id)
);

INSERT INTO Equipment VALUES ('E11','First Aid Kit','Medical',25,'Available');
INSERT INTO Equipment VALUES ('E22','CCTV Camera','Surveillance',9,'Available');
INSERT INTO Equipment VALUES ('E33','Safety Jackets','Protective',50,'Available');
INSERT INTO Equipment VALUES ('E44','Projector','Electronic',6,'Under Repair');
INSERT INTO Equipment VALUES ('E55','Walkie Talkie','Communication',10,'In Use');
INSERT INTO Equipment VALUES ('E66','Laptop','Electronic',15,'Available');
INSERT INTO Equipment VALUES ('E77','Fire Extinguisher','Safety',8,'Available');
INSERT INTO Equipment VALUES ('E88','Megaphone','Communication',5,'In Use');


-- CRIME PROJECT SUPPORT
CREATE TABLE CrimeProjectSupport (
  Crime_id    VARCHAR2(10) NOT NULL,
  Project_id  VARCHAR2(10) NOT NULL,
  Support_type VARCHAR2(50),
  CONSTRAINT pk_cps PRIMARY KEY (Crime_id, Project_id),
  CONSTRAINT fk_cps_crime FOREIGN KEY (Crime_id) REFERENCES Crime(Crime_id),
  CONSTRAINT fk_cps_proj FOREIGN KEY (Project_id) REFERENCES Project(Project_id)
);

INSERT INTO CrimeProjectSupport VALUES ('C001','PT01','Legal aid');
INSERT INTO CrimeProjectSupport VALUES ('C002','PT02','Victim support');
INSERT INTO CrimeProjectSupport VALUES ('C003','PT03','CCTV monitoring');
INSERT INTO CrimeProjectSupport VALUES ('C004','PT04','Victim counseling');
INSERT INTO CrimeProjectSupport VALUES ('C005','PT05','CCTV monitoring');
INSERT INTO CrimeProjectSupport VALUES ('C006','PT06','Technical support');
INSERT INTO CrimeProjectSupport VALUES ('C007','PT07','Equipment support');
INSERT INTO CrimeProjectSupport VALUES ('C008','PT08','Community guidance');