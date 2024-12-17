import 'package:flutter/material.dart';
import 'package:verbat/view/screens/dashboard_screen.dart';
import 'package:verbat/view/screens/device_screen.dart';
import 'package:verbat/view/screens/login_screen.dart';
import 'package:verbat/view/screens/my_screen.dart';
import 'package:verbat/view/screens/registration_screen.dart';

class RouteGen {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // final arguments = settings.arguments;
    switch (settings.name) {
      case Routes.loginScreen:
        return _buildRoute(const LoginScreen(), settings: settings);
      case Routes.dashBoard:
        return _buildRoute(const DashBoardScreen(), settings: settings);
      case Routes.registration:
        return _buildRoute(const RegistrationScreen(), settings: settings);

      case Routes.news:
        return _buildRoute(const DeviceScreen(), settings: settings);

      case Routes.myscreen:
        return _buildRoute(MyScreen(), settings: settings);

      default:
        return _buildRoute(const ErrorView(),
            settings: settings); // Handle unknown routes
    }
  }

  static Route<dynamic> _buildRoute(Widget page,
      {required RouteSettings settings}) {
    return MaterialPageRoute(
      builder: (context) => page,
      settings: settings,
    );
  }
}

class Routes {
  static const loginScreen = "/login";
  static const dashBoard = "/dashBoardScreen";
  static const registration = "/registration";
  static const news = "/new";
  static const myscreen = "/screen";
}

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Page'),
      ),
      body: const Center(
        child: Text(
          "404 - Page Not Found!",
          style: TextStyle(
            fontSize: 42.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
