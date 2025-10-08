@extends('layouts.app')
@section('content')
    <div class="card border-0 mb-4">
        <!-- Card header -->
        <div class="card-header">
        <h4 class="mb-0">Add Style</h4>
        </div>
        <!-- Card body -->
        <div class="card-body">
            <div class="mt-4">
                <form method="POST" enctype="multipart/form-data" action="{{route('add-item')}}">
                    @csrf
                    <!-- Form -->
                    <div class="row">
                        <div class="mb-3 col-md-9">
                            <!-- Title -->
                            <label for="name" class="form-label">Name</label>
                            <input type="text" id="name" name="name" value="{{old('name')}}" class="form-control text-dark" placeholder="Collection Name">
                            @error('name')
                                    <small class="text-danger">{{$message}}</small>
                            @enderror
                        </div>
                        <div class="mb-3 col-md-9">
                            <label for="category" class="form-label">Collection</label>
                            <select name="category"  class="form-control text-dark" id="collection">
                                <option value="">--Select Collection--</option>
                                @foreach ($categories as $co)
                                    <option value="{{$co->id}}">{{ucfirst($co->name)}}</option>
                                @endforeach
                            </select>
                            @error('category')
                                    <small class="text-danger">{{$message}}</small>
                            @enderror
                        </div>
                        <div class="mb-3 col-md-9">
                            <label for="isPremium" class="form-label">Is Premium Style</label>
                            <select name="isPremium"  class="form-control text-dark" id="collection">
                                <option value="{{false}}" selected>No</option>
                                <option value="{{true}}">Yes</option>
                                
                            </select>
                            @error('isPremium')
                                    <small class="text-danger">{{$message}}</small>
                            @enderror
                        </div>
                        <div class="mb-3 col-md-9">
                            <!-- Title -->
                            <label for="description" class="form-label">Description</label>
                            <textarea type="text" name="description" id="description" class="form-control text-dark" placeholder="Collection Description"></textarea>
                            @error('description')
                                    <small class="text-danger">{{$message}}</small>
                            @enderror
                        </div>
                        <div class="mb-3 col-md-9">
                            <!-- Title -->
                            <label for="description" class="form-label">Image</label>
                            <input type="file" id="images" name="images[]" class="form-control text-dark" placeholder="Image" multiple>
                            @error('images')
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