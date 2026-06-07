<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TrainingSubmission extends Model
{
    protected $fillable = [
        'username',
        'password',
    ];

    protected function casts(): array
    {
        return [
            
        ];
    }
}
