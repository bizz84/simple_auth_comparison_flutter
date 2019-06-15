import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_auth_comparison_flutter/common_widgets/segmented_control.dart';
import 'package:simple_auth_comparison_flutter/services/auth_service.dart';
import 'package:simple_auth_comparison_flutter/services/auth_service_facade.dart';
import 'package:simple_auth_comparison_flutter/sign_in/sign_in_page_navigation.dart';

class MenuSwitcher extends StatelessWidget {
  const MenuSwitcher({Key key, this.tabs, this.selectedTab, this.onSelected}) : super(key: key);
  final Map<NavigationTab, TabData> tabs;
  final NavigationTab selectedTab;
  final ValueChanged<NavigationTab> onSelected;

  static const textStyle = TextStyle(fontSize: 16.0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Drawer(
        child: Column(
          children: <Widget>[
            _buildHeader(),
            _buildContents(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return DrawerHeader(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          Text(
            'Switcher',
            style: TextStyle(fontSize: 22.0, color: Colors.white),
          ),
        ],
      ),
      decoration: BoxDecoration(color: Colors.indigo),
    );
  }

  Widget _buildContents(BuildContext context) {
    return Expanded(
      child: ListView(
        children: <Widget>[
          _buildAuthTypeSwitch(context),
          SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('State Management', style: textStyle),
          ),
          ..._buildTabs(context),
        ],
      ),
    );
  }

  Widget _buildAuthTypeSwitch(BuildContext context) {
    final AuthServiceFacade authServiceFacade = Provider.of<AuthService>(context, listen: false);
    return ValueListenableBuilder<AuthServiceType>(
      valueListenable: authServiceFacade.authServiceTypeNotifier,
      builder: (_, AuthServiceType type, __) {
        return SegmentedControl<AuthServiceType>(
          header: Text('Authentication type', style: textStyle),
          value: type,
          onValueChanged: (AuthServiceType type) => authServiceFacade.authServiceTypeNotifier.value = type,
          children: const <AuthServiceType, Widget>{
            AuthServiceType.firebase: Text('Firebase'),
            AuthServiceType.mock: Text('Mock'),
          },
        );
      },
    );
  }

  List<Widget> _buildTabs(BuildContext context) => tabs.keys.map((tab) => _buildTile(context, tab)).toList();

  Widget _buildTile(BuildContext context, NavigationTab tab) {
    final data = tabs[tab];
    return ListTile(
      leading: Icon(data.iconData),
      title: Text(data.title, style: textStyle),
      trailing: selectedTab == tab ? Icon(Icons.check) : null,
      onTap: () {
        Navigator.of(context).pop();
        onSelected(tab);
      },
    );
  }
}
