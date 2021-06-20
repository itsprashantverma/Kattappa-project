import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class StudentDataUpdateWidget extends StatefulWidget {
  final String name;
  final String roll;
  final String attendance;
  final String grade;
  final String id;
  final String teacherId;

  StudentDataUpdateWidget({
    this.name,
    this.roll,
    this.attendance,
    this.grade,
    this.id,
    this.teacherId,
  });

  @override
  _StudentDataUpdateWidgetState createState() =>
      _StudentDataUpdateWidgetState();
}

class _StudentDataUpdateWidgetState extends State<StudentDataUpdateWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF4527A0),
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment(0, 0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 20),
                child: Text(
                  'Student Detail',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Image.asset(
              'images/student cover.png',
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(
                    "Name : " + widget.name,
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 1, 0, 10),
                  child: Text(
                    "Roll Number : " + widget.roll,
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 1, 0, 10),
                  child: Text(
                    "Atendance : " + widget.attendance,
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 1, 0, 10),
                  child: Text(
                    "Grade : " + widget.grade,
                    style: GoogleFonts.getFont(
                      'Poppins',
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
              child: Text(
                'Is something wrong with the Data ?',
                style: GoogleFonts.getFont(
                  'Montserrat',
                  fontSize: 18,
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, 0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: InkWell(
                  onTap: () {
                    HapticFeedback.vibrate();
                    try {
                      TextEditingController problem = TextEditingController();
                      Alert(
                          context: context,
                          title: "Write your issue below",
                          content: Column(
                            children: <Widget>[
                              TextField(
                                controller: problem,
                                decoration: InputDecoration(
                                  labelText: 'Problem',
                                ),
                              ),
                            ],
                          ),
                          buttons: [
                            DialogButton(
                              color: Color(0xFF4527A0),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection("teachers")
                                    .doc(widget.teacherId)
                                    .collection("record")
                                    .doc(widget.id)
                                    .collection("problem")
                                    .doc()
                                    .set({"problem": problem.text}).then(
                                        (value) => Navigator.pop(context));
                              },
                              child: Text(
                                "POST",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            )
                          ]).show();
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
                      'Post Request',
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
