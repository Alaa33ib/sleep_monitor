import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'dart:math';
import '../theme/app_theme.dart';
import '../services/ai_service.dart';
import '../services/report_manager.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isDanger = false;
  bool isProcessing = false;
  String currentStatus = "SCANNING";
  late String currentTip;
  Uint8List? selectedImage;

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

  // --- CONNECTS TO YOUR FRIEND'S BACKEND ---
  Future<void> _analyzeNewFrame() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final Uint8List bytes = await image.readAsBytes();
      setState(() {
        selectedImage = bytes;
        isProcessing = true;
        currentStatus = "ANALYZING...";
      });

      // Sending to her FastAPI
      final result = await AIService.predictStatus(bytes);

      if (result != null) {
        setState(() {
          currentStatus = result['status']; // "DANGER", "SAFE", or "FACE_COVERED"
          isDanger = (currentStatus == "DANGER");
          isProcessing = false;
        });
        ReportManager.addReport(currentStatus);
      } else {
        setState(() {
          currentStatus = "SERVER ERROR";
          isProcessing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          // 1. MONITOR FEED
          Container(
            height: 280,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(25),
              image: selectedImage != null
                  ? DecorationImage(image: MemoryImage(selectedImage!), fit: BoxFit.cover)
                  : null,
              boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 10)],
            ),
            child: Stack(
              children: [
                if (selectedImage == null)
                  const Center(child: Text("NO CAMERA FEED", style: TextStyle(color: Colors.white70))),

                // Real-time Status Overlay from YOLO
                Positioned(
                  top: 20,
                  left: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isDanger ? Colors.red : AppTheme.sage,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      currentStatus,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),

                if (isDanger)
                  Center(
                    child: Container(
                      width: 200,
                      height: 240,
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
              _buildAction(
                label: "Call 999 ▾",
                icon: Icons.phone_forwarded,
                color: Colors.red,
                isActive: isDanger,
                onTap: () => _showEmergencyContacts(context),
              ),
              _buildAction(
                label: "Dismiss",
                icon: Icons.notifications_off,
                color: Colors.orange,
                isActive: isDanger,
                onTap: () => setState(() => isDanger = false),
              ),
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

          // 3. AI TRIGGER BUTTON
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              icon: isProcessing
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Icon(Icons.camera_alt),
              label: Text(isProcessing ? "Analyzing AI..." : "Capture Frame for AI"),
              onPressed: isProcessing ? null : _analyzeNewFrame,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.sage,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // 4. HEALTH ADVICE CARD
          _buildHealthCard(),
        ],
      ),
    );
  }

  // --- UI HELPER: HEALTH CARD ---
  Widget _buildHealthCard() {
    return Container(
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
              Text("Health Center Advice", style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.sage, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 12),
          Text(currentTip, style: const TextStyle(fontSize: 15, height: 1.4, color: AppTheme.textDark)),
        ],
      ),
    );
  }

  // --- UI HELPER: EMERGENCY CONTACTS POPUP ---
  void _showEmergencyContacts(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("Emergency Contacts", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppTheme.sage)),
              const SizedBox(height: 15),
              const ListTile(leading: Icon(Icons.phone, color: Colors.green), title: Text("Dad"), subtitle: Text("+966 50 123 4567")),
              const ListTile(leading: Icon(Icons.phone, color: Colors.green), title: Text("Hospital"), subtitle: Text("997")),
              const SizedBox(height: 10),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Close"))),
            ],
          ),
        );
      },
    );
  }

  // --- UI HELPER: CIRCLE ACTION BUTTONS ---
  Widget _buildAction({required String label, required IconData icon, required Color color, required bool isActive, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      child: Opacity(
        opacity: isActive ? 1.0 : 0.3,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 8),
            Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: isActive ? AppTheme.textDark : Colors.grey)),
          ],
        ),
      ),
    );
  }
}