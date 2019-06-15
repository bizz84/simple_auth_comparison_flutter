import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_auth_comparison_flutter/home_page.dart';
import 'package:simple_auth_comparison_flutter/sign_in/option.dart';
import 'package:simple_auth_comparison_flutter/sign_in/sign_in_page_navigation.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Used to keep track of navigation tab across sign-in events
    return ChangeNotifierProvider<ValueNotifier<Option>>(
      builder: (_) => ValueNotifier<Option>(Option.vanilla),
      // onAuthStateChanged
      child: StreamBuilder<FirebaseUser>(
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            FirebaseUser user = snapshot.data;
            if (user == null) {
              return Consumer<ValueNotifier<Option>>(
                  builder: (_, ValueNotifier<Option> option, __) => SignInPageNavigation(option: option),
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
