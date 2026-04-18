class ReportManager {
  // This is where we will store the real AI results
  static List<Map<String, String>> reports = [
    {"type": "Safe Sleep", "time": "System Start", "action": "Monitored"},
  ];

  static void addReport(String status) {
    final now = DateTime.now();
    final timeStr = "${now.hour}:${now.minute.toString().padLeft(2, '0')}";

    reports.insert(0, {
      "type": status == "DANGER" ? "Stomach Position" : "Back/Safe Position",
      "time": timeStr,
      "action": status == "DANGER" ? "Alert Sent" : "No Action",
    });
  }
}