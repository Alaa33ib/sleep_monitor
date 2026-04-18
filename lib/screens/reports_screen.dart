import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../services/report_manager.dart'; // Import the manager

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  @override
  Widget build(BuildContext context) {
    // We get the data from our "manager" instead of hardcoding it
    final reports = ReportManager.reports;

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "AI Detection History",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.sage),
          ),
        ),
        Expanded(
          child: reports.isEmpty
              ? const Center(child: Text("No AI events detected yet."))
              : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: reports.length,
            itemBuilder: (context, index) {
              bool isRisk = reports[index]['type'] == "Stomach Position";

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: isRisk ? Colors.red.withOpacity(0.1) : AppTheme.sage.withOpacity(0.1),
                    child: Icon(
                        isRisk ? Icons.warning_amber_rounded : Icons.check_circle_outline,
                        color: isRisk ? Colors.red : AppTheme.sage
                    ),
                  ),
                  title: Text(
                      reports[index]['type']!,
                      style: const TextStyle(fontWeight: FontWeight.bold)
                  ),
                  subtitle: Text("Result: ${reports[index]['action']}"),
                  trailing: Text(
                      reports[index]['time']!,
                      style: const TextStyle(color: Colors.grey, fontSize: 12)
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}