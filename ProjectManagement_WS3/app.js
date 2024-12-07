const express = require('express');
const bodyParser = require('body-parser');
const mysql = require('mysql2/promise');

// Create the Express app
const app = express();
app.use(bodyParser.json());

// Database connection
const dbConfig = {
    host: 'localhost',
    user: 'root',
    password: '', 
    database: 'projectmanagement', 
};
let connection;

// Initialize the database connection
const initDb = async () => {
    try {
        connection = await mysql.createConnection(dbConfig);
        console.log('Database connected successfully.');
    } catch (error) {
        console.error('Database connection failed:', error.message);
    }
};

// Middleware to check DB connection
app.use(async (req, res, next) => {
    if (!connection) {
        await initDb();
    }
    next();
});

/// Routes

// **1. GET /teams**
// Retrieve all teams
app.get('/teams', async (req, res) => {
    try {
        const [teams] = await connection.query('SELECT * FROM team');
        res.status(200).json(teams);
    } catch (error) {
        console.error('Error fetching teams:', error);
        res.status(500).json({ message: 'Error fetching teams.' });
    }
});

// **2. GET /teams/:id**
// Retrieve a team by its ID
app.get('/team/:id', async (req, res) => {
    const teamId = req.params.id;

    if (!teamId) {
        return res.status(400).json({ message: 'teamId is required.' });
    }

    try {
        const [team] = await connection.query('SELECT * FROM team WHERE Id = ?', [teamId]);

        if (team.length === 0) {
            return res.status(404).json({ message: `Team with ID ${teamId} not found.` });
        }

        res.status(200).json(team[0]); // Return the first team object (as team ID is unique)
    } catch (error) {
        console.error('Error fetching team:', error);
        res.status(500).json({ message: 'Error fetching team.' });
    }
});


// **3. POST /assignTeam**
// Assign a team to a project
app.post('/assignTeam', async (req, res) => {
    const { teamId, projectId } = req.body;
    if (!teamId || !projectId) {
        return res.status(400).json({ message: 'teamId and projectId are required.' });
    }

    try {
        const [team] = await connection.query('SELECT * FROM team WHERE Id = ?', [teamId]);
        const [project] = await connection.query('SELECT * FROM project WHERE id = ?', [projectId]);

        if (!team.length) {
            return res.status(404).json({ message: `Team with ID ${teamId} does not exist.` });
        }
        if (!project.length) {
            return res.status(404).json({ message: `Project with ID ${projectId} does not exist.` });
        }

        const [existingAssignment] = await connection.query(
            'SELECT * FROM projectteam WHERE TeamId = ? AND ProjectId = ?',
            [teamId, projectId]
        );

        if (existingAssignment.length) {
            return res.status(400).json({ message: `Team ${teamId} is already assigned to project ${projectId}.` });
        }

        await connection.query('INSERT INTO projectteam (TeamId, ProjectId) VALUES (?, ?)', [teamId, projectId]);
        res.status(201).json({ message: `Team ${teamId} successfully assigned to project ${projectId}.` });
    } catch (error) {
        console.error('Error assigning team to project:', error);
        res.status(500).json({ message: 'Error assigning team to project.' });
    }
});

// **4. PUT /assignTeam**
// Update an assignment (reassign a team)
app.put('/assignTeam', async (req, res) => {
    const { teamId, projectId } = req.body;
    if (!teamId || !projectId) {
        return res.status(400).json({ message: 'teamId and projectId are required.' });
    }

    try {
        const [existingAssignment] = await connection.query(
            'SELECT * FROM projectteam WHERE ProjectId = ?',
            [projectId]
        );

        if (!existingAssignment.length) {
            return res.status(404).json({ message: `No assignment exists for project ID ${projectId}.` });
        }

        await connection.query(
            'UPDATE projectteam SET TeamId = ? WHERE ProjectId = ?',
            [teamId, projectId]
        );
        res.status(200).json({ message: `Project ${projectId} reassigned to team ${teamId}.` });
    } catch (error) {
        console.error('Error updating assignment:', error);
        res.status(500).json({ message: 'Error updating assignment.' });
    }
});

// **5. DELETE /assignTeam**
// Remove a team assignment from a project
app.delete('/assignTeam', async (req, res) => {
    const { teamId, projectId } = req.body;
    if (!teamId || !projectId) {
        return res.status(400).json({ message: 'teamId and projectId are required.' });
    }

    try {
        const [existingAssignment] = await connection.query(
            'SELECT * FROM projectteam WHERE TeamId = ? AND ProjectId = ?',
            [teamId, projectId]
        );

        if (!existingAssignment.length) {
            return res.status(404).json({ message: `No assignment found for team ${teamId} and project ${projectId}.` });
        }

        await connection.query(
            'DELETE FROM projectteam WHERE TeamId = ? AND ProjectId = ?',
            [teamId, projectId]
        );
        res.status(200).json({ message: `Assignment of team ${teamId} to project ${projectId} deleted.` });
    } catch (error) {
        console.error('Error deleting assignment:', error);
        res.status(500).json({ message: 'Error deleting assignment.' });
    }
});

// Start the server
const PORT = 3033;
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
