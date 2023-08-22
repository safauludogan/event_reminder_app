import 'package:auto_route/auto_route.dart';
import 'package:event_reminder_app/features/authentication/login/view/signin_view.dart';
import 'package:event_reminder_app/features/authentication/register/register_view.dart';
import 'package:event_reminder_app/features/home/base/view/home_view.dart';
import 'package:event_reminder_app/features/splash/splash_view.dart';

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
          page: SignInRoute.page,
          path: '/signInViewView',
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 400,
        ),
        CustomRoute(
          page: RegisterRoute.page,
          path: '/registerView',
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 400,
        ),
      ];
}
