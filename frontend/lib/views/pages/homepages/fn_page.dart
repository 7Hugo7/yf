import 'package:flutter/material.dart';
import 'package:frontend/views/pages/homepages/detail_page.dart';

class FNPage extends StatelessWidget {
  const FNPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,          // 2 Spalten
        mainAxisSpacing: 8,         // vertikaler Abstand
        crossAxisSpacing: 8,        // horizontaler Abstand
        childAspectRatio: 0.75,     // Verhältnis Höhe zu Breite
      ),
      itemCount: 12, // Beispiel: 12 Platzhalter
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(index: index),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.white10),
            ),
            child: const Center(
              child: Icon(Icons.image, color: Colors.white54, size: 40),
            ),
          ),
        );
      },
    );
  }
}
