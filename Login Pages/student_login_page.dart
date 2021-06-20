import 'package:cool_alert/cool_alert.dart';
import 'package:data_app/Dashboard/student_dashboard.dart';
import 'package:data_app/Signup%20Page/student_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class StudentLoginWidget extends StatefulWidget {
  StudentLoginWidget({Key key}) : super(key: key);

  @override
  _StudentLoginWidgetState createState() => _StudentLoginWidgetState();
}

class _StudentLoginWidgetState extends State<StudentLoginWidget> {
  TextEditingController emailController;
  TextEditingController passwordController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Future<UserCredential> signinWithEmail(
        BuildContext context, String email, String password) async {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return userCredential;
      } on FirebaseAuthException catch (e) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'Error',
          text: e.code,
          loopAnimation: false,
        );
        return null;
      } catch (e) {
        print(e);
        return null;
      }
    }

    Future<UserCredential> signInWithGoogle() async {
      try {
        GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

        if (googleUser != null) {
          GoogleSignInAuthentication googleAuth =
              await googleUser.authentication;

          UserCredential authResult = await FirebaseAuth.instance
              .signInWithCredential(GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          ));

          return authResult;
        } else {
          return null;
        }
      } on FirebaseAuthException catch (e) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: 'Error',
          text: e.code,
          loopAnimation: false,
        );
        return null;
      } catch (e) {
        print(e);
        return null;
      }
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF4527A0),
        automaticallyImplyLeading: true,
        actions: [],
        centerTitle: true,
        elevation: 4,
      ),
      backgroundColor: Color(0xFFE8E7E7),
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(
              height: 100,
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Text(
                    'Student Log in',
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      fontSize: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Image.asset(
                    'images/student cover.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: TextFormField(
                    controller: emailController,
                    obscureText: false,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email ',
                      labelStyle: GoogleFonts.getFont(
                        'Montserrat',
                        color: Colors.black,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    ),
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 10),
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: GoogleFonts.getFont(
                        'Montserrat',
                        color: Colors.black,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                          topLeft: Radius.circular(5),
                          topRight: Radius.circular(5),
                        ),
                      ),
                      contentPadding: EdgeInsets.fromLTRB(5, 0, 0, 0),
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
                        UserCredential userCredential = await signinWithEmail(
                            context,
                            emailController.text,
                            passwordController.text);
                        if (userCredential != null) {
                          await Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StudentDashboardWidget(),
                            ),
                            (r) => false,
                          );
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
                          'Sign in',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text(
                    'OR',
                    style: GoogleFonts.getFont(
                      'Montserrat',
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SignInButton(
                  Buttons.Google,
                  text: "Sign up with Google",
                  onPressed: () async {
                    UserCredential credential = await signInWithGoogle();

                    if (credential != null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => StudentDashboardWidget(),
                          ),
                          (route) => false);
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StudentSignupWidget(),
                        ),
                      );
                    },
                    child: Text(
                      'Don\'t have account ? Sign up',
                      style: GoogleFonts.getFont(
                        'Poppins',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
