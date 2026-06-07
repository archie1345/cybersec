<?php

use App\Http\Controllers\TrainingSubmissionController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('training-login');
});

Route::get('/training/social-engineering-login', function () {
    return view('training-login');
});

Route::post('/training/submissions', [TrainingSubmissionController::class, 'store'])
    ->name('training.submissions.store');
