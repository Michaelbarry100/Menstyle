@extends('layouts.app')
@section('content')
     <!-- Card -->
    <div class="card mb-4">
        <!-- Card header -->
        <div class="card-header">
            <div class="d-flex justify-content-between align-items-center">
                <div>
                    <h3 class="mb-0">Styles</h3>
                    <span>All Styles added.</span>
                </div>
                <a href="{{route('style.create')}}" class="btn btn-sm btn-primary">
                    Add New
                </a>
            </div>
        </div>
        <!-- Table -->
        <div class="table-responsive border-0 overflow-y-hidden">
            <table class="table mb-0 text-nowrap">
                <thead class="table-light">
                    <tr>
                        <th scope="col" class="border-0">Style</th>
                        <th scope="col" class="border-0">Category</th>
                        <th scope="col" class="border-0">Collection</th>
                        <th scope="col" class="border-0"></th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($items as $item)
                        <tr>
                            <td class="border-top-0">
                                <div class="d-lg-flex">
                                    <div>
                                        <a href="{{route('item', encrypt($item->id))}}">
                                            <img src="{{$item->images[0]}}" alt=""
                                                class="rounded img-4by3-lg" /></a>
                                    </div>
                                    <div class="ms-lg-3 mt-2 mt-lg-0">
                                        <h4 class="mb-1 h5">
                                            <a href="{{route('item', encrypt($item->id))}}" class="text-inherit">
                                                {{$item->name}}
                                            </a>
                                        </h4>
                                    </div>
                                </div>
                            </td>
                            <td class="border-top-0">{{$item->category ? $item->category->name : '---'}}</td>
                            <td class="border-top-0">{{$item->category && $item->category->collection ? $item->category->collection->name : '---'}}</td>

                            <td class="text-muted border-top-0">
                                <span class="dropdown dropstart">
                                    <a class="text-muted text-decoration-none" href="#" role="button"
                                        id="courseDropdown" data-bs-toggle="dropdown"
                                        data-bs-offset="-20,20" aria-expanded="false">
                                        <i class="fe fe-more-vertical"></i>
                                    </a>
                                    <span class="dropdown-menu" aria-labelledby="courseDropdown">
                                        <a class="dropdown-item" href="{{route('item', encrypt($item->id))}}"><i
                                                class="fe fe-edit dropdown-item-icon"></i>Edit</a>
                                        <a class="dropdown-item" href=""><i
                                                class="fe fe-trash dropdown-item-icon"></i>Remove</a>
                                    </span>
                                </span>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        </div>
        {{$items->links()}}
    </div>
@endsection