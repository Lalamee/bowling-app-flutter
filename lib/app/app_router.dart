import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../screens/splash_screen.dart';
import '../screens/welcome_screen.dart';
import '../screens/register_role_selection.dart';
import '../screens/orders/orders_screen.dart';
import '../screens/club_screen.dart';
import '../screens/mechanic_profile_screen.dart';

class Routes {
  static const splash = '/';
  static const welcome = '/welcome';
  static const registerRole = '/register-role';
  static const orders = '/orders';
  static const catalog = '/catalog';
  static const club = '/club';
  static const profile = '/profile';
}

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case Routes.registerRole:
        return MaterialPageRoute(builder: (_) => const RegisterRoleSelectionScreen());
      case Routes.orders:
        return MaterialPageRoute(builder: (_) => const OrdersScreen());
      case Routes.catalog:
        return MaterialPageRoute(builder: (_) => const _CatalogStub());
      case Routes.club:
        return MaterialPageRoute(builder: (_) => const ClubScreen());
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => const MechanicProfileScreen());
      default:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
    }
  }
}

class _CatalogStub extends StatelessWidget {
  const _CatalogStub({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Center(child: Text('Каталог', style: TextStyle(fontSize: 18, color: AppColors.textDark)))),
    );
  }
}
