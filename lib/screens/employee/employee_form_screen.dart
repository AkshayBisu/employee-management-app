import 'package:flutter/material.dart';
import 'package:new_task/alerts/toast.dart';
import 'package:new_task/http/api_services.dart';
import 'package:new_task/theme/app_theme.dart';
import 'package:new_task/widgets/custom_btn.dart';
import 'package:new_task/widgets/custom_textfield.dart';

class EmployeeFormScreen extends StatefulWidget {
  final Map? user;

  const EmployeeFormScreen({this.user});

  @override
  State<EmployeeFormScreen> createState() => _EmployeeFormScreenState();
}

class _EmployeeFormScreenState extends State<EmployeeFormScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    print(" Screen Opened");

    if (widget.user != null) {
      print(" Edit Mode Data: ${widget.user}");

      nameController.text =
          "${widget.user!["first_name"]} ${widget.user!["last_name"]}";
      emailController.text = widget.user!["email"];
    }
  }

  Future<void> saveUser() async {
    print(" Button Clicked");

    setState(() => isLoading = true);

    final payload = {
      "name": nameController.text,
      "email": emailController.text,
    };

    print("  Payload: $payload");

    final isEdit = widget.user != null;
    print("  Mode: ${isEdit ? "EDIT" : "CREATE"}");

    if (isEdit) {
      print("  Updating User ID: ${widget.user!["id"]}");
    }

    final response = isEdit
        ? await putReq("/api/users/${widget.user!["id"]}", "", payload)
        : await postReq("/api/users", "", payload);

    print(" API Response: $response");

    setState(() => isLoading = false);

    if (response["success"]) {
      print("Success");

      Navigator.pop(context, true);
    } else {
      print("  Error: ${response["message"]}");

      CustomToast.show(
        context: context,
        message: response["message"] ?? "Error",
        success: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.user != null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: Text(
          isEdit ? "Edit Employee" : "Add Employee",
          style: TextStyle(fontFamily: 'FontMain', color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            CustomTextFieldWithName(
              controller: nameController,
              ddName: "Name",
              hintText: "Name",
            ),

            SizedBox(height: 12),

            CustomTextFieldWithName(
              controller: emailController,
              ddName: "Email",
              hintText: "Email",
            ),
            SizedBox(height: 30),

            isLoading
                ? CircularProgressIndicator()
                : Buttons(
                    ddName: isEdit ? "Update" : "Save",
                    width: double.infinity,
                    onPressed: saveUser,
                  ),
          ],
        ),
      ),
    );
  }
}
