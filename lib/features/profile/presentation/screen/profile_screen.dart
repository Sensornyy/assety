import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkTheme = true;
  bool remindersEnabled = true;

  void _changePassword() {
    // TODO: Реалізувати зміну пароля
    print('Змінити пароль');
  }

  void _logout() {
    // TODO: Реалізувати вихід з акаунту
    print('Вийти з акаунту');
  }

  void _deleteAccount() {
    // TODO: Реалізувати видалення акаунту
    print('Видалити акаунт');
  }

  void _toggleTheme(bool value) {
    setState(() {
      isDarkTheme = value;
    });
    // TODO: Зберегти стан теми або передати в глобальний ThemeMode
  }

  void _toggleReminders(bool value) {
    setState(() {
      remindersEnabled = value;
    });
    // TODO: Вмикати / вимикати push-нагадування
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212), // Темний фон
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        foregroundColor: Colors.white,
        title: const Text('Профіль'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ListTile(
            leading: const Icon(Icons.person, color: Colors.white),
            title: const Text('Електронна пошта', style: TextStyle(color: Colors.white)),
            subtitle: Text('koriak.maksi@gmail.com', style: const TextStyle(color: Colors.white70)),
          ),
          const Divider(color: Colors.white12),

          SwitchListTile(
            title: const Text('Нагадування', style: TextStyle(color: Colors.white)),
            value: remindersEnabled,
            onChanged: _toggleReminders,
            secondary: const Icon(Icons.notifications_active, color: Colors.white70),
            activeColor: Colors.orangeAccent,
            tileColor: Colors.transparent,
          ),
          SwitchListTile(
            title: const Text('Темна тема', style: TextStyle(color: Colors.white)),
            value: isDarkTheme,
            onChanged: _toggleTheme,
            secondary: const Icon(Icons.brightness_6, color: Colors.white70),
            activeColor: Colors.orangeAccent,
            tileColor: Colors.transparent,
          ),
          const Divider(color: Colors.white12),

          ListTile(
            leading: const Icon(Icons.lock, color: Colors.white),
            title: const Text('Змінити пароль', style: TextStyle(color: Colors.white)),
            onTap: _changePassword,
          ),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.white),
            title: const Text('Вийти з акаунту', style: TextStyle(color: Colors.white)),
            onTap: _logout,
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.redAccent),
            title: const Text('Видалити акаунт', style: TextStyle(color: Colors.redAccent)),
            onTap: _deleteAccount,
          ),
        ],
      ),
    );
  }
}
