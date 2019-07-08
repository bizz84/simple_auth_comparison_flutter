import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:simple_auth_comparison_flutter/common_widgets/platform_exception_alert_dialog.dart';
import 'package:simple_auth_comparison_flutter/common_widgets/sign_in_button.dart';
import 'package:simple_auth_comparison_flutter/services/auth_service.dart';

class SignInBloc {
  final _loadingController = StreamController<bool>();
  Stream<bool> get loadingStream => _loadingController.stream;

  void setIsLoading(bool loading) => _loadingController.add(loading);

  dispose() {
    _loadingController.close();
  }
}

class SignInPageBloc extends StatelessWidget {
  const SignInPageBloc({Key key, @required this.bloc}) : super(key: key);
  final SignInBloc bloc;

  static Widget create(BuildContext context) {
    return Provider<SignInBloc>(
      builder: (_) => SignInBloc(),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<SignInBloc>(
        builder: (_, bloc, __) => SignInPageBloc(bloc: bloc),
      ),
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      bloc.setIsLoading(true);
      final auth = Provider.of<AuthService>(context);
      await auth.signInAnonymously();
    } on PlatformException catch (e) {
      await PlatformExceptionAlertDialog(
        title: 'Sign in failed',
        exception: e,
      ).show(context);
    } finally {
      bloc.setIsLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: bloc.loadingStream,
        initialData: false,
        builder: (context, snapshot) {
          final isLoading = snapshot.data;
          return Center(
            child: SignInButton(
              text: 'Sign in',
              loading: isLoading,
              onPressed: isLoading ? null : () => _signInAnonymously(context),
            ),
          );
        });
  }
}
