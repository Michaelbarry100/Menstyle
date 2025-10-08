<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="csrf-token" content="{{ csrf_token() }}">

        <title>{{ config('app.name', 'Laravel') }}</title>

        <link href="/assets/fonts/feather/feather.css" rel="stylesheet">
        <link href="/assets/libs/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
        <link href="/assets/libs/dragula/dist/dragula.min.css" rel="stylesheet" />
        <link href="/assets/libs/%40mdi/font/css/materialdesignicons.min.css" rel="stylesheet" />
        <link href="/assets/libs/dropzone/dist/dropzone.css" rel="stylesheet" />
        <link href="/assets/libs/magnific-popup/dist/magnific-popup.css" rel="stylesheet" />
        <link href="/assets/libs/bootstrap-select/dist/css/bootstrap-select.min.css" rel="stylesheet">
        <link href="/assets/libs/%40yaireo/tagify/dist/tagify.css" rel="stylesheet">
        <link href="/assets/libs/tiny-slider/dist/tiny-slider.css" rel="stylesheet">
        <link href="/assets/libs/tippy.js/dist/tippy.css" rel="stylesheet">
        <link href="/assets/libs/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet">
        <link href="/assets/libs/prismjs/themes/prism-okaidia.min.css" rel="stylesheet">
        <!-- Theme CSS -->
        <link rel="stylesheet" href="/assets/css/theme.min.css">
    
    </head>
    <body>
        <div class="container d-flex flex-column">
            <div class="row align-items-center justify-content-center g-0 min-vh-100">
                <div class="col-lg-5 col-md-8 py-8 py-xl-0">
                    @yield('content')
                </div>
            </div>
        </div>
    </body>
    <script src="assets/js/theme.min.js"></script>
</html>
