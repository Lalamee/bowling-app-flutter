import 'package:flutter/material.dart';
import '../screens/orders/orders_screen.dart';
import '../screens/club_screen.dart';
import '../screens/mechanic_profile_screen.dart';

class BottomNavDirect {
  static void go(BuildContext context, int current, int tapped) {
    if (tapped == current) return;
    switch (tapped) {
      case 0:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OrdersScreen()));
        break;
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const _CatalogStub()));
        break;
      case 2:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const ClubScreen()));
        break;
      case 3:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MechanicProfileScreen()));
        break;
    }
  }
}

class _CatalogStub extends StatelessWidget {
  const _CatalogStub({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: Center(child: Text('Каталог'))));
  }
}
