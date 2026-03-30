import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_task/alerts/toast.dart';
import 'package:new_task/http/api_services.dart';
import 'package:new_task/screens/employee/employee_list.dart';
import 'package:new_task/state_management/state_management.dart';
import 'package:new_task/theme/app_theme.dart';
import 'package:new_task/widgets/custom_btn.dart';
import 'package:new_task/widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final controller = Get.put(StateController());

  bool isLoading = false;

  Future<void> loginUser() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

    if (email.isEmpty || password.isEmpty) {
      CustomToast.show(
        context: context,
        message: "Please enter email & password!",
        success: false,
      );
      return;
    }

    if (!emailRegex.hasMatch(email)) {
      CustomToast.show(
        context: context,
        message: "Please enter a valid email address!",
        success: false,
      );
      return;
    }

    print(" Email: $email");
    print(" Password: $password");

    setState(() => isLoading = true);

    final payload = {"email": email, "password": password};

    print(" Payload: $payload");

    final response = await postReq("/api/login", "", payload);

    setState(() => isLoading = false);

    print(" FINAL RESPONSE: $response");

    if (response["success"]) {
      final token = response["data"]["token"];

      if (token != null) {
        await controller.setAuthToken(token);
      }

      print(" TOKEN: $token");

      CustomToast.show(
        context: context,
        message: "Login Successful",
        success: true,
      );

      Get.offAll(() => EmployeeListScreen());
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
        backgroundColor: AppColors.primary,
        title: Text(
          "Login",
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
              hintText: "Email",
            ),
            SizedBox(height: 10),

            CustomTextFieldWithName(
              controller: passwordController,
              ddName: "Password",
              hintText: "Password",
              obscureText: true,
            ),

            SizedBox(height: 20),

            isLoading
                ? CircularProgressIndicator()
                : Buttons(
                    ddName: "Login",
                    width: double.infinity,
                    backgroundColor: AppColors.primary,
                    textColor: Colors.white,
                    onPressed: loginUser,
                  ),
          ],
        ),
      ),
    );
  }
}
