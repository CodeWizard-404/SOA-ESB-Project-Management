const db = require('../config/db');

// Add a new feedback
exports.addFeedback = async (req, res) => {
    const { description, member_id, project_id } = req.body;

    if (!description || !member_id || !project_id) {
        return res.status(400).json({ message: 'All fields are required.' });
    }

    try {
        const [result] = await db.execute(
            'INSERT INTO feedback (description, member_id, project_id) VALUES (?, ?, ?)',
            [description, member_id, project_id]
        );
        res.status(201).json({ message: 'Feedback added successfully.', feedbackId: result.insertId });
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error.' });
    }
};

// Get all of a project
exports.getFeedbacksByProject = async (req, res) => {
    const { project_id } = req.params;

    try {
        const [rows] = await db.execute('SELECT * FROM feedback WHERE project_id = ?', [project_id]);
        res.status(200).json(rows);
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: 'Internal server error.' });
    }
};
