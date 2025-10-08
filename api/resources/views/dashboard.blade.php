@extends('layouts.app')
@section('content')
    <div class="row">
        <div class="col-lg-4 col-md-12 col-12">
            <!-- Card -->
            <div class="card mb-4">
                <div class="p-4">
                    <span class="fs-6 text-uppercase fw-semi-bold">Total Collections</span>
                    <a href="{{route('collections')}}">
                        <h2 class="mt-4 fw-bold mb-1 d-flex align-items-center h1 lh-1">
                            {{$collections}}
                        </h2>
                    </a>
                </div>
            </div>
        </div>

        <div class="col-lg-4 col-md-12 col-12">
            <!-- Card -->
            <div class="card mb-4">
                <div class="p-4">
                    <span class="fs-6 text-uppercase fw-semi-bold">Total Categories</span>
                    <a href="{{route('categories')}}">
                        <h2 class="mt-4 fw-bold mb-1 d-flex align-items-center h1 lh-1">
                             {{$categories}}
                        </h2>
                    </a>
                </div>
            </div>
        </div>
        <div class="col-lg-4 col-md-12 col-12">
            <!-- Card -->
            <div class="card mb-4">
                <div class="p-4">
                    <span class="fs-6 text-uppercase fw-semi-bold">Uploaded Styles</span>
                    <h2 class="mt-4 fw-bold mb-1 d-flex align-items-center h1 lh-1">
                        {{$items}}
                    </h2>
                </div>
            </div>
        </div>
    </div>
@endsection