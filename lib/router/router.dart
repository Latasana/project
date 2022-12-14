import 'package:auto_route/annotations.dart';
import 'package:homeservice/onboarding/login.page.dart';
import 'package:homeservice/onboarding/register.dart';
import 'package:homeservice/pages/allservice.dart';
import 'package:homeservice/pages/detail.page.dart';
import 'package:homeservice/pages/home.dart';
import 'package:homeservice/pages/profile.page.dart';
import 'package:homeservice/pages/splash_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: SplashscreenPage, initial: true),
    AutoRoute(page: LoginPage),
    AutoRoute(page: HomePage),
    AutoRoute(page: DetailPage),
    AutoRoute(page: ProfilePage),
    AutoRoute(page: RegisterPage),
    AutoRoute(page: AllservicePage),
  ],
)
class $AppRouter {}
