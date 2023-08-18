import 'package:auto_route/auto_route.dart';
import 'package:event_reminder_app/features/authentication/login/view/login_view.dart';
import 'package:event_reminder_app/features/home/base/view/home_view.dart';
import 'package:event_reminder_app/features/splash/view/splash_view.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends _$AppRouter {
  @override
  List<CustomRoute> get routes => [
        CustomRoute(
          page: SplashRoute.page,
          path: '/',
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 400,
        ),
        CustomRoute(
          page: HomeRoute.page,
          path: '/homeView',
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 400,
        ),
        CustomRoute(
          page: LoginRoute.page,
          path: '/loginView',
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 400,
        ),
      ];
}
