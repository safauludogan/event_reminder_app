import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:event_reminder_app/core/base/viewmodel/base_viewmodel.dart';
import 'package:event_reminder_app/features/home/page1/page1_view.dart';
import 'package:event_reminder_app/features/home/page2/page2_view.dart';
import 'package:mobx/mobx.dart';
part 'home_viewmodel.g.dart';

class HomeViewModel = _HomeViewModelBase with _$HomeViewModel;

abstract class _HomeViewModelBase with Store, BaseViewModel {
  @override
  BuildContext setContext(BuildContext context) => baseContext = context;
  @override
  void init() {}

  @override
  void disp() {}

  @observable
  int pageIndex = 0;

  List<Widget> screens = [
    const Page1View(),
    const Page2View(),
    const Page2View(),
    const Page2View(),
  ];

  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(FluentIcons.home_12_regular),
      label: 'Home',
      activeIcon: Icon(FluentIcons.home_12_filled),
    ),
    BottomNavigationBarItem(
      icon: Icon(FluentIcons.person_12_regular),
      label: 'Profile',
      activeIcon: Icon(FluentIcons.person_12_filled),
    ),
    BottomNavigationBarItem(
      icon: Icon(FluentIcons.calendar_12_regular),
      label: 'Takvim',
      activeIcon: Icon(FluentIcons.calendar_12_filled),
    ),
    BottomNavigationBarItem(
      icon: Icon(FluentIcons.calendar_work_week_16_regular),
      label: 'İş Takip',
      activeIcon: Icon(FluentIcons.calendar_work_week_16_filled),
    ),
  ];

  set changePage(int value) {
    pageIndex = value;
  }
}
