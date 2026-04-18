import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../navigation/main_nav.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent, elevation: 0, leading: const BackButton(color: AppTheme.textDark)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const Text("Sign Up", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
            const SizedBox(height: 30),
            _buildField("Enter your name", Icons.person_outline),
            _buildField("Enter your baby's name", Icons.child_care_outlined),
            _buildField("Enter your baby's age (in weeks)", Icons.calendar_month_outlined),
            _buildField("Enter your phone number", Icons.phone_android_outlined),
            _buildField("Enter emergency phone number", Icons.emergency_outlined),
            _buildField("Enter your password", Icons.lock_outline, isObscure: true),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainNav())),
                child: const Text("Sign Up"),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String hint, IconData icon, {bool isObscure = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextField(
        obscureText: isObscure,
        decoration: InputDecoration(
          hintText: hint,
          prefixIcon: Icon(icon, color: AppTheme.sage),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
        ),
      ),
    );
  }
}