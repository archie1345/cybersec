<?php

namespace App\Http\Controllers;

use App\Models\TrainingSubmission;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use Illuminate\Validation\Rule;

class TrainingSubmissionController extends Controller
{
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'username' => ['nullable', 'string', 'max:255'],
            'password' => ['nullable', 'string', 'max:255'],
        ]);

        $submission = TrainingSubmission::create([
            'username' => $validated['username'] ?? null,
            'password' => $validated['password'] ?? null,
        ]);

        return response()->json([
            'saved' => true,
            'id' => $submission->id,
        ], 201);
    }

    /**
     * @param array<string, mixed> $data
     * @return array{0: string|null, 1: string|null}
     */
    
}
