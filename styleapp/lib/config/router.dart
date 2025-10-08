import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:styleapp/cubits/request/request_cubit.dart';
import 'package:styleapp/data/models/styles.dart';
import 'package:styleapp/pages/pages.dart';
import '../bloc/app/app_bloc.dart';
import '../screen/screen.dart';
import '../utils/transition.dart';

class AppRouter {
  late ApplicationBloc appBloc;
  AppRouter(this.appBloc);
  final GoRouter router = GoRouter(
      errorBuilder: (context, state) => const ErrorScreen(),
      redirect: (BuildContext context, GoRouterState state) async {
        final appState = context.read<ApplicationBloc>().state;
        final path = state.path;
        if (appState is AppInitial) {
          return '/splash';
        } else if (appState is AppStarted && path == '/splash') {
          return '/';
        }
      },
      initialLocation: '/',
      routes: <GoRoute>[
        GoRoute(
          path: '/splash',
          name: 'splash',
          builder: (BuildContext context, GoRouterState state) {
            return SplashScreen();
          },
        ),
        GoRoute(
          path: '/',
          pageBuilder: (BuildContext context, GoRouterState state) {
            return animatePage(
                context: context,
                child: BlocProvider<RequestCubit>(
                  create: (context) => RequestCubit(
                    appBloc: BlocProvider.of<ApplicationBloc>(context),
                  ),
                  child: const HomeScreen(),
                ),
                key: state.pageKey);
          },
        ),
        GoRoute(
          path: '/collections',
          name: "collections",
          pageBuilder: (BuildContext context, GoRouterState state) {
            return animatePage(
                context: context,
                child: BlocProvider<RequestCubit>(
                  create: (context) => RequestCubit(
                    appBloc: BlocProvider.of<ApplicationBloc>(context),
                  ),
                  child: const CollectionPage(),
                ),
                key: state.pageKey);
          },
        ),
        GoRoute(
          path: '/categories',
          name: "categories",
          pageBuilder: (BuildContext context, GoRouterState state) {
            var extra = state.extra ?? {};
            var query = extra as Map;
            var collection = query['collection'] as int?;
            return animatePage(
              context: context,
              child: BlocProvider<RequestCubit>(
                create: (context) => RequestCubit(
                  appBloc: BlocProvider.of<ApplicationBloc>(context),
                ),
                child: CategoriesPage(
                  collection: collection,
                ),
              ),
              key: state.pageKey,
            );
          },
        ),
        GoRoute(
            path: '/designs',
            name: "designs",
            pageBuilder: (BuildContext context, GoRouterState state) {
              var extra = state.extra ?? {};
              var query = extra as Map;
              var premium =
                  query['premium'] != null && query['premium'] == true;
              var category = query['category'] as int?;

              return animatePage(
                context: context,
                child: BlocProvider<RequestCubit>(
                  create: (context) => RequestCubit(
                    appBloc: BlocProvider.of<ApplicationBloc>(context),
                  ),
                  child: StylesPage(
                    isPremium: premium,
                    category: category,
                  ),
                ),
                key: state.pageKey,
              );
            },
            ),
            GoRoute(
          path: '/favorites',
          name: 'favorites',
          pageBuilder: (BuildContext context, GoRouterState state) {
            // var isPremium = state.pa
            return animatePage(
              context: context,
              child: BlocProvider<RequestCubit>(
                create: (context) => RequestCubit(
                  appBloc: BlocProvider.of<ApplicationBloc>(context),
                ),
                child: const FavoritesPage(),
              ),
              key: state.pageKey,
            );
          },
        ),
        GoRoute(
          path: '/design',
          name: "design",
          pageBuilder: (BuildContext context, GoRouterState state) {
            var style = state.extra as Style;
            return animatePage(
              context: context,
              child: BlocProvider<RequestCubit>(
                create: (context) => RequestCubit(
                  appBloc: BlocProvider.of<ApplicationBloc>(context),
                ),
                child: DesignPage(style: style),
              ),
              key: state.pageKey,
            );
          },
        ),
      ]);
}
