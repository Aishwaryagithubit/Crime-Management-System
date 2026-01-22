CREATE OR REPLACE TRIGGER trg_close_crime 
BEFORE UPDATE OF DateSolved ON Crime 
FOR EACH ROW BEGIN IF :NEW.DateSolved IS NOT NULL THEN 
  :NEW.Status := 'Closed'; 
END IF; 
END; 
 

SELECT Crime_id, Status, DateSolved
FROM Crime
WHERE Crime_id = 'C001';

UPDATE Crime
SET DateSolved = DATE '2025-08-25'
WHERE Crime_id = 'C001';

SELECT Crime_id, Status, DateSolved
FROM Crime
WHERE Crime_id = 'C001';




CREATE OR REPLACE TRIGGER trg_no_evidence_closed_crime
BEFORE INSERT ON Evidence 
FOR EACH ROW DECLARE v_status Crime.Status%TYPE;
BEGIN
   SELECT Status INTO v_status 
   FROM Crime
   WHERE Crime_id = :NEW.Crime_id; 
   IF v_status = 'Closed' THEN 
      RAISE_APPLICATION_ERROR( -20010, 'Cannot add evidence to a closed crime' ); 
    END IF; 
END;
 /

INSERT INTO Evidence
VALUES ('EV90','Digital','Late evidence','C001');


CREATE OR REPLACE TRIGGER trg_skill_match 
AFTER INSERT ON Task 
FOR EACH ROW 
BEGIN
 INSERT INTO VolunteerProject (Volunteer_id, Project_id, Start_Date, Role) 
 SELECT vs.Volunteer_id, :NEW.Project_id, SYSDATE, 'Auto-Assigned'
 FROM VolunteerSkill vs 
 JOIN TaskSkill ts 
 ON vs.Skill_id = ts.Skill_id 
 WHERE ts.Task_id = :NEW.Task_id; 
 END; 
 /
 
INSERT INTO Task VALUES ('T20', 'Cyber Awareness', 'PT01');


SELECT *
FROM VolunteerProject
WHERE Project_id = 'PT01';


CREATE OR REPLACE TRIGGER trg_crime_datesolved
BEFORE INSERT OR UPDATE ON CRIME
FOR EACH ROW
BEGIN
  -- Check if DATESOLVED is today's date
  IF :NEW.DATESOLVED IS NOT NULL AND TRUNC(:NEW.DATESOLVED) <> TRUNC(SYSDATE) THEN
    RAISE_APPLICATION_ERROR(-20002, 'DATESOLVED must be today''s date.');
  END IF;
END;



CREATE OR REPLACE TRIGGER trg_no_duplicate_volunteer_project
BEFORE INSERT ON volunteerproject
FOR EACH ROW
DECLARE
    v_count NUMBER;
BEGIN
    SELECT COUNT(*)
    INTO v_count
    FROM volunteerproject
    WHERE volunteer_id = :NEW.volunteer_id
      AND project_id   = :NEW.project_id;

    IF v_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20021,
        'This volunteer is already assigned to the project');
    END IF;
END;