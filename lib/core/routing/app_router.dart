import 'package:flutter/material.dart';
import 'routes.dart';
import 'route_args.dart';

import '../../features/onboarding/presentation/screens/splash_screen.dart';
import '../../features/onboarding/presentation/screens/splash_first_time.dart';
import '../../features/onboarding/presentation/screens/welcome_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/onboarding/presentation/screens/register_role_selection.dart';

import '../../features/register/mechanic/presentation/screens/register_mechanic_screen.dart';
import '../../features/register/owner/presentation/screens/register_owner_screen.dart';

import '../../features/orders/presentation/screens/orders_screen.dart';
import '../../features/orders/presentation/screens/order_summary_screen.dart';

import '../../features/clubs/presentation/screens/club_screen.dart';
import '../../features/clubs/presentation/screens/club_search_screen.dart';
import '../../features/clubs/presentation/screens/club_warehouse_screen.dart';

import '../../features/profile/mechanic/presentation/screens/mechanic_profile_screen.dart';
import '../../features/profile/mechanic/presentation/screens/edit_mechanic_profile_screen.dart';

import '../../features/knowledge_base/presentation/screens/knowledge_base_screen.dart';
import '../../features/knowledge_base/presentation/screens/pdf_reader_screen.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case Routes.splashFirstTime:
        return MaterialPageRoute(builder: (_) => const SplashFirstTime());
      case Routes.welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      case Routes.registerRole:
        return MaterialPageRoute(builder: (_) => const RegisterRoleSelectionScreen());
      case Routes.registerMechanic:
        return MaterialPageRoute(builder: (_) => const RegisterMechanicScreen());
      case Routes.registerOwner:
        return MaterialPageRoute(builder: (_) => const RegisterOwnerScreen());
      case Routes.orders:
        return MaterialPageRoute(builder: (_) => const OrdersScreen());
      case Routes.orderSummary: {
        final args = settings.arguments as OrderSummaryArgs?;
        if (args == null) return MaterialPageRoute(builder: (_) => const OrdersScreen());
        return MaterialPageRoute(builder: (_) => OrderSummaryScreen(orderId: args.orderId));
      }
      case Routes.club:
        return MaterialPageRoute(builder: (_) => const ClubScreen());
      case Routes.clubSearch:
        return MaterialPageRoute(builder: (_) => const ClubSearchScreen());
      case Routes.clubWarehouse:
        return MaterialPageRoute(builder: (_) => const ClubWarehouseScreen());
      case Routes.profileMechanic:
        return MaterialPageRoute(builder: (_) => const MechanicProfileScreen());
      case Routes.editMechanicProfile: {
        final args = settings.arguments as EditMechanicProfileArgs?;
        return MaterialPageRoute(builder: (_) => EditMechanicProfileScreen(mechanicId: args?.mechanicId));
      }
      case Routes.knowledgeBase:
        return MaterialPageRoute(builder: (_) => const KnowledgeBaseScreen());
      case Routes.pdfReader: {
        final args = settings.arguments as PdfReaderArgs?;
        if (args == null) return MaterialPageRoute(builder: (_) => const KnowledgeBaseScreen());
        return MaterialPageRoute(builder: (_) => PdfReaderScreen(assetPath: args.assetPath, title: args.title));
      }
    }
    return null;
  }
}
