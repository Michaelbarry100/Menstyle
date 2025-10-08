<?php

use App\Http\Controllers\MenStyles;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Artisan;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/dummy', function ()
{
    Artisan::call('storage:link');
});
Route::get('/', function () {
    return redirect()->route('dashboard');
    // return view('welcome');
})->name('welcome');
Route::view('/about', 'about')->name('about');

Route::middleware([
    'auth:sanctum',
    config('jetstream.auth_session'),
    'verified'
])->group(function () {

    Route::post('/categories/add', [MenStyles::class, 'addCategory'])->name('add-category');
    Route::post('/collections/add', [MenStyles::class, 'addCollection'])->name('add-collection');
    Route::post('/items/add', [MenStyles::class, 'addItem'])->name('add-item');

    Route::get('/category/create', [MenStyles::class,'createCategoryForm'])->name('category.create');
    Route::view('/collection/create', 'collection.create')->name('collection.create');
    Route::get('/style/create', [MenStyles::class, 'addStyleForm'])->name('style.create');
    
    Route::get('/collections', [MenStyles::class, 'collections'])->name('collections');
    Route::get('/categories/{cid?}', [MenStyles::class, 'categories'])->name('categories');
    Route::get('/items/{cid?}', [MenStyles::class, 'items'])->name('items');

    Route::get('/collections/collection/{id}', [MenStyles::class, 'collection'])->name('collection');
    Route::get('/categories/category/{id}', [MenStyles::class, 'category'])->name('category');
    Route::get('/items/item/{id}', [MenStyles::class, 'item'])->name('item');

    Route::post('/collection/update', [MenStyles::class, 'updateCollection'])->name('update-collection');
    Route::post('/categories/update', [MenStyles::class, 'updateCategory'])->name('update-category');
    
    Route::post('/items/update', [MenStyles::class, 'updateItem'])->name('update-item');


    Route::get('/delete/{type}/{id}', [MenStyles::class, 'remove'])->name('remove');

    Route::get('/dashboard', [MenStyles::class, 'dashboard'])->name('dashboard');
});


