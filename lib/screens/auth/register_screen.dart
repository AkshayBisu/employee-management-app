import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_task/alerts/toast.dart';
import 'package:new_task/http/api_services.dart';
import 'package:new_task/screens/employee/employee_list.dart';
import 'package:new_task/state_management/state_management.dart';
import 'package:new_task/theme/app_theme.dart';
import 'package:new_task/widgets/custom_btn.dart';
import 'package:new_task/widgets/custom_textfield.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final controller = Get.find<StateController>();

  bool isLoading = false;

  Future<void> registerUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      CustomToast.show(
        context: context,
        message: "All fields are required!",
        success: false,
      );
      return;
    }

    setState(() => isLoading = true);

    final payload = {"email": email, "password": password};

    final response = await postReq("/api/register", "", payload);

    setState(() => isLoading = false);

    print("REGISTER RESPONSE: $response");

    if (response["success"]) {
      final token = response["data"]["token"];

      if (token != null) {
        await controller.setAuthToken(token);
      }

      CustomToast.show(
        context: context,
        message: "Registration Successful",
        success: true,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => EmployeeListScreen()),
      );
    } else {
      CustomToast.show(
        context: context,
        message: response["message"],
        success: false,
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.green,
        title: Text(
          "Register",
          style: TextStyle(fontFamily: 'FontMain', color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextFieldWithName(
              controller: emailController,
              ddName: "Email",
              hintText: "Enter your email",
            ),

            SizedBox(height: 10),

            CustomTextFieldWithName(
              controller: passwordController,
              ddName: "Password",
              hintText: "Enter your password",
              obscureText: true,
            ),

            SizedBox(height: 20),

            isLoading
                ? CircularProgressIndicator()
                : Buttons(
                    ddName: "Register",
                    width: double.infinity,
                    backgroundColor: AppColors.green,
                    textColor: Colors.white,
                    onPressed: registerUser,
                  ),
          ],
        ),
      ),
    );
  }
}
