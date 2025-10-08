

@extends('layouts.guest')
@section('content')
     <!-- Card -->
        <div class="card shadow ">
          <!-- Card body -->
          <div class="card-body p-6">
            <div class="mb-4">
              <h1 class="mb-1 fw-bold">Create account</h1>
            </div>
             @if (session('status'))
                <div class="alert alert-success">
                    {{ session('status') }}
                </div>
            @endif
            <!-- Form -->
            <form method="POST" action="{{ route('register') }}">
                @csrf
                <!-- Username -->
                <div class="mb-3">
                    <label for="name" class="form-label">name</label>
                    <input type="name" id="name" class="form-control" value="{{old('name')}}" name="name" placeholder="Username here" autocomplete="name" 
                    required>
                    @error('email')
                        <span class="text-danger">{{$message}}</span>
                    @enderror
                </div>

              	<!-- Username -->
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" id="email" class="form-control" value="{{old('email')}}" name="email" placeholder="Email address here"
                    required>
                    @error('email')
                        <span class="text-danger">{{$message}}</span>
                    @enderror
                </div>
              	<!-- Password -->
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" id="password" class="form-control" name="password" autocomplete="current-password" placeholder="**************"
                    required>
                    @error('password')
                        <span class="text-danger">{{$message}}</span>
                    @enderror
                </div>

                <!-- Password -->
                <div class="mb-3">
                    <label for="password_confirmation" class="form-label">Password Confirmation</label>
                    <input type="password_confirmation" id="password_confirmation" class="form-control" name="password_confirmation" autocomplete="new-password" placeholder="**************"
                    required>
                </div>
              <div>
                  <div class="d-grid">
                <button type="submit" class="btn btn-primary ">Create Account</button>
              </div>
              </div>
             
            </form>
          </div>
        </div>
@endsection
