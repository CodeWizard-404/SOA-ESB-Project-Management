const express = require('express');
const router = express.Router();
const feedbackController = require('../controllers/feedbackController');

router.post('/add', feedbackController.addFeedback);

router.get('/:project_id', feedbackController.getFeedbacksByProject);

module.exports = router;
