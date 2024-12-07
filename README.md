

# SOA-ESB Project Management System


![soa](SOA.webp)

## Table of Contents
- [SOA-ESB Project Management System](#soa-esb-project-management-system)
  - [Table of Contents](#table-of-contents)
  - [Project Overview](#project-overview)
  - [Technologies Used](#technologies-used)
  - [API Services](#api-services)
    - [1. Project Management (REST API)](#1-project-management-rest-api)
    - [2. Assign Member to Team (SOAP API)](#2-assign-member-to-team-soap-api)
    - [3. Assign Team to Project (REST API)](#3-assign-team-to-project-rest-api)
    - [4. Calendar Management (REST API)](#4-calendar-management-rest-api)
    - [5. Feedback Management (REST API)](#5-feedback-management-rest-api)
  - [Database Setup](#database-setup)
  - [Installation and Setup](#installation-and-setup)
  - [Enterprise Service Bus (ESB) Integration](#enterprise-service-bus-esb-integration)
  - [API Documentation](#api-documentation)
  - [Project Flow and Design](#project-flow-and-design)
  - [Feedback](#feedback)

---

## Project Overview

Welcome to the **SOA-ESB Project Management System**! This project is designed to manage tasks, team members, calendars, and project reports. The system leverages a combination of **REST** and **SOAP** APIs and integrates them into a seamless flow using an **Enterprise Service Bus (ESB)**.

This system manages key project elements:

- **Project management**: Allows tracking of project progress.
- **Team management**: Assign team members to specific tasks.
- **Calendar management**: Keep track of important dates and milestones.
- **Feedback collection**: Gather feedback from members regarding the project.

This project includes five core web services:

1. **Project Management** - Using **REST API** with **Spring Boot**.
2. **Team Assignment** - Using **SOAP API** with **C#**.
3. **Team-Project Assignment** - Using **REST API** with **Node.js**.
4. **Calendar Management** - Using **REST API** with **PHP**.
5. **Feedback Management** - Using **REST API** with **Node.js**.

---

## Technologies Used

This project uses a variety of **programming languages** and **frameworks** to provide a comprehensive learning experience:

- **Java (Spring Boot)** for REST API development.
- **C#** for SOAP-based services.
- **Node.js** for REST API services.
- **PHP** for calendar management services.
- **MySQL** for database management.
- **Anypoint Platform** for integrating services via **ESB**.

---

## API Services

### 1. Project Management (REST API)
This service allows you to retrieve and manage projects.

- **GET** `/projects` - Get all projects.
- **GET** `/projects/{id}` - Get a specific project by ID.

### 2. Assign Member to Team (SOAP API)
This service allows you to assign a member to a specific team.

- **POST** Request (SOAP)
    - Endpoint: `http://localhost:56446/Service.svc?singleWsdl`
    - XML Request:

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

### 3. Assign Team to Project (REST API)
This service allows you to assign a team to a project.

- **GET** `/teams` - Get all teams.
- **POST** `/assignTeam` - Assign a team to a project.
    - Request Body:

```json
{
    "teamId": id,
    "projectId": id
}
```

### 4. Calendar Management (REST API)
This service allows you to manage the project's calendar.

- **GET** `/calendar` - Get all calendar events.
- **POST** `/calendar` - Add a new calendar event.
    - Request Body:

```json
{
    "name": "Project Kickoff",
    "description": "Initial meeting to discuss project scope",
    "start_date": "2024-12-01T10:00:00",
    "end_date": "2024-12-01T12:00:00",
    "project_id": 1
}
```

### 5. Feedback Management (REST API)
This service allows collecting feedback from team members.

- **POST** `/api/feedback/add` - Add feedback for a project.
    - Request Body:

```json
{
  "description": "Great progress on the project.",
  "member_id": id,
  "project_id": id
}
```

---

## Database Setup

To set up the database for your project, you need to run the following SQL commands:

```sql
-- Create the database
CREATE DATABASE IF NOT EXISTS projectmanagement;
USE projectmanagement;

-- Create the 'project' table
CREATE TABLE `project` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



-- Create the 'team' table
CREATE TABLE `team` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Create the 'member' table
CREATE TABLE `member` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `TeamId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `TeamId` (`TeamId`),
  CONSTRAINT `member_ibfk_1` FOREIGN KEY (`TeamId`) REFERENCES `team` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Create the 'projectteam' table
CREATE TABLE `projectteam` (
  `ProjectId` bigint(20) NOT NULL,
  `TeamId` int(11) NOT NULL,
  PRIMARY KEY (`ProjectId`, `TeamId`),
  KEY `TeamId` (`TeamId`),
  CONSTRAINT `projectteam_ibfk_1` FOREIGN KEY (`ProjectId`) REFERENCES `project` (`id`),
  CONSTRAINT `projectteam_ibfk_2` FOREIGN KEY (`TeamId`) REFERENCES `team` (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


-- Create the 'calendar' table
CREATE TABLE `calendar` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `project_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `project_id` (`project_id`),
  CONSTRAINT `calendar_ibfk_1` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Create the 'feedback' table
CREATE TABLE feedback (
  id BIGINT(20) NOT NULL AUTO_INCREMENT,
  description TEXT NOT NULL,
  timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
  member_id INT(11) NOT NULL,
  project_id BIGINT(20) NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (member_id) REFERENCES member(Id),
  FOREIGN KEY (project_id) REFERENCES project(id)
);

```

After creating the tables, manually populate the database as shown in the project SQL setup.

---

## Installation and Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/CodeWizard-404/SOA-ESB-Project-Management.git
   cd SOA-ESB-Project-Management
   ```

2. **Set up the database**:
   Run the SQL queries to create and populate the database as shown in the [Database Setup](#database-setup).

3. **Start the services**:
   - **Spring Boot**: Run the Spring Boot application for the RESTful Project Management API.
   - **C# SOAP API**: Set up and start the SOAP API service using C#.
   - **Node.js**: Start the Node.js API for Team-Project Assignment and Feedback.
   - **PHP**: Start the PHP server for calendar management.

4. **Test the APIs** using Postman or curl.

---

## Enterprise Service Bus (ESB) Integration

This project integrates all services through **Anypoint Platform**. The flow connects the five APIs, allowing them to interact seamlessly. Once the APIs are started independently, Anypoint ESB binds them together, ensuring smooth data flow across all services.

---

## API Documentation

The full API documentation is available in this section, detailing each endpoint, HTTP methods, and request/response formats.

---

## Project Flow and Design

Below is a simple diagram illustrating the flow of the services:

1. **Service Interaction**: The REST and SOAP APIs are linked by the ESB.
2. **Service Call Flow**: The project services communicate through API calls, where data is passed from one service to another seamlessly.


---

## Feedback

If you have any feedback or suggestions, feel free to open an issue or contribute to the project. Your feedback will help improve the system!

