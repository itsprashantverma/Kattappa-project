import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:data_app/Dashboard/teacher_dashboard.dart';
import 'package:data_app/Home%20Page/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TeacherProfileWidget extends StatefulWidget {
  TeacherProfileWidget({Key key}) : super(key: key);

  @override
  _TeacherProfileWidgetState createState() => _TeacherProfileWidgetState();
}

class _TeacherProfileWidgetState extends State<TeacherProfileWidget> {
  String name;
  String subject;
  String courseCode;
  Map data;
  bool loading = true;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  void initialiseData() {}

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var doc = await FirebaseFirestore.instance
        .collection("teachers")
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();

    if (doc.exists) {
      data = doc.data();
      name = data["name"];
      courseCode = data["course"];
      subject = data["subject"];
    } else {
      data = null;
    }

    loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF4527A0),
        automaticallyImplyLeading: true,
        actions: [
          Align(
            alignment: Alignment(0, 0),
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: InkWell(
                onTap: () async {
                  try {
                    await FirebaseAuth.instance.signOut();
                    await Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePageWidget(),
                      ),
                      (r) => false,
                    );
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text(
                  'Logout',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          )
        ],
        centerTitle: true,
        elevation: 4,
      ),
      body: SafeArea(
        child: (loading)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: Text(
                              'Fill up the profile',
                              style: GoogleFonts.getFont(
                                'Montserrat',
                                color: Color(0xFF0D1724),
                                fontSize: 30,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 12, 0, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Container(
                              width: 330,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(16, 0, 0, 2),
                                child: TextFormField(
                                  initialValue: name,
                                  onChanged: (v) {
                                    name = v;
                                  },
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Name',
                                    labelStyle: GoogleFonts.getFont(
                                      'Montserrat',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
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
                                  ),
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 0, 10),
                      child: TextFormField(
                        initialValue: subject,
                        onChanged: (v) {
                          subject = v;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Subject',
                          labelStyle: GoogleFonts.getFont(
                            'Montserrat',
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
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
                        ),
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                      child: TextFormField(
                        initialValue: courseCode,
                        onChanged: (v) {
                          courseCode = v;
                        },
                        obscureText: false,
                        decoration: InputDecoration(
                          labelText: 'Course Code',
                          labelStyle: GoogleFonts.getFont(
                            'Montserrat',
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
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
                        ),
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment(0, 0),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
                        child: InkWell(
                          onTap: () async {
                            try {
                              if (courseCode == null ||
                                  name == null ||
                                  subject == null) {
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.warning,
                                  title: 'Data Missing',
                                  text: 'Please fill all the Field\'s',
                                  loopAnimation: false,
                                );
                                return;
                              } else {
                                await FirebaseFirestore.instance
                                    .collection("teachers")
                                    .doc(FirebaseAuth.instance.currentUser.uid)
                                    .set(
                                  {
                                    "name": name,
                                    "course": courseCode,
                                    "subject": subject,
                                  },
                                ).then((value) => Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TeacherDashboardWidget()),
                                        (route) => false));
                              }
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Container(
                            width: 300,
                            height: 60,
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
                              'Upload Info',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
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
      ),
    );
  }
}
