<header class="header" id="site-header">
	<div class="container">
		<div class="header-content-wrapper">
			<a href="{{route('welcome')}}" class="site-logo">
				<img src="/logo.png" alt="Woox">
				<span class="" style="font-weight: 800; color: white;">
                    {{ config('app.name')}}
                </span>
			</a>

			<nav id="primary-menu" class="primary-menu">

				<!-- menu-icon-wrapper -->

				<a href='javascript:void(0)' id="menu-icon-trigger" class="menu-icon-trigger showhide">
					<span class="mob-menu--title">Menu</span>
					<span id="menu-icon-wrapper" class="menu-icon-wrapper">
						<svg width="1000px" height="1000px">
							<path id="pathD" d="M 300 400 L 700 400 C 900 400 900 750 600 850 A 400 400 0 0 1 200 200 L 800 800"></path>
							<path id="pathE" d="M 300 500 L 700 500"></path>
							<path id="pathF" d="M 700 600 L 300 600 C 100 600 100 200 400 150 A 400 380 0 1 1 200 800 L 800 200"></path>
						</svg>
					</span>
				</a>

				<ul class="primary-menu-menu">
					<li>
						<a href="/">Home</a>
					</li>

                    <li>
						<a href="/">About</a>
					</li>

                    <li>
						<a href="/">Mining</a>
					</li>

                    <li>
						<a href="/">Passive Income</a>
					</li>

                    <li>
						<a href="/">Loan</a>
					</li>


					<li class="">
						<a href="011_contacts.html">Contacts</a>
					</li>
				</ul>

			</nav>

			<button class="btn btn--medium btn--transparent btn--secondary">
                Account
            </button>

		</div>
	</div>
</header>