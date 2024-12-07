const express = require('express');
const bodyParser = require('body-parser');
const feedbackRoutes = require('./routes/feedback');

const app = express();

app.use(bodyParser.json());

app.use('/api/feedback', feedbackRoutes);

const PORT = 5050;
app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});
