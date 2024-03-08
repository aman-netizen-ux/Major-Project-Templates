import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:major_project__widget_testing/constants/colors.dart';
import 'package:major_project__widget_testing/state/loginProvider.dart';
import 'package:major_project__widget_testing/utils/scaling.dart';
import 'package:major_project__widget_testing/utils/snackBar.dart';
import 'package:major_project__widget_testing/views/Screens/LoginScreen/SignIn/githubSignIn.dart';
import 'package:major_project__widget_testing/views/Screens/LoginScreen/SignIn/googleSignIn.dart';
import 'package:provider/provider.dart';

class SignUpDetails extends StatefulWidget {
  const SignUpDetails({super.key});

  @override
  State<SignUpDetails> createState() => _SignUpDetailsState();
}

class _SignUpDetailsState extends State<SignUpDetails> {
  final TextEditingController _emailText = TextEditingController();
  final TextEditingController _passwordText = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool passwordVisible = true;
  static Future<User?> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required BuildContext context}) async {
    User? user;
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar("weak-password", red2,
            const Icon(Icons.report_gmailerrorred_outlined), context);
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e as String?);
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: heightScaler(context, 24)),
          child: SizedBox(
            width: widthScaler(context, 502),
            height: heightScaler(context, 292),
            child: Card(
              elevation: 20,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: widthScaler(context, 36)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: heightScaler(context, 11),
                          bottom: heightScaler(context, 14)),
                      child: Text(
                        "Create New Account",
                        style: GoogleFonts.firaSans(
                          fontSize: heightScaler(context, 16),
                          fontWeight: FontWeight.w500,
                          color: darkCharcoal,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: heightScaler(context, 35),
                          width: widthScaler(context, 130),
                          child: ElevatedButton(
                            onPressed: () async {
                              UserCredential user = await handleGoogleSignIn();
                              if (user.additionalUserInfo!.isNewUser == false) {
                                debugPrint(
                                  'An account exits with the given email address.',
                                );
                                // ignore: use_build_context_synchronously
                                showSnackBar(
                                    "An account exits with the given email address.",
                                    red2,
                                    const Icon(
                                        Icons.report_gmailerrorred_outlined),
                                    context);
                                FirebaseAuth.instance.signOut();
                              } else {
                                // ignore: use_build_context_synchronously
                                // Navigator.pushNamed(
                                //   context,
                                //   '/mainNavigation',
                                // );
                                final loginProvider =
                                    Provider.of<LoginProvider>(context,
                                        listen: false);

                                loginProvider.setCurrentIndex(1);
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              side: MaterialStateProperty.all<BorderSide>(
                                  const BorderSide(
                                color: Colors.black,
                                width: 1,
                              )),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/login/google 1.png',
                                  height: heightScaler(context, 17),
                                  width: widthScaler(context, 17),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: widthScaler(context, 10)),
                                  child: Text(
                                    "Google",
                                    style: GoogleFonts.firaSans(
                                        fontSize: heightScaler(context, 16),
                                        color: salmonRed,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: widthScaler(context, 10),
                        ),
                        SizedBox(
                          height: heightScaler(context, 35),
                          width: widthScaler(context, 130),
                          child: ElevatedButton(
                            onPressed: () async {
                              UserCredential user = await signInWithGitHub();
                              if (user.additionalUserInfo!.isNewUser == false) {
                                debugPrint(
                                  'An account exits with the given email address.',
                                );
                                // ignore: use_build_context_synchronously
                                showSnackBar(
                                    "An account exits with the given email address.",
                                    red2,
                                    const Icon(
                                        Icons.report_gmailerrorred_outlined),
                                    context);
                                FirebaseAuth.instance.signOut();
                              } else {
                                // ignore: use_build_context_synchronously
                                // Navigator.pushNamed(
                                //   context,
                                //   '/mainNavigation',
                                // );
                                final loginProvider =
                                    Provider.of<LoginProvider>(context,
                                        listen: false);

                                loginProvider.setCurrentIndex(1);
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              side: MaterialStateProperty.all<BorderSide>(
                                  const BorderSide(
                                color: Colors.black,
                                width: 1,
                              )),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/login/git.png',
                                  height: heightScaler(context, 17),
                                  width: widthScaler(context, 17),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: widthScaler(context, 7)),
                                  child: Text(
                                    "Git Hub",
                                    style: GoogleFonts.firaSans(
                                        fontSize: heightScaler(context, 16),
                                        color: darkCharcoal,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: heightScaler(context, 14),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            height: 1,
                            color: const Color(0xffadadad),
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Or Sign in with Email",
                            style: GoogleFonts.capriola(
                              decoration: TextDecoration.none,
                              fontSize: heightScaler(context, 12),
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffadadad),
                            ),
                          ),
                          SizedBox(
                            width: widthScaler(context, 10),
                          ),
                          Expanded(
                              child: Container(
                            height: 1,
                            color: const Color(0xffadadad),
                          )),
                        ],
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: SizedBox(
                              height: heightScaler(context, 40),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                   flex:488,
                                    child: TextFormField(
                                      cursorColor: darkCharcoal,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: white,
                                        hintStyle: GoogleFonts.firaSans(
                                          fontSize: heightScaler(context, 14),
                                          fontWeight: FontWeight.w500,
                                          color: concreteGrey,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: darkCharcoal,
                                            width: 1,
                                          ),
                                        ),
                                        hintText: 'First name',
                                        contentPadding:
                                            const EdgeInsets.only(left: 15),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a name';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {},
                                    ),
                                  ),
                                  const Expanded(
                                    flex: 24,child: SizedBox()
                                  ),
                                  Expanded(
                                   flex:488,
                                    child: TextFormField(
                                      cursorColor: darkCharcoal,
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: white,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: Colors.black,
                                            width: 3,
                                          ),
                                        ),
                                        hintStyle: GoogleFonts.firaSans(
                                          fontSize: heightScaler(context, 14),
                                          fontWeight: FontWeight.w500,
                                          color: concreteGrey,
                                        ),
                                        hintText: 'Last name',
                                        contentPadding: EdgeInsets.only(
                                            left: widthScaler(context, 15)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(10),
                                          borderSide: const BorderSide(
                                            color: darkCharcoal,
                                            width: 1,
                                          ),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter a name';
                                        }
                                        return null;
                                      },
                                      onSaved: (value) {},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: heightScaler(context, 15),
                            ),
                            child: SizedBox(
                              width: widthScaler(context, 430),
                              height: heightScaler(context, 40),
                              child: TextFormField(
                                cursorColor: darkCharcoal,
                                controller: _emailText,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: darkCharcoal,
                                      width: 3,
                                    ),
                                  ),
                                  hintStyle: GoogleFonts.firaSans(
                                    fontSize: heightScaler(context, 16),
                                    fontWeight: FontWeight.w500,
                                    color: concreteGrey,
                                  ),
                                  hintText: 'Email Address',
                                  contentPadding: EdgeInsets.only(
                                      left: widthScaler(context, 15)),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                      color: darkCharcoal,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an email';
                                  }
                                  if (!value.contains('@') ||
                                      !value.contains('.com')) {
                                    return 'Invalid email format';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: heightScaler(context, 40),
                            child: TextFormField(
                              cursorColor: darkCharcoal,
                              controller: _passwordText,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: darkCharcoal,
                                    width: 3,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: darkCharcoal,
                                    width: 1,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  color: greyish4,
                                  icon: Icon(passwordVisible
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                  onPressed: () {
                                    setState(() {
                                      passwordVisible = !passwordVisible;
                                    });
                                  },
                                ),
                                hintStyle: GoogleFonts.firaSans(
                                  fontSize: heightScaler(context, 16),
                                  fontWeight: FontWeight.w500,
                                  color: concreteGrey,
                                ),
                                hintText: 'Password',
                                contentPadding: EdgeInsets.only(
                                    left: widthScaler(context, 15)),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a password';
                                }
                                if (value.length <= 7) {
                                  return 'Password must be greater than 7 characters';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Container(
            width: widthScaler(context, 140),
            height: heightScaler(context, 40),
            margin: const EdgeInsets.symmetric(vertical: 20),
            child: ElevatedButton(
                onPressed: () async {
                  User? user = await createUserWithEmailAndPassword(
                    email: _emailText.text,
                    password: _passwordText.text,
                    context: context,
                  );
                  if (user != null) {
                    final loginProvider =
                        Provider.of<LoginProvider>(context, listen: false);

                    loginProvider.setCurrentIndex(1);
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(const Color(0xff518AFA)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                      EdgeInsets.zero),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  fixedSize:
                      MaterialStateProperty.all<Size>(const Size(160, 50)),
                ),
                child: Text(
                  "Next ",
                  style: TextStyle(
                      fontSize: heightScaler(context, 18),
                      fontWeight: FontWeight.w500),
                ))),
      ],
    );
  }
}
