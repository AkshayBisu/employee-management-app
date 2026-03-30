import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:new_task/alerts/toast.dart';
import 'package:new_task/http/api_services.dart';
import 'package:new_task/screens/employee/employee_form_screen.dart';
import 'package:new_task/theme/app_theme.dart';
import 'package:new_task/widgets/custom_btn.dart';

class EmployeeListScreen extends StatefulWidget {
  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  List users = [];

  bool isLoading = true;

  int page = 1;
  int totalPages = 1;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    setState(() => isLoading = true);

    final response = await getReq("/api/users?page=$page");

    setState(() => isLoading = false);

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);

      setState(() {
        users = decoded["data"];
        totalPages = decoded["total_pages"];
      });
    } else {
      print("Error fetching users");
    }
  }

  void nextPage() {
    if (page < totalPages) {
      page++;
      fetchUsers();
    }
  }

  void prevPage() {
    if (page > 1) {
      page--;
      fetchUsers();
    }
  }

  Future<void> deleteUser(int id) async {
    final response = await deleteReq("/api/users/$id");

    if (response["success"]) {
      setState(() {
        users.removeWhere((u) => u["id"] == id);
      });

      CustomToast.show(
        context: context,
        message: "Deleted successfully",
        success: true,
      );
    } else {
      CustomToast.show(
        context: context,
        message: "Deleted failed",
        success: true,
      );
    }
  }
Future<void> showDeleteDialog(int userId) async {
  final bool? confirm = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          children: const [
            Icon(Icons.warning_amber_rounded, color: Colors.red),
            SizedBox(width: 8),
            Text(
              "Confirm Delete",
              style: TextStyle(fontFamily: 'FontMain'),
            ),
          ],
        ),
        content: const Text(
          "Are you sure you want to delete this employee?",
          style: TextStyle(fontFamily: 'FontMain'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: const Text(
              "Cancel",
              style: TextStyle(fontFamily: 'FontMain'),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text(
              "Delete",
              style: TextStyle(
                color: Colors.red,
                fontFamily: 'FontMain',
              ),
            ),
          ),
        ],
      );
    },
  );

   if (confirm == true) {
    await deleteUser(userId);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
        title: Text(
          "Employee List",
          style: TextStyle(fontFamily: 'FontMain', color: Colors.white),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Buttons(
                  ddName: "Add Employee",
                  width: 200,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EmployeeFormScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];

                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(user["avatar"]),
                          ),

                          title: Text(
                            "${user["first_name"]} ${user["last_name"]}",
                            style: TextStyle(
                              fontFamily: 'FontMain',
                              fontSize: 14,
                            ),
                          ),

                          subtitle: Text(
                            user["email"],
                            style: TextStyle(
                              fontFamily: 'FontMain',
                              fontSize: 12,
                            ),
                          ),

                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit, color: Colors.blue),
                                onPressed: () async {
                                  final result = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                          EmployeeFormScreen(user: user),
                                    ),
                                  );

                                  if (result == true) fetchUsers();
                                },
                              ),

                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  showDeleteDialog(user["id"]);
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: page > 1 ? prevPage : null,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: page > 1 ? Colors.blue : Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.arrow_back, color: Colors.white),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        "Page $page / $totalPages",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: page < totalPages ? nextPage : null,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: page < totalPages
                              ? Colors.blue
                              : Colors.grey.shade300,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.arrow_forward, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
