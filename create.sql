CREATE TABLE athlete(
athlete_id NUMBER(6) PRIMARY KEY CHECK(athlete_id >=1),
athlete_name VARCHAR2(30) NOT NULL,
athlete_surname VARCHAR2(50) NOT NULL,
bdate DATE NOT NULL,
sex CHAR(1) NOT NULL CHECK(sex IN('F','M'))
);

CREATE TABLE team(
noc CHAR(3) PRIMARY KEY, 
country VARCHAR2(40) NOT NULL,
CONSTRAINT check_format_noc
  CHECK(regexp_count(noc,'[[:alpha:]]')=3 AND noc=upper(noc))
);

CREATE TABLE organization(
org_name VARCHAR2(20) PRIMARY KEY,
year NUMBER(4) NOT NULL CHECK(year >= 776),
season CHAR(6) NOT NULL CHECK(season IN('Summer','Winter')),
city VARCHAR2(40) NOT NULL,
CONSTRAINT check_org_name CHECK(org_name =(year||' '||season))
);

CREATE TABLE participation(
athlete_id NUMBER(6),
org_name VARCHAR2(20),
noc CHAR(3) NOT NULL,
CONSTRAINT fk_participation_athlete
  FOREIGN KEY(athlete_id) REFERENCES athlete(athlete_id),
CONSTRAINT fk_participation_organization
  FOREIGN KEY(org_name) REFERENCES organization(org_name),
CONSTRAINT fk_participation_team
  FOREIGN KEY(noc) REFERENCES team(noc),
CONSTRAINT pk_participation PRIMARY KEY(athlete_id,org_name)
);

CREATE TABLE competition(
sport VARCHAR2(30) NOT NULL,
event VARCHAR2(60) PRIMARY KEY,
type VARCHAR2(10) NOT NULL CHECK(type IN('Individual','Team')),
CONSTRAINT check_sport
  CHECK(LENGTH(TRIM(TRANSLATE(sport,'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',' ')))=null)
);

CREATE TABLE compete(
athlete_id NUMBER(6),
event VARCHAR2(60),
CONSTRAINT compete_athlete
  FOREIGN KEY(athlete_id) REFERENCES athlete(athlete_id),
CONSTRAINT compete_competition
  FOREIGN KEY(event) REFERENCES competition(event),
CONSTRAINT pk_compete PRIMARY KEY (athlete_id,event)
);

CREATE TABLE award(
athlete_id NUMBER(6),
event VARCHAR2(60),
org_name VARCHAR2(20),
metal VARCHAR2(6) CHECK(metal IN ('Gold','Silver','Bronze')),
CONSTRAINT award_athlete
  FOREIGN KEY(athlete_id) REFERENCES athlete(athlete_id),
CONSTRAINT award_competition
  FOREIGN KEY(event) REFERENCES competition(event),
CONSTRAINT award_organization
  FOREIGN KEY(org_name) REFERENCES organization(org_name),
CONSTRAINT pk_award PRIMARY KEY (athlete_id,event,org_name)
);

COMMIT;
