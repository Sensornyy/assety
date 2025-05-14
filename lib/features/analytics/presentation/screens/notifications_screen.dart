import 'package:assety/features/transactions/presentation/widgets/transaction_tile.dart';
import 'package:flutter/material.dart';

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        NotificationCard(
          title: 'Суттєве відхилення витрат',
          time: '18:40',
          message:
              'У категорії "Розваги" зафіксовано аномальну транзакцію. Рекомендується переглянути бюджет та обмежити непланові витрати.',
          anomalyLevel: AnomalyLevel.strong,
        ),
        NotificationCard(
          title: 'Перевищення витрат',
          time: '14:30',
          message:
              'Витрати на транспорт значно перевищили середнє. Можливо, зросла вартість пального чи частота поїздок.',
          anomalyLevel: AnomalyLevel.medium,
        ),
        NotificationCard(
          title: 'Невелике перевищення витрат',
          time: '09:15',
          message:
              'Витрати на продукти трохи вищі за звичний рівень. Можливо, це разова покупка або зміна звичок.',
          anomalyLevel: AnomalyLevel.weak,
        ),
      ],
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String time;
  final String message;
  final AnomalyLevel anomalyLevel;

  const NotificationCard({
    super.key,
    required this.title,
    required this.time,
    required this.message,
    required this.anomalyLevel,
  });

  @override
  Widget build(BuildContext context) {
    final config = _anomalyConfig[anomalyLevel]!;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: config.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: config.iconColor.withOpacity(0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(config.icon, color: config.iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
                const SizedBox(height: 4),
                Text(message, style: const TextStyle(color: Colors.white)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            time,
            style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class AnomalyVisualConfig {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;

  AnomalyVisualConfig({
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
  });
}

final Map<AnomalyLevel, AnomalyVisualConfig> _anomalyConfig = {
  AnomalyLevel.weak: AnomalyVisualConfig(
    icon: Icons.info_outline,
    iconColor: const Color(0xFF42A5F5),
    backgroundColor: const Color(0xFF1E3A5F),
  ),
  AnomalyLevel.medium: AnomalyVisualConfig(
    icon: Icons.warning_amber_rounded,
    iconColor: const Color(0xFFFFC107),
    backgroundColor: const Color(0xFF4E3A0D),
  ),
  AnomalyLevel.strong: AnomalyVisualConfig(
    icon: Icons.dangerous_outlined,
    iconColor: const Color(0xFFEF5350),
    backgroundColor: const Color(0xFF5A1E1E),
  ),
};
