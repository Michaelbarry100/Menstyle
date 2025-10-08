<?php

use Illuminate\Http\Request;
use App\Http\Controllers\MenStyles;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});


Route::prefix('v1')->group(function () {
    Route::get('/men-styles/landing', [MenStyles::class, 'getAppLandingData']);
    Route::get('/men-styles/collections/{cid?}', [MenStyles::class, 'getCollections']);
    Route::get('/men-styles/categories/{cid?}', [MenStyles::class, 'getCategories']);
    Route::get('/men-styles/items/{cid?}', [MenStyles::class, 'getItems']);
});