import 'package:data_app/Dashboard/student_dashboard.dart';
import 'package:data_app/Dashboard/teacher_dashboard.dart';
import 'package:data_app/Login%20Pages/student_login_page.dart';
import 'package:data_app/Login%20Pages/teacher_login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoadingScreen extends StatelessWidget {
  final String type;
  LoadingScreen(this.type);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: StreamBuilder<User>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User user = snapshot.data;
            if (user == null) {
              return (type == "teacher")
                  ? TeacherLoginWidget()
                  : StudentLoginWidget();
            }
            return (type == "teacher")
                ? TeacherDashboardWidget()
                : StudentDashboardWidget();
          } else {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      ),
    );
  }
}
