import 'package:assety/features/analytics/presentation/screens/notifications_screen.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text('Аналітика', style: TextStyle(color: Colors.white)),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Графіки'),
              Tab(text: 'Сповіщення'),
            ],
            labelColor: Colors.white,
            indicatorColor: Colors.white,
          ),
        ),
        body: const TabBarView(
          children: [
            ChartsTab(),
            NotificationsTab()
          ],
        ),
      ),
    );
  }
}

class ChartsTab extends StatelessWidget {
  const ChartsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildCard(
          title: 'Витрати за категоріями',
          chart: _buildPieChart(),
        ),
        const SizedBox(height: 10),
        _buildCard(
          title: 'Доходи та витрати',
          chart: _buildBarChart(),
        ),
        const SizedBox(height: 10),
        _buildCard(
          title: 'Тренд балансу',
          chart: _buildLineChart(),
        ),
      ],
    );
  }

  Widget _buildCard({required String title, required Widget chart}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 12),
          SizedBox(height: 150, child: chart),
        ],
      ),
    );
  }

  Widget _buildPieChart() {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
              color: Colors.blue,
              badgeWidget: Icon(
                Icons.fastfood,
                color: const Color(0xFF1E1E1E),
              )),
          PieChartSectionData(
              color: Colors.red,
              badgeWidget: Icon(
                Icons.directions_car,
                color: const Color(0xFF1E1E1E),
              )),
          PieChartSectionData(
              color: Colors.green,
              badgeWidget: Icon(
                Icons.shopping_cart,
                color: const Color(0xFF1E1E1E),
              )),
          PieChartSectionData(
              color: Colors.orange,
              badgeWidget: Icon(
                Icons.flight,
                color: const Color(0xFF1E1E1E),
              )),
          PieChartSectionData(
              color: Colors.purple,
              badgeWidget: Icon(
                Icons.lightbulb,
                color: const Color(0xFF1E1E1E),
              )),
        ],
        sectionsSpace: 2,
        centerSpaceRadius: 30,
      ),
    );
  }

  Widget _buildBarChart() {
    return BarChart(
      BarChartData(
        barGroups: [
          makeGroupData(0, 4, 9),
          makeGroupData(1, 5, 8),
          makeGroupData(2, 6, 7),
          makeGroupData(3, 9, 4),
        ],
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, interval: 2),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) => Text(['Лют', 'Бер', 'Квіт', 'Трав'][value.toInt()],
                  style: const TextStyle(color: Colors.white)),
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: false),
      ),
    );
  }

  BarChartGroupData makeGroupData(int x, double income, double expenses) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(toY: income, color: Colors.green),
        BarChartRodData(toY: expenses, color: Colors.red),
      ],
    );
  }

  Widget _buildLineChart() {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
            isCurved: true,
            color: Colors.blue,
            spots: const [
              FlSpot(0, 2),
              FlSpot(1, 3),
              FlSpot(2, 4.5),
              FlSpot(3, 3.8),
              FlSpot(4, 5),
              FlSpot(5, 6.5),
              FlSpot(6, 5.5),
            ],
          ),
        ],
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  return Text(['Лис', 'Груд', 'Січ', 'Лют', 'Бер', 'Квіт', 'Трав'][value.toInt()],
                      style: const TextStyle(color: Colors.white));
                }),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, interval: 1),
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: FlGridData(show: true, drawHorizontalLine: true, horizontalInterval: 1),
      ),
    );
  }
}
