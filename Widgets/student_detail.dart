import 'package:data_app/Edit%20Pages/teacher_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class StudentDetailWidgetWidget extends StatefulWidget {
  final String name;
  final String roll;
  final String attendance;
  final String grade;
  final String id;

  StudentDetailWidgetWidget({
    this.name,
    this.roll,
    this.attendance,
    this.grade,
    this.id,
  });

  @override
  _StudentDetailWidgetWidgetState createState() =>
      _StudentDetailWidgetWidgetState();
}

class _StudentDetailWidgetWidgetState extends State<StudentDetailWidgetWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: GestureDetector(
          onTap: () {
            HapticFeedback.vibrate();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TeacherEditScreenWidget(
                  name: widget.name,
                  roll: widget.roll,
                  attendance: widget.attendance,
                  grade: widget.grade,
                  id: widget.id,
                ),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(20),
              shape: BoxShape.rectangle,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(2, 0, 20, 0),
                  child: Image.asset(
                    'images/computer.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Text(
                        widget.name,
                        style: GoogleFonts.getFont(
                          'Lato',
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Text(
                        widget.roll,
                        style: GoogleFonts.getFont(
                          'Lato',
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Text(
                        widget.attendance,
                        style: GoogleFonts.getFont(
                          'Lato',
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Text(
                        widget.grade,
                        style: GoogleFonts.getFont(
                          'Lato',
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
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
