import 'package:flutter/material.dart';

enum Option {
  vanilla,
  setState,
  bloc,
  valueNotifier,
  rxdart,
}

class OptionData {
  OptionData(this.iconData, this.title);
  final IconData iconData;
  final String title;
}

Map<Option, OptionData> optionsData = {
  Option.vanilla: OptionData(Icons.check_box_outline_blank, 'vanilla'),
  Option.setState: OptionData(Icons.adjust, 'setState'),
  Option.bloc: OptionData(Icons.clear_all, 'bloc'),
  Option.valueNotifier: OptionData(Icons.autorenew, 'valueNotifier'),
  Option.rxdart: OptionData(Icons.autorenew, 'RxDart'),
};
