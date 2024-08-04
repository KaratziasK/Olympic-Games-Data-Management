# Olympic Database Setup
This project involves creating a relational database schema for managing data related to Olympic games, athletes, teams, competitions, and awards. The database is designed to store and organize information about athletes' participation and achievements in various Olympic events.

**NOTE:** This project was developed as part of a course assignment at Harokopio University of Athens. The project was completed as a team effort by the following students:
- **Karatzias Kyriakos**
- **Christos Kalamatianos**
- **Xenofon Marketakis**

## Table of Contents
- Overview
- Database Schema
- Constraints
- Views

## Overview
The database schema consists of several tables that represent the core entities involved in the Olympic games. The main entities include athletes, teams, organizations (Olympic games), competitions, and awards. The relationships between these entities are managed through foreign key constraints to ensure data integrity.

## Database Schema
### Tables

1. **Athlete**
- `athlete_id`: Unique identifier for each athlete (Primary Key).
- `athlete_name`: First name of the athlete.
- `athlete_surname`: Surname of the athlete.
- `bdate`: Birthdate of the athlete.
- `sex`: Gender of the athlete ('M' for male, 'F' for female).

2. **Team**
- `noc`: National Olympic Committee code, a unique 3-letter country identifier (Primary Key).
- `country`: Name of the country.
- 
3. **Organization**
- `org_name`: Name of the Olympic event, which is a combination of the year and season (Primary Key).
- `year`: The year the Olympic games were held.
- `season`: The season of the Olympics ('Summer' or 'Winter').
- `city`: Host city of the Olympic event.

4. **Participation**
- `athlete_id`: ID of the athlete participating (Foreign Key).
- `org_name`: Name of the Olympic event (Foreign Key).
- `noc`: National Olympic Committee code (Foreign Key).
- `Primary Key`: Combination of athlete_id and org_name.
- 
5, **Competition**
- `sport`: Name of the sport.
- `event`: Name of the event (Primary Key).
- `type`: Type of event ('Individual' or 'Team').
- 
6. **Compete**
- `athlete_id`: ID of the athlete competing (Foreign Key).
- `event`: Event in which the athlete competes (Foreign Key).
- **Primary Key**: Combination of athlete_id and event.
- 
7. **Award**
- `athlete_id`: ID of the athlete who received an award (Foreign Key).
- `event`: Event for which the award was received (Foreign Key).
- `org_name`: Name of the Olympic event (Foreign Key).
- `metal`: Type of medal ('Gold', 'Silver', 'Bronze').
**Primary Key**: Combination of athlete_id, event, and org_name.

## Constraints
The database includes various constraints to ensure data integrity:

- Primary Key and Foreign Key constraints to enforce relationships between tables.
- Check constraints for validation, such as ensuring the sex column in the athlete table is either 'M' or 'F'.
- Custom constraints to ensure the format of certain fields, like the noc in the team table.

## Views
The script contains commands to drop views related to medal counts and athlete participation. To implement custom views, modify the script accordingly.
