import 'package:flutter/material.dart';
import 'package:simple_auth_comparison_flutter/tabs/sign_in_page_bloc.dart';
import 'package:simple_auth_comparison_flutter/tabs/sign_in_page_set_state.dart';
import 'package:simple_auth_comparison_flutter/tabs/sign_in_page_value_notifier.dart';
import 'package:simple_auth_comparison_flutter/tabs/sign_in_page_vanilla.dart';

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

  void _onSelectTab(int index) {
    tab.value =  NavigationTab.values[index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tabData.title),
      ),
      body: _buildContent(context),
      bottomNavigationBar: _buildBottomNavigationBar(),
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

  Widget _buildBottomNavigationBar() {
      return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: _tabs.keys.map(_buildItem).toList(),
        onTap: _onSelectTab,
      );
  }

  BottomNavigationBarItem _buildItem(NavigationTab tab) {
    final data = _tabs[tab];
    return BottomNavigationBarItem(
      icon: Icon(
        data.iconData,
        color: _colorTabMatching(tab),
      ),
      title: Text(
        data.title,
        style: TextStyle(
          color: _colorTabMatching(tab),
        ),
      ),
    );
  }

  Color _colorTabMatching(NavigationTab tab) {
    return _tab == tab ? Colors.indigo : Colors.grey;
  }
}
