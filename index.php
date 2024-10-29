<?php

require "vendor/autoload.php";
require "init.php";

// Database connection object (from init.php (DatabaseConnection))
global $conn;

try {

    // Create Router instance
    $router = new \Bramus\Router\Router();

    // Define routes
    $router->get('/', '\App\Controllers\HomeController@index');

    $router->get('/register', '\App\Controllers\ExamController@registrationForm');
    $router->post('/register', '\App\Controllers\ExamController@register');

    $router->get('/login', '\App\Controllers\LoginController@loginForm');
    $router->post('/login', '\App\Controllers\LoginController@login');


    $router->get('/exam', '\App\Controllers\ExamController@exam');
    $router->post('/exam', '\App\Controllers\ExamController@exam');
    $router->get('/result', '\App\Controllers\ExamController@result');

    $router->get('/examinees', '\App\Controllers\ExamineesController@index');

    // Route for exporting a single exam attempt to PDF
    $router->get('/exam-attempts/{id}/export', '\App\Controllers\ExamineesController@exportAttemptToPDF');


    // Run it!
    $router->run();

} catch (Exception $e) {

    echo json_encode([
        'error' => $e->getMessage()
    ]);

}
