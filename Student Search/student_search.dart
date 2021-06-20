import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_app/Widgets/from_student_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentSearchPageWidget extends StatefulWidget {
  final String id;

  StudentSearchPageWidget({@required this.id});

  @override
  _StudentSearchPageWidgetState createState() =>
      _StudentSearchPageWidgetState();
}

class _StudentSearchPageWidgetState extends State<StudentSearchPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void checkData() async {
    var data = await FirebaseFirestore.instance
        .collection("teachers")
        .doc(widget.id)
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
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF4527A0),
        automaticallyImplyLeading: true,
        actions: [],
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
                : ListView(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                        child: Text(
                          'Student Record',
                          style: GoogleFonts.getFont(
                            'Montserrat',
                            fontSize: 30,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                        child: Text(
                          'Note : Long Press on your record if something is wrong',
                          style: GoogleFonts.getFont(
                            'Open Sans',
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("teachers")
                            .doc(widget.id)
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
                                return FromStudentDetail(
                                  name: document.data()["name"],
                                  roll: document.data()["roll"],
                                  attendance: document.data()["attendance"],
                                  grade: document.data()["grade"],
                                  id: document.id,
                                  teacherId: widget.id,
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
