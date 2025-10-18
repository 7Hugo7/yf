import 'package:flutter/material.dart';
import 'package:frontend/Data/notifiers.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
  return ValueListenableBuilder(
    valueListenable: selectedPageNotifier,
    builder: (context, selectedPage, child) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 0), // Abstand nach unten
        child: NavigationBar(
          height: 25, // Normale Höhe für Icons
      backgroundColor: Colors.transparent,
      
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide, // Labels ausblenden
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
        ),
      );
    },
  );
}
}