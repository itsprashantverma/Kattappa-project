import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:data_app/Home%20Page/home_page.dart';
import 'package:data_app/Widgets/teacher_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentDashboardWidget extends StatefulWidget {
  StudentDashboardWidget({Key key}) : super(key: key);

  @override
  _StudentDashboardWidgetState createState() => _StudentDashboardWidgetState();
}

class _StudentDashboardWidgetState extends State<StudentDashboardWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void checkData() async {
    var data = await FirebaseFirestore.instance.collection("teachers").get();

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
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF4527A0),
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment(0, 0),
          child: Text(
            'DASHBOARD',
            style: GoogleFonts.getFont(
              'Poppins',
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
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
                    CoolAlert.show(
                      context: context,
                      type: CoolAlertType.error,
                      title: 'Oops...',
                      text: 'Sorry, something went wrong',
                      loopAnimation: false,
                    );
                  }
                },
                child: Text(
                  'Logout',
                  style: GoogleFonts.getFont(
                    'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
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
        child: (isPresent == null)
            ? Center(
                child: CircularProgressIndicator(),
              )
            : (!isPresent)
                ? Container()
                : Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 20),
                        child: Text(
                          'Select your Teacher',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontSize: 30,
                          ),
                        ),
                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("teachers")
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
                                return TeacherDetailWidgetWidget(
                                    courseCode: document.data()["course"],
                                    name: document.data()["name"],
                                    subject: document.data()["subject"],
                                    id: document.id);
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
