import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:data_app/Problem%20Widget/problem_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeacherEditScreenWidget extends StatefulWidget {
  final String name;
  final String roll;
  final String attendance;
  final String grade;
  final String id;

  TeacherEditScreenWidget({
    this.name,
    this.roll,
    this.attendance,
    this.grade,
    this.id,
  });

  @override
  _TeacherEditScreenWidgetState createState() =>
      _TeacherEditScreenWidgetState();
}

class _TeacherEditScreenWidgetState extends State<TeacherEditScreenWidget> {
  String editName;
  String editRoll;
  String editAttendance;
  String editGrade;

  void checkProblem() async {
    var doc = await FirebaseFirestore.instance
        .collection("teachers")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("record")
        .doc(widget.id)
        .collection("problem")
        .get();

    if (doc.size > 0) {
      setState(() {
        isProblem = true;
      });
    } else {
      setState(() {
        isProblem = false;
      });
    }
  }

  void initialiseData() {
    editAttendance = widget.attendance;
    editGrade = widget.grade;
    editName = widget.name;
    editRoll = widget.roll;
  }

  bool isProblem;

  @override
  void initState() {
    super.initState();
    checkProblem();
    initialiseData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4527A0),
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: (isProblem == null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  (!isProblem)
                      ? Container()
                      : StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("teachers")
                              .doc(FirebaseAuth.instance.currentUser.uid)
                              .collection("record")
                              .doc(widget.id)
                              .collection("problem")
                              .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ListView(
                              shrinkWrap: true,
                              children:
                                  snapshot.data.docs.map<Widget>((document) {
                                return ProblemWidget(
                                  studentId: widget.id,
                                  docId: document.id,
                                  problem: document.data()["problem"],
                                );
                              }).toList(),
                            );
                          },
                        ),
                  Align(
                    alignment: Alignment(0, 0),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                      child: Text(
                        'Edit Student Information',
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, 0),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Image.asset(
                        'images/computer.png',
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: TextFormField(
                      initialValue: widget.name,
                      onChanged: (v) {
                        editName = v;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Student Name',
                        labelStyle: GoogleFonts.getFont(
                          'Montserrat',
                          color: Colors.black,
                        ),
                        hintStyle: GoogleFonts.getFont(
                          'Montserrat',
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        filled: true,
                      ),
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: TextFormField(
                      initialValue: widget.roll,
                      onChanged: (v) {
                        editRoll = v;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Roll Number',
                        labelStyle: GoogleFonts.getFont(
                          'Montserrat',
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        filled: true,
                      ),
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: TextFormField(
                      initialValue: widget.attendance,
                      onChanged: (v) {
                        editAttendance = v;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Attendance',
                        labelStyle: GoogleFonts.getFont(
                          'Montserrat',
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        filled: true,
                      ),
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: TextFormField(
                      initialValue: widget.grade,
                      onChanged: (v) {
                        editGrade = v;
                      },
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Grade',
                        labelStyle: GoogleFonts.getFont(
                          'Montserrat',
                          color: Colors.black,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.black,
                            width: 1,
                          ),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4.0),
                            topRight: Radius.circular(4.0),
                          ),
                        ),
                        filled: true,
                      ),
                      style: GoogleFonts.getFont(
                        'Montserrat',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, 0),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: InkWell(
                        onTap: () async {
                          if (editAttendance == null ||
                              editGrade == null ||
                              editName == null ||
                              editRoll == null) {
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
                                  .doc(widget.id)
                                  .update({
                                "name": editName,
                                "roll": editRoll,
                                "grade": editGrade,
                                "attendance": editAttendance,
                              }).then((value) => Navigator.pop(context));
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        child: Container(
                          width: 230,
                          height: 44,
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                            maxHeight: 100,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF4527A0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment(0, 0),
                          child: Text(
                            'UPDATE',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(0, 0),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: InkWell(
                        onTap: () async {
                          try {
                            FirebaseFirestore.instance
                                .collection("teachers")
                                .doc(FirebaseAuth.instance.currentUser.uid)
                                .collection("record")
                                .doc(widget.id)
                                .delete()
                                .then((value) => Navigator.pop(context));
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Container(
                          width: 230,
                          height: 44,
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.7,
                            maxHeight: 100,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFF4527A0),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment(0, 0),
                          child: Text(
                            'DELETE STUDENT',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
