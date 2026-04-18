import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class ReportsScreen extends StatelessWidget {
  // Demo data - in a real app, this comes from SQLite
  final List<Map<String, String>> reports = [
    {"type": "Face Down", "time": "10:30 AM", "action": "Checked"},
    {"type": "Stomach Position", "time": "08:15 AM", "action": "Dismissed"},
    {"type": "Covered by Blanket", "time": "Yesterday", "action": "Checked"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: reports.length,
      itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppTheme.sage.withOpacity(0.2),
              child: Icon(Icons.history, color: AppTheme.sage),
            ),
            title: Text(reports[index]['type']!, style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Action: ${reports[index]['action']}"),
            trailing: Text(reports[index]['time']!, style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
        );
      },
    );
  }
}