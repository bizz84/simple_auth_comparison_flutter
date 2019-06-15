import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simple_auth_comparison_flutter/common_widgets/platform_exception_alert_dialog.dart';
import 'package:simple_auth_comparison_flutter/common_widgets/sign_in_button.dart';
import 'package:simple_auth_comparison_flutter/services/auth_service.dart';

class SignInPageValueNotifier extends StatelessWidget {
  const SignInPageValueNotifier({Key key, this.loading}) : super(key: key);
  final ValueNotifier<bool> loading;

  static Widget create(BuildContext context) {
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      builder: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, ValueNotifier<bool> isLoading, __) => SignInPageValueNotifier(
              loading: isLoading,
            ),
      ),
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      loading.value = true;
      final auth = Provider.of<AuthService>(context);
      await auth.signInAnonymously();
    } on PlatformException catch (e) {
      await PlatformExceptionAlertDialog(
        title: 'Sign in failed',
        exception: e,
      ).show(context);
    } finally {
      loading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SignInButton(
        text: 'Sign in',
        loading: loading.value,
        onPressed: () => _signInAnonymously(context),
      ),
    );
  }
}
