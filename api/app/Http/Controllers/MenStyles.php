<?php

namespace App\Http\Controllers;

use App\Models\Item;
use App\Models\Category;
use App\Models\Collection;
use Illuminate\Http\Request;
use App\Http\Traits\ApiResponse;
use Illuminate\Support\Facades\Storage;

class MenStyles extends Controller
{
    use ApiResponse;

    public $gender = 'male';

    public function dashboard()
    {
        $collections = Collection::count();
        $categories = Category::count();
        $items = Item::count();
        
        return view('dashboard', [
            'collections' => $collections,
            'items' => $items,
            'categories' => $categories,
        ]);
    }
    
    public function getCollections($cid = null)
    {
        try {
            $data = [];
            $data = $cid == null ? 
                Collection::orderBy('name', 'asc')->where('gender', $this->gender)->get() 
                : Collection::where('id', $cid)->where('gender', $this->gender)->with('categories')->get();
                
            return $this->success($data, 'Request approved!');
        } catch (\Throwable $err) {
            $this->error($err->getMessage(), 500);
        }
    }


    public function getCategories($cid = null)
    {
        try {
            $data = $cid == null ? Category::where('gender', $this->gender)->withCount('items')->get() 
                : Category::where('id', $cid)->where('gender', $this->gender)->with('items')->get() ;
                 return $this->success($data, 'Request approved!');
        } catch (\Throwable $err) {
            $this->error($err->getMessage(), 500);
        }
    }


    public function getItems(Request $request, $cid = null)
    {
        try {
            $premium = $request->premium == '1';
            $items = $cid == null ? Item::where('isPremium', $premium)->with('category')->simplePaginate(20) 
                : Item::where('category_id', $cid)->where('isPremium', $premium)->with('category')->simplePaginate(20);
            return $this->success($items, 'Request approved!');
        } catch (\Throwable $err) {
            $this->error($err->getMessage(), 500);
        }
    }

    public function getAppLandingData()
    {
        try {
            $designs = Category::orderBy('created_at', 'desc')->get()->take(8);
            $collections = Collection::inRandomOrder()->get()->take(4);
            return $this->success([
                'designs' => $designs,
                'collections' => $collections,
            ], 'Request approved!');
        } catch (\Throwable $err) {
             $this->error($err->getMessage(), 500);
        }
        
    }


    /**
     * ================= Admin ===================
     */
    

    /**
     * Collections
     */
    public function addCollection(Request $request)
    {
        $request->validate([
            'name' => 'required|string|unique:collections,name',
            'image' => 'required|file|mimes:png,jpg,jpeg',
            'description' => 'nullable|string',
        ]);
        
        $upload = uploadFile($request->image, 'collection');

        $collection = Collection::create([
            'name' => $request->name,
            'featured_image' => env('APP_URL') . 'storage' .str_replace( 'public','',$upload),
            'description' => $request->description,
        ]);

        session()->flash('type', 'success');
        session()->flash('message', 'Collection added successfully!');

        return redirect()->route('collections');
    }

    public function updateCollection(Request $request)
    {
        $request->validate([
            'name' => 'required|string|unique:collections,name,'.$request->collection,
            'image' => 'nullable|file|mimes:png,jpg,jpeg',
            'description' => 'nullable|string',
            'collection' => 'required'
        ]);

        $collection = Collection::whereId($request->collection)->firstOrFail();
        $upload = $collection->featured_image;

        if($request->hasFile('image')){
            $uploadedFile = uploadFile($request->image, 'collection');
            $upload = env('APP_URL') . 'storage' .str_replace( 'public','',$uploadedFile);
        }
        
        $collection->update([
            'name' => $request->name,
            'featured_image' => $upload,
            'description' => $request->description,
        ]);

        session()->flash('type', 'success');
        session()->flash('message', 'Collection updated successfully!');
        return redirect()->route('collections');
    }

    public function collections()
    {
        $collections = Collection::orderBy('name', 'asc')->withCount('categories')->get();
        return view('collections.index', ['collections' => $collections ]);
    }
    
    public function collection($cid)
    {
        $collection = Collection::whereId(decrypt($cid))->firstOrFail();
        return view('collections.edit', [
            'collection' => $collection,
        ]);
    }


    /**
     * Categories
     */

    public function createCategoryForm()
    {
        $collections = Collection::all();
        return view('categories.add', [
            'collections' => $collections
        ]);
    }

    public function addCategory(Request $request)
    {
        $request->validate([
            'name' => 'required|string|unique:categories,name',
            'image' => 'required|file|mimes:png,jpg,jpeg',
            'description' => 'nullable|string',
            'collection' => 'nullable',
        ]);
        
        $upload = uploadFile($request->image, 'categories');
        $collection =  $request->collection != null ? Collection::where('id', $request->collection)->first() : null;

        $category = Category::create([
            'name' => $request->name,
            'featured_image' => env('APP_URL') . 'storage' .str_replace( 'public','',$upload),
            'gender' => $this->gender,
            'description' => $request->description,
            'collection_id' =>  $request->collection != null ? $collection->id : null
        ]);

        session()->flash('type', 'success');
        session()->flash('message', 'Category added successfully!');
        return redirect()->route('categories');
    }

    public function updateCategory(Request $request)
    {
        $request->validate([
            'name' => 'required|string|unique:categories,name,'.$request->category,
            'image' => 'nullable|file|mimes:png,jpg,jpeg',
            'description' => 'nullable|string',
            'collection' => 'nullable',
            'category' => 'required',
        ]);

        $category = Category::whereId($request->category)->firstOrFail();
    
        $collection =  $request->collection != null ? Collection::where('id', $request->collection)->first() : null;
        $upload = $category->featured_image;

        if($request->hasFile('image')){
            $uploadedFile = uploadFile($request->image, 'categories');
            $upload = env('APP_URL') . 'storage' .str_replace( 'public','',$uploadedFile);
        }
        $category->update([
            'name' => $request->name,
            'featured_image' => $upload,
            'gender' => $this->gender,
            'description' => $request->description,
            'collection_id' =>  $request->collection != null ? $collection->id : null
        ]);

        session()->flash('type', 'success');
        session()->flash('message', 'Category updated successfully!');
        return redirect()->route('categories');
    }

    public function categories($cid = null)
    {

        $categories = $cid != null 
            ? Category::orderBy('name', 'asc')->where('collection_id', decrypt($cid))->withCount('items')->get() 
            : Category::orderBy('name', 'asc')->withCount('items')->get();
        
        return view('categories.index', ['categories' => $categories ]);
    }

    public function category($cid)
    {
        $collections = Collection::all();
        $category = Category::whereId(decrypt($cid))->firstOrFail();
        return view('categories.edit', [
            'category' => $category,
            'collections' => $collections
        ]);
    }


    /**
     * Items
     */

    public function addStyleForm()
    {
        $categories = Category::all();
        return view('styles.create', [
            'categories' => $categories
        ]);
    }

    
    public function items($cid = null)
    {
        $category = $cid != null ? Category::whereId($cid)->firstOrFail() : null;
        $items = $cid == null ? Item::with('category')->get() : 
            Item::where('category_id', decrypt($cid))->with('category')->get();
    
            return view('styles.index', [
            'items' => $items,
            'category' => $category
        ]);
    }

    public function addItem(Request $request)
    {
        $request->validate([
            'name' => 'required|string|unique:items,name',
            'images' => 'required',
            'images.*' => 'file|mimes:png,jpg,jpeg',
            'category' => 'required',
            'isPremium' => 'boolean|nullable',
            'description' => 'nullable|string',
        ]);
        
        $premium = $request->isPremium == '1';

        $file_uploaded = [];
        foreach ($request->file('images') as $image) {
            $uploadedFile = uploadFile($image, 'styles');
            $upload = env('APP_URL') . 'storage' .str_replace( 'public','',$uploadedFile);
            array_push($file_uploaded, $upload);
        }

        $category = Category::where('id', $request->category)->first();
        
        $item = Item::create([
            'name' => $request->name,
            'images' => $file_uploaded,
            'category_id' => $category->id,
            'gender' => $this->gender,
            'isPremium' => $premium,
            'description' => $request->description
        ]);

        session()->flash('type', 'success');
        session()->flash('message', 'Style uploaded successfully!');

        return redirect()->route('items');
    }

    public function updateItem(Request $request)
    {
        
        $request->validate([
            'name' => 'required|string',
            'images' => 'nullable',
            'images.*' => 'nullable|file|mimes:png,jpg,jpeg',
            'description' => 'nullable|string',
            'category' => 'nullable',
            'isPremium' => 'boolean|nullable',
            'item' => 'required',
        ]);

        $premium = $request->isPremium == '1';
    
        
        $file_uploaded = [];
        
        if($request->hasFile('images') && $request->file('images') != null){
            foreach ($request->file('images') as $image) {
                $uploadedFile = uploadFile($image, 'styles');
                $upload = env('APP_URL') . 'storage' .str_replace( 'public','',$uploadedFile);
                array_push($file_uploaded, $upload);
            }
        }
        $item = Item::where('id', $request->item)->firstOrFail();
        
        $category = $request->category != null ? Category::where('id', $request->category)->first()->id : $item->category_id;
        
        
        $item = $item->update([
            'name' => $request->name,
            'images' => count($file_uploaded) > 0 ? $file_uploaded : $item->images,
            'category_id' => $category,
            'gender' => $this->gender,
            'isPremium' => $premium,
            'description' => $request->description
        ]);

        session()->flash('type', 'success');
        session()->flash('message', 'Style uploaded successfully!');

        return redirect()->route('items');
    }

    public function item($id)
    {
        $categories = Category::all();
        $item = Item::whereId(decrypt($id))->firstOrFail();
        return view('styles.edit', [
            'categories' => $categories,
            'item' => $item,
        ]);
    }
}
