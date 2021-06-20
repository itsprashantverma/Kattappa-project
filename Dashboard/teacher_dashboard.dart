import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_app/Teacher%20Profile%20Page/teacher_profile.dart';
import 'package:data_app/Widgets/student_detail.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TeacherDashboardWidget extends StatefulWidget {
  TeacherDashboardWidget({Key key}) : super(key: key);

  @override
  _TeacherDashboardWidgetState createState() => _TeacherDashboardWidgetState();
}

class _TeacherDashboardWidgetState extends State<TeacherDashboardWidget> {
  void checkData() async {
    var data = await FirebaseFirestore.instance
        .collection("teachers")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("record")
        .get();

    if (data.size > 0) {
      setState(() {
        isPresent = true;
      });
    } else {
      setState(() {
        isPresent = false;
      });
    }
  }

  bool isPresent;

  @override
  void initState() {
    super.initState();
    checkData();
  }

  @override
  Widget build(BuildContext context) {
    checkData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4527A0),
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment(0, 0),
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 2),
            child: Text(
              'DASHBOARD',
              style: GoogleFonts.getFont(
                'Montserrat',
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
        ),
        actions: [
          Align(
            alignment: Alignment(0, 0),
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: InkWell(
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeacherProfileWidget(),
                    ),
                  );
                },
                child: FaIcon(
                  FontAwesomeIcons.userTie,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          )
        ],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFE8E7E7),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          String studentName;
          String studentAttendance;
          String studentGrade;
          String studentRoll;
          Alert(
              context: context,
              title: "Add Student",
              content: Column(
                children: <Widget>[
                  TextField(
                    onChanged: (v) {
                      studentName = v;
                    },
                    decoration: InputDecoration(
                      labelText: 'Student Name',
                    ),
                  ),
                  TextField(
                    onChanged: (v) {
                      studentRoll = v;
                    },
                    decoration: InputDecoration(
                      labelText: 'Student Roll No.',
                    ),
                  ),
                  TextField(
                    onChanged: (v) {
                      studentAttendance = v;
                    },
                    decoration: InputDecoration(
                      labelText: 'Student Attendance',
                    ),
                  ),
                  TextField(
                    onChanged: (v) {
                      studentGrade = v;
                    },
                    decoration: InputDecoration(
                      labelText: 'Student Grade',
                    ),
                  ),
                ],
              ),
              buttons: [
                DialogButton(
                  color: Color(0xFF4527A0),
                  onPressed: () async {
                    if (studentRoll == null ||
                        studentGrade == null ||
                        studentAttendance == null ||
                        studentName == null) {
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.warning,
                        title: 'Data Missing',
                        text: 'Please fill all the Field\'s',
                        loopAnimation: false,
                      );
                    } else {
                      try {
                        await FirebaseFirestore.instance
                            .collection("teachers")
                            .doc(FirebaseAuth.instance.currentUser.uid)
                            .collection("record")
                            .add({
                          "name": studentName,
                          "roll": studentRoll,
                          "grade": studentGrade,
                          "attendance": studentAttendance,
                        }).then((value) => Navigator.pop(context));
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                  child: Text(
                    "ADD",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                )
              ]).show();
        },
        backgroundColor: Color(0xFF4527A0),
        elevation: 8,
        label: Text(
          'Add student',
          style: GoogleFonts.getFont(
            'Lato',
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
      body: SafeArea(
        child: (isPresent == null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : (!isPresent)
                ? Container()
                : ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                        child: Text(
                          'Students',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontSize: 25,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("teachers")
                            .doc(FirebaseAuth.instance.currentUser.uid)
                            .collection("record")
                            .snapshots(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return SizedBox(
                            height: MediaQuery.of(context).size.height - 200,
                            child: ListView(
                              children:
                                  snapshot.data.docs.map<Widget>((document) {
                                return StudentDetailWidgetWidget(
                                  name: document.data()["name"],
                                  roll: document.data()["roll"],
                                  attendance: document.data()["attendance"],
                                  grade: document.data()["grade"],
                                  id: document.id,
                                );
                              }).toList(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
      ),
    );
  }
}
