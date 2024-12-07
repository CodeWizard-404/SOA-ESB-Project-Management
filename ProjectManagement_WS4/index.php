<?php
require 'vendor/autoload.php';

use Slim\Factory\AppFactory;
use App\calendar;
use App\Database;

// Initialize Slim App
$app = AppFactory::create();

// Initialize Database
Database::init();

// Route to get all calendar events
$app->get('/calendars', function ($request, $response) {
    $events = calendar::all();
    $response->getBody()->write(json_encode($events));
    return $response->withHeader('Content-Type', 'application/json');
});

// Route to get a specific event
$app->get('/calendar/{id}', function ($request, $response, $args) {
    $event = calendar::find($args['id']);
    if ($event) {
        $response->getBody()->write(json_encode($event));
    } else {
        $response->getBody()->write(json_encode(['error' => 'Event not found']));
        return $response->withStatus(404);
    }
    return $response->withHeader('Content-Type', 'application/json');
});

// Route to create a new event
$app->post('/calendar', function ($request, $response) {
    // Parse JSON data from the request body
    $data = json_decode($request->getBody(), true);

    // Check if the data is properly parsed
    if ($data === null) {
        // Return error if JSON is invalid
        $response->getBody()->write(json_encode(['error' => 'Invalid JSON data']));
        return $response->withHeader('Content-Type', 'application/json')->withStatus(400);
    }

    $name = $data['name'];
    $description = $data['description'];
    $start_date = $data['start_date'];
    $end_date = $data['end_date'];
    $project_id = $data['project_id'];

    try {
        $calendar = new Calendar();
        $calendar->name = $name;
        $calendar->description = $description;
        $calendar->start_date = $start_date;
        $calendar->end_date = $end_date;
        $calendar->project_id = $project_id;
        $calendar->save();

        // Return the created calendar item as a JSON response
        $response->getBody()->write(json_encode($calendar));
        return $response->withHeader('Content-Type', 'application/json')->withStatus(201);
    } catch (Exception $e) {
        $response->getBody()->write(json_encode(['error' => 'Failed to create event']));
        return $response->withHeader('Content-Type', 'application/json')->withStatus(500);
    }
});



// Route to update an event
$app->put('/calendar/{id}', function ($request, $response, $args) {
    // Parse JSON data from the request body
    $data = json_decode($request->getBody(), true);

    // Check if the data is properly parsed
    if ($data === null) {
        // Return error if JSON is invalid
        $response->getBody()->write(json_encode(['error' => 'Invalid JSON data']));
        return $response->withHeader('Content-Type', 'application/json')->withStatus(400);
    }

    // Get event ID from URL parameters
    $id = $args['id'];

    // Retrieve event by ID
    $calendar = Calendar::find($id);
    if (!$calendar) {
        $response->getBody()->write(json_encode(['error' => 'Event not found']));
        return $response->withHeader('Content-Type', 'application/json')->withStatus(404);
    }

    // Update event fields
    $calendar->name = $data['name'];
    $calendar->description = $data['description'];
    $calendar->start_date = $data['start_date'];
    $calendar->end_date = $data['end_date'];
    $calendar->project_id = $data['project_id'];

    try {
        $calendar->save();

        // Return updated calendar item as a JSON response
        $response->getBody()->write(json_encode($calendar));
        return $response->withHeader('Content-Type', 'application/json')->withStatus(200);
    } catch (Exception $e) {
        $response->getBody()->write(json_encode(['error' => 'Failed to update event']));
        return $response->withHeader('Content-Type', 'application/json')->withStatus(500);
    }
});


// Route to delete an event
$app->delete('/calendar/{id}', function ($request, $response, $args) {
    $event = calendar::find($args['id']);
    if ($event) {
        $event->delete();
        return $response->withStatus(204);
    } else {
        $response->getBody()->write(json_encode(['error' => 'Event not found']));
        return $response->withStatus(404);
    }
});

// Run the app
$app->run();
