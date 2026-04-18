import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import 'sign_up_screen.dart';
import '../navigation/main_nav.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Sign In", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
            const SizedBox(height: 30),
            _buildTextField("Enter your email", Icons.email_outlined),
            const SizedBox(height: 15),
            _buildTextField("Enter your password", Icons.lock_outline, isObscure: true),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(onPressed: () {}, child: const Text("Forgot password?", style: TextStyle(color: Colors.grey))),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainNav())),
                child: const Text("Sign In"),
              ),
            ),
            const SizedBox(height: 20),
            const Text("OR", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            _socialButton("Sign in with Google", Icons.g_mobiledata),
            _socialButton("Sign in with Facebook", Icons.facebook),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account?"),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpScreen())),
                  child: const Text("Sign up", style: TextStyle(color: AppTheme.sage, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, IconData icon, {bool isObscure = false}) {
    return TextField(
      obscureText: isObscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: AppTheme.sage),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
      ),
    );
  }

  Widget _socialButton(String text, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: Icon(icon, color: AppTheme.sage),
        label: Text(text, style: const TextStyle(color: AppTheme.textDark)),
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.black12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}