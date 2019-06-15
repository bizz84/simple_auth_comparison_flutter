import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simple_auth_comparison_flutter/common_widgets/platform_exception_alert_dialog.dart';
import 'package:simple_auth_comparison_flutter/common_widgets/sign_in_button.dart';
import 'package:simple_auth_comparison_flutter/services/auth_service.dart';

class SignInPageSetState extends StatefulWidget {
  @override
  _SignInPageSetStateState createState() => _SignInPageSetStateState();
}

class _SignInPageSetStateState extends State<SignInPageSetState> {
  bool _isLoading = false;

  Future<void> _signInAnonymously() async {
    try {
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthService>(context);
      await auth.signInAnonymously();
    } on PlatformException catch (e) {
      await PlatformExceptionAlertDialog(
        title: 'Sign in failed',
        exception: e,
      ).show(context);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SignInButton(
        text: 'Sign in',
        loading: _isLoading,
        onPressed: _isLoading ? null : () => _signInAnonymously(),
      ),
    );
  }
}
