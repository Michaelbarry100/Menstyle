<x-guest-layout>
    <x-auth-card>
        <x-auth-card-logo />

        <div class="mb-4 text-sm text-gray-600">
            {{ __('This is a secure area of the application. Please confirm your password before continuing.') }}
        </div>

        <x-jet-validation-errors class="mb-4" />

        <form method="POST" action="{{ route('password.confirm') }}">
            @csrf

            <div>
                <x-jet-label for="password" value="{{ __('Password') }}" />
                <x-jet-input id="password" class="block mt-1 w-full" type="password" name="password" required autocomplete="current-password" autofocus />
            </div>

    

            <div class="w-full mt-6">
                <x-jet-button class="w-full text-center flex items-center hover:bg-primary/80 justify-center text-bold py-4 bg-primary">
                    {{ __('Confirm') }}
                </x-jet-button>
            </div>
        </form>
    </x-auth-card>
</x-guest-layout>
