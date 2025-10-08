@extends('layouts.app')
@section('content')
    <div class="card border-0 mb-4">
        <!-- Card header -->
        <div class="card-header">
        <h4 class="mb-0">Edit Category</h4>
        </div>
        <!-- Card body -->
        <div class="card-body">
            <div class="mt-4">
                <form method="POST" enctype="multipart/form-data" action="{{route('update-category')}}">
                    @csrf
                    <input type="hidden" name="category" value="{{$category->id}}">
                    <!-- Form -->
                    <div class="row">
                        <div class="mb-3 col-md-9">
                            <!-- Title -->
                            <label for="name" class="form-label">Name</label>
                            <input type="text" id="name" value="{{$category->name}}" name="name" class="form-control text-dark" placeholder="Collection Name">
                            @error('name')
                                    <small class="text-danger">{{$message}}</small>
                            @enderror
                        </div>
                        <div class="mb-3 col-md-9">
                            <label for="collection" class="form-label">Collection</label>
                            <select name="collection"  class="form-control text-dark" id="collection">
                                <option value="">--Select Collection--</option>
                                @foreach ($collections as $co)
                                    <option value="{{$co->id}}" {{$co->id == $category->collection_id ? 'selected' : ''}}>{{ucfirst($co->name)}}</option>
                                @endforeach
                            </select>
                            @error('collection')
                                    <small class="text-danger">{{$message}}</small>
                            @enderror
                        </div>
                        <div class="mb-3 col-md-9">
                            <!-- Title -->
                            <label for="description" class="form-label">Description</label>
                            <textarea type="text" id="description" name="description" class="form-control text-dark" placeholder="Collection Description">{{$category->description}}</textarea>
                            @error('description')
                                    <small class="text-danger">{{$message}}</small>
                            @enderror
                        </div>
                        <div class="mb-3 col-md-9">
                            <!-- Title -->
                            <label for="description" class="form-label">Featured Image</label>
                           <input type="file" id="image" name="image" class="form-control text-dark" placeholder="Image">
                            @error('image')
                                    <small class="text-danger">{{$message}}</small>
                            @enderror
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary"> Publish </button>
                </form>
            </div>
            <!-- button -->
        </div>
    </div>
@endsection