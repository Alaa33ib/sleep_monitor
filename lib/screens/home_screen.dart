import 'package:flutter/material.dart';
import 'dart:math';
import '../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDanger = false; // Simulated risk state
  late String currentTip;

  final List<String> healthTips = [
    "Always place baby on their back to sleep.",
    "Ensure the crib mattress is firm and flat.",
    "Keep soft objects and loose bedding out of the crib.",
    "Tummy time is for supervised wake hours only.",
    "Maintain a comfortable room temperature for the baby."
  ];

  @override
  void initState() {
    super.initState();
    currentTip = healthTips[Random().nextInt(healthTips.length)];
  }

  // Emergency Contacts Popup
  void _showEmergencyContacts(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Emergency Contacts",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.sage),
              ),
              const SizedBox(height: 15),
              ListTile(
                leading: const Icon(Icons.phone, color: Colors.green),
                title: const Text("Dad"),
                subtitle: const Text("+966 50 XXX XXXX"),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.phone, color: Colors.green),
                title: const Text("Dr. Smith (Pediatrician)"),
                subtitle: const Text("+966 55 XXX XXXX"),
                onTap: () {},
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Close"),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // 1. LIVE MONITOR FEED
          Container(
            height: 280,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(25),
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
            ),
            child: Stack(
              children: [
                const Center(
                  child: Text("CONNECTING TO CAMERA...", style: TextStyle(color: Colors.white70)),
                ),
                if (isDanger)
                  Center(
                    child: Container(
                      width: 180,
                      height: 220,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red, width: 4),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 25),

          // 2. EMERGENCY ACTION BUTTONS
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Call 999 with Arrow Logic
              _buildAction(
                label: "Call 999 ▾",
                icon: Icons.phone_forwarded,
                color: Colors.red,
                isActive: isDanger,
                onTap: () => _showEmergencyContacts(context),
              ),
              // Dismiss Button
              _buildAction(
                label: "Dismiss",
                icon: Icons.notifications_off,
                color: Colors.orange,
                isActive: isDanger,
                onTap: () => setState(() => isDanger = false),
              ),
              // Checked Button
              _buildAction(
                label: "Checked",
                icon: Icons.verified_user,
                color: Colors.green,
                isActive: isDanger,
                onTap: () => setState(() => isDanger = false),
              ),
            ],
          ),
          const SizedBox(height: 30),

          // 3. HEALTH CENTER MESSAGE
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppTheme.sage.withOpacity(0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.health_and_safety, color: AppTheme.sage),
                    SizedBox(width: 8),
                    Text(
                      "Health Center Advice",
                      style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.sage, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  currentTip,
                  style: const TextStyle(fontSize: 15, height: 1.4, color: AppTheme.textDark),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Simulation Trigger for Demo
          OutlinedButton(
            onPressed: () => setState(() => isDanger = !isDanger),
            child: Text(isDanger ? "Stop Simulation" : "Simulate Danger Alert"),
          ),
        ],
      ),
    );
  }

  Widget _buildAction({
    required String label,
    required IconData icon,
    required Color color,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: Opacity(
        opacity: isActive ? 1.0 : 0.3,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isActive ? AppTheme.textDark : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}