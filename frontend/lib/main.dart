import '''package:flutter/material.dart''';
import 'package:frontend/views/pages/login_page.dart';

import 'package:frontend/views/widget_tree.dart';

void main() {
  runApp(const MyApp());
}

//Material App
//Scaffhold
//AppBar
//bottom navigataion bar

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
     
      theme: ThemeData(
        
        textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Colors.white, // Hier die gewünschte Farbe setzen
    selectionColor: Colors.white24,
    selectionHandleColor: Colors.white,
  ),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.dark,
          background: Colors.black,
          surface: Colors.black,
        ),
        navigationBarTheme: NavigationBarThemeData(
          indicatorColor: Colors.transparent,
          indicatorShape: null,
        
          overlayColor: WidgetStateProperty.all(Colors.transparent),
          iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
            if (states.contains(WidgetState.selected)) {
              return IconThemeData(
                
                color: const Color.fromARGB(
                  255,
                  255,
                  255,
                  255,
                ), // Leuchtende Farbe
                size: 29,
                shadows: [
                  Shadow(
                    color: const Color.fromARGB(
                      255,
                      255,
                      255,
                      255,
                    ).withOpacity(0),
                    blurRadius: 20,
                    offset: Offset(0, 0),
                  ),
                ],
              );
            }
            return IconThemeData(
              color: const Color.fromARGB(255, 171, 171, 171),
              size: 24,
            );
          }),
          labelTextStyle: WidgetStateProperty.all(
            TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
      ),
   home: LoginPage(), // ✅ Start here
    );
  }
}
