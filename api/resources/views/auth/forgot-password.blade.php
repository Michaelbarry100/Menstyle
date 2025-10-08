{{-- <x-guest-layout>
    <x-auth-card>
        <x-auth-card-logo />

        <div class="mb-4 text-sm text-gray-600">
            {{ __('Forgot your password? No problem. Just let us know your email address and we will email you a password reset link that will allow you to choose a new one.') }}
        </div>
  
        @if (session('status'))
             <div class="mb-4 font-medium text-sm text-green-800 bg-green-50 p-3 rounded-md">
                {{ session('status') }}
            </div>
        @endif

        <x-jet-validation-errors class="mb-4" />

        <form method="POST" action="{{ route('password.email') }}">
            @csrf

            <div class="block">
                <x-jet-label for="email" value="{{ __('Email') }}" />
                <x-jet-input id="email" class="block mt-1 w-full" type="email" name="email" :value="old('email')" required autofocus />
            </div>

            <div class="w-full mt-8">
                <x-jet-button class="w-full text-center flex items-center hover:bg-primary/80 justify-center text-bold py-4 bg-primary">
                    {{ __('Email Password Reset Link') }}
                </x-jet-button>
            </div>
        </form>
    </x-auth-card>
</x-guest-layout> --}}

@extends('layouts.guest')
@section('content')
     <!-- Card -->
        <div class="card shadow ">
          <!-- Card body -->
          <div class="card-body p-6">
            <div class="mb-4">
              <h1 class="mb-1 fw-bold">Forgot your password</h1>
            </div>
             @if (session('status'))
                <div class="alert alert-success">
                    {{ session('status') }}
                </div>
            @endif
            <!-- Form -->
            <form method="POST" action="{{ route('password.email') }}">
                @csrf
              	<!-- Username -->
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" id="email" class="form-control" value="{{old('email')}}" name="email" placeholder="Email address here"
                    required>
                    @error('email')
                        <span class="text-danger">{{$message}}</span>
                    @enderror
                </div>
              	
              <div>
                  <div class="d-grid">
                <button type="submit" class="btn btn-primary ">Email Password Reset Link</button>
              </div>
              </div>
             
            </form>
          </div>
        </div>
@endsection
