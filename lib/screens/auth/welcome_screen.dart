import 'package:flutter/material.dart';
import 'package:new_task/screens/auth/login_screen.dart';
import 'package:new_task/screens/auth/register_screen.dart';
import 'package:new_task/theme/app_theme.dart';
import 'package:new_task/widgets/custom_btn.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade400,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.task_alt, size: 80, color: Colors.white),
              SizedBox(height: 10),

              Text(
                "Welcome to Task Manager",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'FontMain',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 30),

              Buttons(
                ddName: "Login",
                width: double.infinity,
                backgroundColor: AppColors.primary,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),

              SizedBox(height: 15),

              Buttons(
                ddName: "Register",
                width: double.infinity,
                backgroundColor: AppColors.green,
                textColor: Colors.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
