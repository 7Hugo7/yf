import 'package:flutter/material.dart';

import 'package:frontend/views/pages/homepages/detail_page.dart';

import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:math';

class FYPage extends StatefulWidget {
  const FYPage({super.key});

  @override
  State<FYPage> createState() => _FYPageState();
}

class _FYPageState extends State<FYPage> {
  final ScrollController _scrollController = ScrollController();
  List<double> _tileHeights = [];
  int _page = 0;
  final int _perPage = 20;
  bool _isLoading = false;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _loadMoreTiles();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 300 &&
          !_isLoading) {
        _loadMoreTiles();
      }
    });
  }

  void _loadMoreTiles() {
    setState(() => _isLoading = true);

    // Simuliere kleine Ladeverzögerung
    Future.delayed(const Duration(milliseconds: 500), () {
      List<double> newHeights = List.generate(
          _perPage, (_) => _random.nextDouble() * 100 + 150); // 150-250px
      setState(() {
        _tileHeights.addAll(newHeights);
        _page++;
        _isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double spacing = 4;

    return SingleChildScrollView(
      controller: _scrollController,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: spacing),
        child: Column(
          children: [
            Wrap(
              spacing: spacing,
              runSpacing: spacing,
              children: _tileHeights.map((height) {
                double tileWidth = (screenWidth - 3 * spacing) / 2; // 2 Spalten
                return Container(
                  width: tileWidth,
                  height: height,
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(Icons.image, color: Colors.white54, size: 40),
                  ),
                );
              }).toList(),
            ),
            if (_isLoading)
              const Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
          ],
        ),
      ),
    );
  }
}
