import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_auth_comparison_flutter/common_widgets/segmented_control.dart';
import 'package:simple_auth_comparison_flutter/services/auth_service.dart';
import 'package:simple_auth_comparison_flutter/services/auth_service_facade.dart';

class DeveloperMenu extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Drawer(
        child: Column(children: <Widget>[
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const <Widget>[
                Text(
                  'Developer Menu',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.indigo,
            ),
          ),
          _buildOptions(context),
        ]),
      ),
    );
  }

  Widget _buildOptions(BuildContext context) {
    final AuthServiceFacade authServiceFacade = Provider.of<AuthService>(context, listen: false);
    return ValueListenableBuilder<AuthServiceType>(
      valueListenable: authServiceFacade.authServiceTypeNotifier,
      builder: (_, AuthServiceType type, __) {
        return Expanded(
          child: ListView(
            children: <Widget>[
              SegmentedControl<AuthServiceType>(
                header: Text(
                  'Authentication type',
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                value: type,
                onValueChanged: (AuthServiceType type) => authServiceFacade.authServiceTypeNotifier.value = type,
                children: const <AuthServiceType, Widget>{
                  AuthServiceType.firebase: Text('Firebase'),
                  AuthServiceType.mock: Text('Mock'),
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

