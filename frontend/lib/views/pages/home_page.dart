import 'package:flutter/material.dart';
import 'package:frontend/views/pages/homepages/fn_page.dart';
import 'package:frontend/views/pages/homepages/for_you_page.dart';
import 'package:frontend/views/pages/homepages/fw_page.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     appBar: PreferredSize(
  preferredSize: const Size.fromHeight(60),
  child: SafeArea(
    child: Column(
      children: [
        const SizedBox(height: 4),
        TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          indicator: BoxDecoration(), // keine Linie
          indicatorWeight: 0,
          indicatorColor: Colors.transparent,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          isScrollable: false,
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          tabs: const [
            Tab(text: 'FN'),
            Tab(text: 'FY'),
            Tab(text: 'FW'),
          ],
        ),
        const SizedBox(height: 2),
      ],
    ),
  ),
  // **AppBar flach machen**
),

      body: TabBarView(
        controller: _tabController,
        children: const [
          FNPage(),
          FYPage(),
          FWPage(),
        ],
      ),
    );
  }
}
