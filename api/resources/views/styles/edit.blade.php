@extends('layouts.app')
@section('content')
    <div class="card border-0 mb-4">
        <!-- Card header -->
        <div class="card-header">
        <h4 class="mb-0">Edit Style</h4>
        </div>
        <!-- Card body -->
        <div class="card-body">
            <div class="mt-4">
                <form method="POST" enctype="multipart/form-data" action="{{route('update-item')}}">
                    @csrf
                    <!-- Form -->
                    <input type="hidden" id="item" name="item" value="{{$item->id}}" >
                    <div class="row">
                        <div class="mb-3 col-md-9">
                            <!-- Title -->
                            <label for="name" class="form-label">Name</label>
                            <input type="text" id="name" name="name" value="{{$item->name}}" class="form-control text-dark" placeholder="Collection Name">
                            @error('name')
                                    <small class="text-danger">{{$message}}</small>
                            @enderror
                        </div>
                        <div class="mb-3 col-md-9">
                            <label for="category" class="form-label">Collection</label>
                            <select name="category"  class="form-control text-dark" id="collection">
                                <option value="">--Select Collection--</option>
                                @foreach ($categories as $co)
                                    <option value="{{$co->id}}" {{$co->id == $item->category_id ? 'selected' : ''}}>{{ucfirst($co->name)}}</option>
                                @endforeach
                            </select>
                            @error('category')
                                    <small class="text-danger">{{$message}}</small>
                            @enderror
                        </div>
                         <div class="mb-3 col-md-9">
                            <label for="isPremium" class="form-label">Is Premium Style</label>
                            <select name="isPremium"  class="form-control text-dark" id="collection">
                                <option>Select Option</option>
                                <option value="{{false}}" {{!$item->isPremium ? 'selected': ''}}>No</option>
                                <option value="{{true}}" {{$item->isPremium ? 'selected': ''}}>Yes</option>
                                
                            </select>
                            @error('isPremium')
                                    <small class="text-danger">{{$message}}</small>
                            @enderror
                        </div>
                        <div class="mb-3 col-md-9">
                            <!-- Title -->
                            <label for="description" class="form-label">Description</label>
                            <textarea type="text" name="description" id="description" class="form-control text-dark" placeholder="Collection Description">{{$item->description}}</textarea>
                            @error('description')
                                    <small class="text-danger">{{$message}}</small>
                            @enderror
                        </div>
                        <div class="mb-3 col-md-9">
                            <!-- Title -->
                            <label for="description" class="form-label">New Image</label>
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