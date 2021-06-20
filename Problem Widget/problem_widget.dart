import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProblemWidget extends StatefulWidget {
  final String problem;
  final String studentId;
  final String docId;

  ProblemWidget({
    @required this.studentId,
    @required this.problem,
    @required this.docId,
  });
  @override
  _ProblemWidgetState createState() => _ProblemWidgetState();
}

class _ProblemWidgetState extends State<ProblemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 100,
      color: Colors.redAccent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 2,
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Text(
              widget.problem,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () async {
              await FirebaseFirestore.instance
                  .collection("teachers")
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .collection("record")
                  .doc(widget.studentId)
                  .collection("problem")
                  .doc(widget.docId)
                  .delete();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Delete",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
