import 'package:assety/features/analytics/presentation/screens/chart_screen.dart';
import 'package:assety/features/transactions/presentation/screens/transactions_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    TransactionsScreen(), // Home
    AnalyticsScreen(),    // Analytics (заглушка)
    // ProfileScreen(),      // Profile (заглушка)

    // TransactionsScreen(),
    TransactionsScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],


      bottomNavigationBar: BottomAppBar(
        color: const Color(0xFF1E1E1E),
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 64,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildTabItem(
                index: 0,
                icon: Icons.home,
                label: 'Home',
              ),
              _buildTabItem(
                index: 1,
                icon: Icons.pie_chart,
                label: 'Analytics',
              ),
              _buildTabItem(
                index: 2,
                icon: Icons.person,
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _selectedIndex == index;
    final color = isSelected ? Colors.blue : Colors.grey;

    return InkWell(
      onTap: () => _onTabTapped(index),
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(color: color, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
