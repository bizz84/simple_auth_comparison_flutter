import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simple_auth_comparison_flutter/common_widgets/platform_exception_alert_dialog.dart';
import 'package:simple_auth_comparison_flutter/common_widgets/sign_in_button.dart';
import 'package:simple_auth_comparison_flutter/services/auth_service.dart';

class SignInPageVanilla extends StatelessWidget {
  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      final auth = Provider.of<AuthService>(context);
      await auth.signInAnonymously();
    } on PlatformException catch (e) {
      await PlatformExceptionAlertDialog(
        title: 'Sign in failed',
        exception: e,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SignInButton(
        text: 'Sign in',
        onPressed: () => _signInAnonymously(context),
      ),
    );
  }
}

