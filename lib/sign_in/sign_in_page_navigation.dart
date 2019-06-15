import 'package:flutter/material.dart';
import 'package:simple_auth_comparison_flutter/sign_in/menu_switcher.dart';
import 'package:simple_auth_comparison_flutter/sign_in/tabs/sign_in_page_bloc.dart';
import 'package:simple_auth_comparison_flutter/sign_in/tabs/sign_in_page_set_state.dart';
import 'package:simple_auth_comparison_flutter/sign_in/tabs/sign_in_page_value_notifier.dart';
import 'package:simple_auth_comparison_flutter/sign_in/tabs/sign_in_page_vanilla.dart';

enum NavigationTab {
  vanilla,
  setState,
  bloc,
  valueNotifier,
}

class TabData {
  TabData(this.iconData, this.title);
  final IconData iconData;
  final String title;
}

Map<NavigationTab, TabData> _tabs = {
  NavigationTab.vanilla: TabData(Icons.check_box_outline_blank, 'vanilla'),
  NavigationTab.setState: TabData(Icons.adjust, 'setState'),
  NavigationTab.bloc: TabData(Icons.clear_all, 'bloc'),
  NavigationTab.valueNotifier: TabData(Icons.autorenew, 'valueNotifier'),
};

class SignInPageNavigation extends StatelessWidget {
  const SignInPageNavigation({Key key, this.tab}) : super(key: key);
  final ValueNotifier<NavigationTab> tab;

  NavigationTab get _tab => tab.value;
  TabData get _tabData => _tabs[_tab];

  void _onSelectTab(NavigationTab selectedTab) {
    tab.value = selectedTab;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tabData.title),
      ),
      drawer: MenuSwitcher(
        tabs: _tabs,
        selectedTab: _tab,
        onSelected: _onSelectTab,
      ),
      body: _buildContent(context),
      //bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (_tab) {
      case NavigationTab.vanilla:
        return SignInPageVanilla();
      case NavigationTab.setState:
        return SignInPageSetState();
      case NavigationTab.bloc:
        return SignInPageBloc.create(context);
      case NavigationTab.valueNotifier:
        return SignInPageValueNotifier.create(context);
      default:
        return Container();
    }
  }
}
