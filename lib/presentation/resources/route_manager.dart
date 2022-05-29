import 'package:clean_architecture/presentation/forgotPassword/forgot_password.dart';
import 'package:clean_architecture/presentation/login/login.dart';
import 'package:clean_architecture/presentation/main/main_view.dart';
import 'package:clean_architecture/presentation/onboarding/onboarding.dart';
import 'package:clean_architecture/presentation/register/register.dart';
import 'package:clean_architecture/presentation/resources/strings_manager.dart';
import 'package:clean_architecture/presentation/splash/splash.dart';
import 'package:clean_architecture/presentation/store_details/store_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes

{
  static const String splashRoute ="/";
  static const String onBoardingRoute ="/onboarding";
  static const String loginRoute ="/loginroute";
  static const String registerRoute ="/register";
  static const String forgotPasswordRoute ="/forgotPassword";
  static const String mainRoute ="/main";
  static const String storeDetailRoute ="/storeDetails";
}
class RouteGenerator
{
  static Route<dynamic> getRoute(RouteSettings routeSettings)
  {
    switch(routeSettings.name)
    {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (_)=>SplashView());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_)=>LoginView());
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_)=>OnBoardingView());
      case Routes.registerRoute:
        return MaterialPageRoute(builder: (_)=>RegisterView());
      case Routes.forgotPasswordRoute:
        return MaterialPageRoute(builder: (_)=>ForgotPassword());
      case Routes.mainRoute:
        return MaterialPageRoute(builder: (_)=>MainView());
      case Routes.storeDetailRoute:
        return MaterialPageRoute(builder: (_)=>StoreDetailsView());
      default:
        return undefinedRoute();

    }
  }
  static Route<dynamic> undefinedRoute()
  {
    return MaterialPageRoute(builder: (_)=>Scaffold(
      appBar: AppBar(title: Text(AppStrings.noRouteFound),

    ),
    body: Center(child: Text(AppStrings.noRouteFound )),
    ));
  }
}
