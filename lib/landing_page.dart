import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_auth_comparison_flutter/home_page.dart';
import 'package:simple_auth_comparison_flutter/services/auth_service.dart';
import 'package:simple_auth_comparison_flutter/sign_in/option.dart';
import 'package:simple_auth_comparison_flutter/sign_in/sign_in_page_navigation.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Used to keep track of navigation tab across sign-in events
    final authService = Provider.of<AuthService>(context);
    return ChangeNotifierProvider<ValueNotifier<Option>>(
      builder: (_) => ValueNotifier<Option>(Option.vanilla),
      // onAuthStateChanged
      child: StreamBuilder<User>(
        stream: authService.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return Consumer<ValueNotifier<Option>>(
                builder: (_, ValueNotifier<Option> option, __) =>
                    SignInPageNavigation(option: option),
              );
            }
            return HomePage();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
