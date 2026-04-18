import 'package:flutter/material.dart';
import 'sign_in_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // --- STATE DATA ---
  String userName = "User Name";
  String babyName = "Baby Ahmad";
  String babyAge = "6 Months";
  String userEmail = "user@example.com";
  String userPhone = "+966 50 123 4567";

  List<Map<String, String>> contacts = [
    {"name": "Father", "phone": "+966 50 123 4567"},
    {"name": "Hospital", "phone": "997"},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _tile("Edit Profile", Icons.person, () => _editProfileModal()),
        _tile("Baby Info (Age/Name)", Icons.child_care, () => _editBabyModal()),
        _tile("Emergency Contacts", Icons.emergency_share, () => _manageContactsModal()),
        _tile("Camera Serial Info", Icons.settings_remote, () => _showSimpleDialog("Camera Info", "SN: 2026-CRADLE-01")),
        // --- CUSTOMER SUPPORT IS BACK ---
        _tile("Contact Support", Icons.support_agent, () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Support ticket created! We will email you shortly.")),
          );
        }),
        const SizedBox(height: 30),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent.withOpacity(0.1),
            foregroundColor: Colors.red,
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 15),
          ),
          onPressed: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const SignInScreen()),
                  (route) => false
          ),
          child: const Text("Logout", style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  // --- REUSABLE TILE WITH YOUR THEME COLOR ---
  Widget _tile(String title, IconData icon, VoidCallback tap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF9DB08B)), // Your Sage Green
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: tap,
      ),
    );
  }

  // --- EDIT PROFILE MODAL ---
  void _editProfileModal() {
    final nameC = TextEditingController(text: userName);
    final emailC = TextEditingController(text: userEmail);
    final phoneC = TextEditingController(text: userPhone);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 20, right: 20, top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text("Edit Profile",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 20),

            // Name Field
            TextField(
              controller: nameC,
              decoration: const InputDecoration(
                labelText: "Full Name",
                prefixIcon: Icon(Icons.person_outline),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // Email Field
            TextField(
              controller: emailC,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email Address",
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // Phone Number Field
            TextField(
              controller: phoneC,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: "Phone Number",
                prefixIcon: Icon(Icons.phone_android_outlined),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    userName = nameC.text;
                    userEmail = emailC.text;
                    userPhone = phoneC.text;
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Profile updated successfully!")),
                  );
                },
                child: const Text("Save Changes"),
              ),
            ),
          ],
        ),
      ),
    );
  } //edit profile

  // --- BABY INFO MODAL ---
  void _editBabyModal() {
    final nameC = TextEditingController(text: babyName);
    final ageC = TextEditingController(text: babyAge);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 20, right: 20, top: 20
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Update Baby Info", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            TextField(controller: nameC, decoration: const InputDecoration(labelText: "Baby Name", border: OutlineInputBorder())),
            const SizedBox(height: 10),
            TextField(controller: ageC, decoration: const InputDecoration(labelText: "Age (e.g. 6 Months)", border: OutlineInputBorder())),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    babyName = nameC.text;
                    babyAge = ageC.text;
                  });
                  Navigator.pop(context);
                },
                child: const Text("Save Changes"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- EMERGENCY CONTACTS MODAL ---
  void _manageContactsModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text("Emergency Contacts", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: contacts.length,
                      itemBuilder: (context, i) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(contacts[i]['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text(contacts[i]['phone']!),
                        trailing: IconButton(
                            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                            onPressed: () {
                              setState(() => contacts.removeAt(i));
                              setModalState(() {});
                            }
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.add),
                    label: const Text("Add New Contact"),
                    onPressed: () => _addNewContactDialog(setModalState),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          }
      ),
    );
  }

  void _addNewContactDialog(StateSetter setModalState) {
    final nameC = TextEditingController();
    final phoneC = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("New Contact"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameC, decoration: const InputDecoration(hintText: "Contact Name")),
            const SizedBox(height: 10),
            TextField(controller: phoneC, decoration: const InputDecoration(hintText: "Phone Number"), keyboardType: TextInputType.phone),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () {
                if (nameC.text.isNotEmpty && phoneC.text.isNotEmpty) {
                  setState(() => contacts.add({"name": nameC.text, "phone": phoneC.text}));
                  setModalState(() {});
                  Navigator.pop(context);
                }
              },
              child: const Text("Add")
          ),
        ],
      ),
    );
  }

  // --- MODAL HELPER ---
  void _showInputModal(String title, String label, TextEditingController controller, Function(String) onSave) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            left: 20, right: 20, top: 20
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            TextField(controller: controller, decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()), autofocus: true),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    onSave(controller.text);
                    Navigator.pop(context);
                  },
                  child: const Text("Save")
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSimpleDialog(String title, String msg) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(msg),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("Close"))]
        )
    );
  }
}