<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('training-login');
});

Route::get('/training/social-engineering-login', function () {
    return view('training-login');
});
