import 'package:data_app/Edit%20Pages/student_edit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class FromStudentDetail extends StatefulWidget {
  final String name;
  final String roll;
  final String attendance;
  final String grade;
  final String id;
  final String teacherId;

  FromStudentDetail({
    this.name,
    this.roll,
    this.attendance,
    this.grade,
    this.id,
    this.teacherId,
  });
  @override
  _FromStudentDetailState createState() => _FromStudentDetailState();
}

class _FromStudentDetailState extends State<FromStudentDetail> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 0),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: GestureDetector(
          onLongPress: () {
            HapticFeedback.vibrate();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StudentDataUpdateWidget(
                  name: widget.name,
                  roll: widget.roll,
                  grade: widget.grade,
                  attendance: widget.attendance,
                  id: widget.id,
                  teacherId: widget.teacherId,
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
