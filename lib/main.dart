import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_auth_comparison_flutter/landing_page.dart';
import 'package:simple_auth_comparison_flutter/services/auth_service.dart';
import 'package:simple_auth_comparison_flutter/services/auth_service_facade.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
      builder: (_) => AuthServiceFacade(),
      dispose: (_, AuthService authService) => authService.dispose(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: LandingPage(),
      ),
    );
  }
}
