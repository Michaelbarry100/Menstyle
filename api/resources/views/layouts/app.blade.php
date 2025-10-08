<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="csrf-token" content="{{ csrf_token() }}">

        <title>{{ config('app.name', 'Laravel') }}</title>

        <!-- Fonts -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700&display=swap">

        <!-- Libs CSS -->
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
        <link rel="stylesheet" href="/assets/css/theme.min.css">

        @livewireStyles

    </head>
    <body>

        <div class="pt-5 pb-5">
            <div class="container">
                <!-- User info -->
                <div class="row align-items-center">
                    <div class="col-xl-12 col-lg-12 col-md-12 col-12">
                        <!-- Bg -->
                        <div class="pt-16 rounded-top-md" style="
                                    background: url(/img/profile-bg.jpg) no-repeat;
                                    background-size: cover;
                                "></div>
                        <div
                            class="d-flex align-items-end justify-content-between bg-white px-4 pt-2 pb-4 rounded-none rounded-bottom-md shadow-sm">
                            <div class="d-flex align-items-center">
                                <div class="me-2 position-relative d-flex justify-content-end align-items-end mt-n5">
                                    <img src="{{auth()->user()->getProfilePhotoUrlAttribute()}}"
                                        class="avatar-xl rounded-circle  border-4 border-white position-relative"
                                        alt="" />
                                </div>
                                <div class="lh-1">
                                    <h2 class="mb-0">Admin</h2>
                                    <p class="mb-0 d-block">@admin</p>
                                </div>
                            </div>
                            <div>
                                <a href="#" onclick="event.preventDefault(); logout();" class="btn btn-danger btn-sm d-none d-md-block">Logout</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Content -->

                <div class="row mt-0 mt-md-4">
                    <div class="col-lg-3 col-md-4 col-12">
                        <!-- User profile -->
                        <nav class="navbar navbar-expand-md navbar-light shadow-sm mb-4 mb-lg-0 sidenav">
                            <!-- Menu -->
                            <a class="d-xl-none d-lg-none d-md-none text-inherit fw-bold" href="#">Menu</a>
                            <!-- Button -->
                            <button class="navbar-toggler d-md-none icon-shape icon-sm rounded bg-primary text-light"
                                type="button" data-bs-toggle="collapse" data-bs-target="#sidenav" aria-controls="sidenav"
                                aria-expanded="false" aria-label="Toggle navigation">
                                <span class="fe fe-menu"></span>
                            </button>
                            <!-- Collapse -->
                            <div class="collapse navbar-collapse" id="sidenav">
                                <div class="navbar-nav flex-column">
                                    <span class="navbar-header">Dashboard</span>
                                    <ul class="list-unstyled ms-n2 mb-4">
                                        <!-- Nav item -->
                                        <li class="nav-item {{Route::is('dashboard')  ? 'active' : ''}}">
                                            <a class="nav-link" href="{{route('dashboard')}}"><i
                                                    class="fe fe-home nav-icon"></i>
                                                Dashboard</a>
                                        </li>
                                        <!-- Nav item -->
                                        <li class="nav-item {{Route::is('collection' ? 'active' : '')}}">
                                            <a class="nav-link" href="{{route('collections')}}"><i
                                                    class="fe fe-book nav-icon"></i>Collections</a>
                                        </li>
                                        <!-- Nav item -->
                                        <li class="nav-item {{Route::is('categories' ? 'active' : '')}}">
                                            <a class="nav-link" href="{{route('categories')}}"><i
                                                    class="fe fe-star nav-icon"></i>Categories</a>
                                        </li>
                                        <!-- Nav item -->
                                        <li class="nav-item {{Route::is('items' ? 'active' : '')}}">
                                            <a class="nav-link" href="{{route('items')}}"><i
                                                    class="fe fe-pie-chart nav-icon"></i>Items</a>
                                        </li>
                                        <!-- Nav item -->
                                        
                                    </ul>
                                   
                                </div>
                            </div>
                        </nav>
                    </div>
                    <div class="col-lg-9 col-md-8 col-12">
                        @yield('content')
                    </div>
                </div>
            </div>
        </div>
        
        <form action="{{route('logout')}}" method="Post" style="display: none;" id="logout-form">
            @csrf
        </form>
        @livewireScripts
        <script src="/assets/libs/jquery/dist/jquery.min.js"></script>
        <script src="/assets/libs/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
        <script src="/assets/libs/odometer/odometer.min.js"></script>
        <script src="/assets/libs/jquery-slimscroll/jquery.slimscroll.min.js"></script>
        <script src="/assets/libs/magnific-popup/dist/jquery.magnific-popup.min.js"></script>
        <script src="/assets/libs/bootstrap-select/dist/js/bootstrap-select.min.js"></script>
        <script src="/assets/libs/flatpickr/dist/flatpickr.min.js"></script>
        <script src="/assets/libs/inputmask/dist/jquery.inputmask.min.js"></script>
        <script src="/assets/libs/apexcharts/dist/apexcharts.min.js"></script>
        <script src="/assets/libs/quill/dist/quill.min.js"></script>
        <script src="/assets/libs/file-upload-with-preview/dist/file-upload-with-preview.min.js"></script>
        <script src="/assets/libs/dragula/dist/dragula.min.js"></script>
        <script src="/assets/libs/bs-stepper/dist/js/bs-stepper.min.js"></script>
        <script src="/assets/libs/dropzone/dist/min/dropzone.min.js"></script>
        <script src="/assets/libs/jQuery.print/jQuery.print.js"></script>
        <script src="/assets/libs/prismjs/prism.js"></script>
        <script src="/assets/libs/prismjs/components/prism-scss.min.js"></script>
        <script src="/assets/libs/%40yaireo/tagify/dist/tagify.min.js"></script>
        <script src="/assets/libs/tiny-slider/dist/min/tiny-slider.js"></script>
        <script src="/assets/libs/%40popperjs/core/dist/umd/popper.min.js"></script>
        <script src="/assets/libs/tippy.js/dist/tippy-bundle.umd.min.js"></script>
        <script src="/assets/libs/typed.js/lib/typed.min.js"></script>
        <script src="/assets/libs/jsvectormap/dist/js/jsvectormap.min.js"></script>
        <script src="/assets/libs/jsvectormap/dist/maps/world.js"></script>
        <script src="/assets/libs/datatables.net/js/jquery.dataTables.min.js"></script>
        <script src="/assets/libs/datatables.net-bs5/js/dataTables.bootstrap5.min.js"></script>
        <script src="/assets/libs/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
        <script src="/assets/libs/datatables.net-responsive-bs5/js/responsive.bootstrap5.min.js"></script>
        <script src="/assets/libs/prismjs/plugins/toolbar/prism-toolbar.min.js"></script>
        <script src="/assets/libs/prismjs/plugins/copy-to-clipboard/prism-copy-to-clipboard.min.js"></script>
        <script src="/assets/libs/fullcalendar/main.min.js"></script>
        
        <script>
            function logout(){
                document.getElementById('logout-form').submit();
            }
        </script>

        <!-- Theme JS -->
        <script src="/assets/js/theme.min.js"></script>
        <!-- CDN File for moment -->
        <script src='https://cdn.jsdelivr.net/npm/moment@2.29.1/min/moment.min.js'></script>
    </body>
</html>
