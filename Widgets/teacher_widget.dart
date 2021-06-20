import 'package:data_app/Student%20Search/student_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class TeacherDetailWidgetWidget extends StatefulWidget {
  final String name;
  final String courseCode;
  final String subject;
  final String id;

  TeacherDetailWidgetWidget(
      {@required this.courseCode,
      @required this.name,
      @required this.subject,
      @required this.id});
  @override
  _TeacherDetailWidgetWidgetState createState() =>
      _TeacherDetailWidgetWidgetState();
}

class _TeacherDetailWidgetWidgetState extends State<TeacherDetailWidgetWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0),
      child: Padding(
        padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
        child: GestureDetector(
          onTap: () {
            HapticFeedback.vibrate();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StudentSearchPageWidget(id: widget.id),
              ),
            );
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 104,
            decoration: BoxDecoration(
              color: Color(0xFFE8E7E7),
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
              border: Border.all(
                color: Colors.black,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'images/teacher cover.png',
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 0, 15),
                      child: Text(
                        widget.name,
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 15),
                      child: Text(
                        widget.subject,
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 15),
                      child: Text(
                        widget.courseCode,
                        style: GoogleFonts.getFont(
                          'Montserrat',
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
