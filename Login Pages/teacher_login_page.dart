import 'package:cool_alert/cool_alert.dart';
import 'package:data_app/Dashboard/teacher_dashboard.dart';
import 'package:data_app/Signup%20Page/teacher_signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

class TeacherLoginWidget extends StatefulWidget {
  TeacherLoginWidget({Key key}) : super(key: key);

  @override
  _TeacherLoginWidgetState createState() => _TeacherLoginWidgetState();
}

class _TeacherLoginWidgetState extends State<TeacherLoginWidget> {
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
        // Trigger the authentication flow
        final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Once signed in, return the UserCredential
        return await FirebaseAuth.instance.signInWithCredential(credential);
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
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Text(
                    'Teacher Log in',
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                  child: Image.asset(
                    'images/teacher cover.png',
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
                      labelStyle: GoogleFonts.montserrat(
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
                    style: GoogleFonts.montserrat(
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
                      labelStyle: GoogleFonts.montserrat(
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
                    style: GoogleFonts.montserrat(
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
                              builder: (context) => TeacherDashboardWidget(),
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
                    style: GoogleFonts.montserrat(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SignInButton(
                  Buttons.Google,
                  text: "Sign up with Google",
                  onPressed: () async {
                    UserCredential userCredential = await signInWithGoogle();
                    if (userCredential != null) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TeacherDashboardWidget(),
                          ),
                          (route) => false);
                    } else {
                      print("Google Signin error");
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
                          builder: (context) => TeacherSignupWidget(),
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
            ),
          ],
        ),
      ),
    );
  }
}
