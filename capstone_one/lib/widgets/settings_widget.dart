import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  final IconData icon;
  final String title;

  const SettingsWidget({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
        ),
        child: ListTile(
          tileColor: Colors.transparent,
          leading: Icon(icon),
          title: Text(title),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
