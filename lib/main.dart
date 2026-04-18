import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'navigation/main_nav.dart';
import 'services/notification_service.dart';
import 'screens/sign_in_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize notifications for background alerts
  await NotificationService.init();
  runApp(const CradleApp());
}

class CradleApp extends StatelessWidget {
  const CradleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cradle Protection',
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Use this specific Navigator call
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: const Duration(milliseconds: 1000), // 1 full second
            pageBuilder: (context, animation, secondaryAnimation) => const SignInScreen(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              // This defines the curve (slow start, fast end)
              var curve = Curves.easeIn;
              var curvedAnimation = CurvedAnimation(
                parent: animation,
                curve: curve,
              );

              return FadeTransition(
                opacity: curvedAnimation,
                child: child,
              );
            },
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The background color will inherit from your AppTheme.lightTheme
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              width: 300,
              height: 300,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                // Keep the icon fallback just in case the file path breaks
                return const Icon(Icons.child_care, size: 120, color: AppTheme.sage);
              },
            ),
            // Text and SizedBoxes removed to keep the focus solely on your logo
          ],
        ),
      ),
    );
  }
}