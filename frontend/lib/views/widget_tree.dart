import 'package:flutter/material.dart';
import 'package:frontend/Data/notifiers.dart';
import 'package:frontend/views/pages/home_page.dart';
import 'package:frontend/views/pages/messages_page.dart';
import 'package:frontend/views/pages/profil_page.dart';
import 'package:frontend/views/pages/search_page.dart';
import 'package:frontend/views/pages/waredrobe_page.dart';

import 'widgets/navbar_widget.dart';

List<Widget> pages = [
  
  HomePage(),
  SearchPage(),
  WaredrobePage(),
  MessagesPage (),
  ProfilPage(),
  
];

class WidgetTree extends StatelessWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: selectedPageNotifier,
        builder: (BuildContext context, selectedPage, Widget? child) {
          return  pages.elementAt(selectedPage);
        },
      ),
        bottomNavigationBar: NavbarWidget()
      );
  }
}