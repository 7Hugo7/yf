import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final int index;
  const DetailPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Detail $index'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Icon(Icons.image, size: 100, color: Colors.white54),
      ),
    );
  }
}
