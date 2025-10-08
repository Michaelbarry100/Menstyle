<div class="min-h-screen relative flex flex-col justify-center items-center pt-6 sm:pt-0 bg-white px-4">
     <div class="w-full sm:max-w-md mt-6 py-10 px-8 lg:px-12 border-2 border-amber-400 shadow-md overflow-hidden rounded-lg">
         {{$slot}}
     </div>
    <div class="fixed w-full flex bottom-8 left-0 items-center justify-center gap-6">
        <a class="underline text-sm text-gray-600 font-bold hover:text-gray-900" href="{{ route('password.request') }}">
            {{ __('Privacy Policy') }}
        </a>
        <a class="underline text-sm text-gray-600 font-bold hover:text-gray-900" href="{{ route('password.request') }}">
            {{ __('Terms and Condition') }}
        </a>
    </div>
</div>