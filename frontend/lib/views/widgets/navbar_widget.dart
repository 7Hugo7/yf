import 'package:flutter/material.dart';
import 'package:frontend/Data/notifiers.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: ( context,  selectedPage, child) {
        return NavigationBar(
          height: 30,
          backgroundColor: Colors.black,
          destinations: [
            NavigationDestination(icon: Icon(Icons.home), label: ''),
            NavigationDestination(icon: Icon(Icons.search), label: ''),
            NavigationDestination(icon: Icon(Icons.add), label: ''),
            NavigationDestination(icon: Icon(Icons.message), label: ''),
            NavigationDestination(icon: Icon(Icons.person), label: ''),
          ],
          onDestinationSelected: (int value) {
            selectedPageNotifier.value = value;
          },
          selectedIndex: selectedPage,
        );
      },
    );
  }
}