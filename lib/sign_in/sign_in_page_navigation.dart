import 'package:flutter/material.dart';
import 'package:simple_auth_comparison_flutter/sign_in/menu_switcher.dart';
import 'package:simple_auth_comparison_flutter/sign_in/option.dart';
import 'package:simple_auth_comparison_flutter/sign_in/pages/sign_in_page_bloc.dart';
import 'package:simple_auth_comparison_flutter/sign_in/pages/sign_in_page_set_state.dart';
import 'package:simple_auth_comparison_flutter/sign_in/pages/sign_in_page_value_notifier.dart';
import 'package:simple_auth_comparison_flutter/sign_in/pages/sign_in_page_vanilla.dart';

class SignInPageNavigation extends StatelessWidget {
  const SignInPageNavigation({Key key, this.option}) : super(key: key);
  final ValueNotifier<Option> option;

  Option get _option => option.value;
  OptionData get _optionData => optionsData[_option];

  void _onSelectOption(Option selectedOption) {
    option.value = selectedOption;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_optionData.title),
      ),
      drawer: MenuSwitcher(
        options: optionsData,
        selectedOption: _option,
        onSelected: _onSelectOption,
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (_option) {
      case Option.vanilla:
        return SignInPageVanilla();
      case Option.setState:
        return SignInPageSetState();
      case Option.bloc:
        return SignInPageBloc.create(context);
      case Option.valueNotifier:
        return SignInPageValueNotifier.create(context);
      default:
        return Container();
    }
  }
}
