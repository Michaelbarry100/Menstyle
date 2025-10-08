{{-- <x-guest-layout>
    <x-auth-card>
       <x-auth-card-logo />

        <x-jet-validation-errors class="mb-4" />

        @if (session('status'))
            <div class="mb-4 font-medium text-sm text-green-600">
                {{ session('status') }}
            </div>
        @endif

        <form method="POST" action="{{ route('login') }}">
            @csrf

            <div>
                <x-jet-label for="email" value="{{ __('Email') }}" />
                <x-jet-input id="email" class="block mt-1 w-full" type="email" name="email" :value="old('email')" required autofocus />
            </div>

            <div class="mt-4">
                <x-jet-label for="password" value="{{ __('Password') }}" />
                <div class="relative">
                    <x-jet-input id="password" class="block mt-1 w-full" type="password" name="password" required autocomplete="current-password" />
                    <span onclick="togglePassword()" class="absolute right-3 top-2 cursor-pointer hover:text-amber-600 transition ease-in-out duration-150 delay-150">
                        <span style="display: block;" id="show">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-6 h-6">
                                <path d="M12 15a3 3 0 100-6 3 3 0 000 6z" />
                                <path fill-rule="evenodd" d="M1.323 11.447C2.811 6.976 7.028 3.75 12.001 3.75c4.97 0 9.185 3.223 10.675 7.69.12.362.12.752 0 1.113-1.487 4.471-5.705 7.697-10.677 7.697-4.97 0-9.186-3.223-10.675-7.69a1.762 1.762 0 010-1.113zM17.25 12a5.25 5.25 0 11-10.5 0 5.25 5.25 0 0110.5 0z" clip-rule="evenodd" />
                            </svg>
                        </span>
                        <span style="display: none;" id="hide">
                            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="currentColor" class="w-6 h-6">
                                <path d="M3.53 2.47a.75.75 0 00-1.06 1.06l18 18a.75.75 0 101.06-1.06l-18-18zM22.676 12.553a11.249 11.249 0 01-2.631 4.31l-3.099-3.099a5.25 5.25 0 00-6.71-6.71L7.759 4.577a11.217 11.217 0 014.242-.827c4.97 0 9.185 3.223 10.675 7.69.12.362.12.752 0 1.113z" />
                                <path d="M15.75 12c0 .18-.013.357-.037.53l-4.244-4.243A3.75 3.75 0 0115.75 12zM12.53 15.713l-4.243-4.244a3.75 3.75 0 004.243 4.243z" />
                                <path d="M6.75 12c0-.619.107-1.213.304-1.764l-3.1-3.1a11.25 11.25 0 00-2.63 4.31c-.12.362-.12.752 0 1.114 1.489 4.467 5.704 7.69 10.675 7.69 1.5 0 2.933-.294 4.242-.827l-2.477-2.477A5.25 5.25 0 016.75 12z" />
                            </svg>
                        </span>
                    </span>
                </div>
            </div>

            
            <div class="flex items-center justify-between gap-4 my-4">
                <div class="block">
                    <label for="remember_me" class="flex items-center">
                        <x-jet-checkbox id="remember_me" name="remember" />
                        <span class="ml-2 text-sm text-gray-600">{{ __('Remember me') }}</span>
                    </label>
                </div>
                @if (Route::has('password.request'))
                    <a class="underline text-sm text-gray-600 hover:text-gray-900" href="{{ route('password.request') }}">
                        {{ __('Forgot your password?') }}
                    </a>
                @endif
            </div>

            <div class="w-full mt-6">
                <x-jet-button class="w-full text-center flex items-center hover:bg-primary/80 justify-center text-bold py-4 bg-primary">
                    {{ __('Log in') }}
                </x-jet-button>
            </div>

            <div class="mt-4 text-center">
                <a href="{{route('register')}}" class="text-sm font-semibold tracking-wide hover:text-primary">Create Account</a>
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
              <h1 class="mb-1 fw-bold">Sign in</h1>
            </div>
             @if (session('status'))
                <div class="alert alert-success">
                    {{ session('status') }}
                </div>
            @endif
            <!-- Form -->
            <form method="POST" action="{{route('login')}}">
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
              	<!-- Password -->
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" id="password" class="form-control" name="password" autocomplete="current-password" placeholder="**************"
                    required>
                    @error('password')
                        <span class="text-danger">{{$message}}</span>
                    @enderror
                </div>
              	<!-- Checkbox -->
              <div class="d-lg-flex justify-content-between align-items-center mb-4">
                <div class="form-check">
                  <input type="checkbox" class="form-check-input" name="remember" id="rememberme">
                  <label class="form-check-label " for="rememberme">Remember me</label>
                </div>
                    @if (Route::has('password.request'))
                        <a href="{{route('password.email')}}">Forgot your password?</a>
                    @endif
                <div>
                  
                </div>
              </div>
              <div>
                  <div class="d-grid">
                <button type="submit" class="btn btn-primary ">Sign in</button>
              </div>
              </div>
             
            </form>
          </div>
        </div>
@endsection
