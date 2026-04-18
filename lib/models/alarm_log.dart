class AlarmLog {
  final int? id;
  final String timestamp;
  final String riskType;
  final String status; // e.g., "Checked", "Dismissed"

  AlarmLog({this.id, required this.timestamp, required this.riskType, required this.status});

  Map<String, dynamic> toMap() {
    return {'timestamp': timestamp, 'risk_type': riskType, 'status': status};
  }
}