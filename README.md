# Project Management API Suite

This repository contains a set of web services designed to manage various aspects of a project management system. The project demonstrates integration of multiple technologies, including **Spring Boot**, **C# (SOAP)**, **Node.js**, and **Ruby on Rails**, working together to provide functionality for managing projects, teams, members, and calendars. The backend is supported by a **MariaDB** database.

---

## Table of Contents

- [Overview](#overview)
- [Technologies Used](#technologies-used)
- [Database Schema](#database-schema)
- [Web Services](#web-services)
  - [WS1: Projects Service (Spring Boot)](#ws1-projects-service-spring-boot)
  - [WS2: Member-to-Team Assignment (SOAP - C#)](#ws2-member-to-team-assignment-soap---c)
  - [WS3: Team-to-Project Assignment (Node.js)](#ws3-team-to-project-assignment-nodejs)
  - [WS4: Calendar Management (Ruby on Rails)](#ws4-calendar-management-ruby-on-rails)
- [Setup Instructions](#setup-instructions)
- [API Endpoints](#api-endpoints)
- [Future Enhancements](#future-enhancements)
- [License](#license)

---

## Overview

This project provides a comprehensive solution for managing:
- **Projects**: View and track project details.
- **Teams**: Assign teams to projects and members to teams.
- **Calendar**: Schedule and manage events related to projects.

The database schema ensures proper relationships among entities, such as **projects**, **teams**, **members**, and **calendar events**.

---

## Technologies Used

- **Backend Frameworks:**
  - Spring Boot (Java) for REST APIs
  - .NET Core (C#) for SOAP services
  - Node.js with Express for REST APIs
  - Ruby on Rails for REST APIs
- **Database:** MariaDB
- **Language:** Java, C#, JavaScript (Node.js), Ruby
- **Tools:** Postman (API Testing), SOAP UI (SOAP service testing), IntelliJ IDEA, Visual Studio, VS Code, Rails.

---

## Database Schema

Here is the database schema used in the project:

![Database Schema](link-to-schema-image-if-available)

**Tables:**
1. **Project:** Stores project details.
2. **Team:** Maintains team information.
3. **Member:** Lists team members.
4. **ProjectTeam:** Many-to-many mapping between projects and teams.
5. **Calendar:** Tracks project-related events.

```sql
-- Example: Projects Table
CREATE TABLE `project` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255),
  `description` varchar(255),
  `status` varchar(255),
  PRIMARY KEY (`id`)
);
```

For the full SQL schema, refer to [Database.sql](./Database.sql).

---

## Web Services

### WS1: Projects Service (Spring Boot)

Handles project retrieval and management.

- **Endpoints:**
  - `GET /projects`: List all projects.
  - `GET /projects/{id}`: Retrieve a specific project by ID.
- **Framework:** Spring Boot
- **Port:** `8088`

---

### WS2: Member-to-Team Assignment (SOAP - C#)

A SOAP-based service to assign a member to a team.

- **WSDL:** `http://localhost:56446/Service.svc?singleWsdl`
- **SOAP Envelope:**

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:tem="http://tempuri.org/">
   <soapenv:Header/>
   <soapenv:Body>
      <tem:AssignMemberToTeam>
         <tem:memberId>id</tem:memberId>
         <tem:teamId>id</tem:teamId>
      </tem:AssignMemberToTeam>
   </soapenv:Body>
</soapenv:Envelope>
```

---

### WS3: Team-to-Project Assignment (Node.js)

Allows assigning a team to a project.

- **Framework:** Node.js with Express.
- **Description:** This service checks database integrity before assigning teams to projects.
- **Port:** `3000`

---

### WS4: Calendar Management (Ruby on Rails)

Manages project-related events using CRUD operations.

- **Endpoints:**
  - `GET /calendar`: List all calendar events.
  - `GET /calendar/{id}`: Retrieve event details by ID.
  - `POST /calendar`: Create a new event.
  - `PUT /calendar/{id}`: Update an event.
  - `DELETE /calendar/{id}`: Delete an event.
- **Port:** `4000`

---

## Setup Instructions

1. **Database Setup:**
   - Install MariaDB and import the provided [SQL script](./Database.sql).
   - Configure database connection settings for each service.

2. **Run Each Service:**

   - **Spring Boot Service (WS1):**
     ```bash
     cd ws1-spring-boot
     mvn spring-boot:run
     ```

   - **SOAP Service (WS2):**
     - Open the project in Visual Studio and start the application.

   - **Node.js Service (WS3):**
     ```bash
     cd ws3-nodejs
     npm install
     node index.js
     ```

   - **Ruby on Rails Service (WS4):**
     ```bash
     cd ws4-ruby
     bundle install
     rails server
     ```

3. **API Testing:**
   - Use **Postman** or **SOAP UI** for testing REST and SOAP services.

---

## API Endpoints

| Service | Method | Endpoint | Description |
|---------|--------|----------|-------------|
| WS1     | `GET`  | `/projects` | List all projects |
| WS1     | `GET`  | `/projects/{id}` | Get project by ID |
| WS2     | `SOAP` | `/Service.svc?singleWsdl` | Assign member to a team |
| WS3     | `POST` | `/assignTeamToProject` | Assign a team to a project |
| WS4     | `GET`  | `/calendar` | List calendar events |

---

## Future Enhancements

- Add authentication and authorization for APIs.
- Improve error handling and validations.
- Create a front-end dashboard for managing entities.
- Implement CI/CD for automated deployments.

