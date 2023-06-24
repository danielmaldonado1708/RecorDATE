// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recordate/pages/home_page.dart';

class AuthClass {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<void> googleSignIn(BuildContext context) async {

    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);

        try {
          UserCredential userCredential =
              await auth.signInWithCredential(credential);
              
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => const HomePage()),
              (route) => false);

        } catch (e) {
          print(e);
        }
      }
    } catch (e) {
          // const snackBar =  SnackBar(content: Text('No se pudo iniciar sesion'));
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(e);
    }
  }

}
