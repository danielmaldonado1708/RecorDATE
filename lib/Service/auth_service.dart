// ignore_for_file: use_build_context_synchronously, prefer_function_declarations_over_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:recordate/pages/home_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthClass {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  final storage = new FlutterSecureStorage();

  /* ================================ 
  funciones de autenticacion
  ================================ */
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

          //guardar datos en almacenamiento seguro, para revisarlo en main.dart
          storeTokenAndData(userCredential);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (builder) => const HomePage()),
              (route) => false);
          showSnackBar(context,
              "Bienvenido/a! ${userCredential.user!.displayName ?? 'Nombre desconocido...'}");
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

  Future<void> verifyPhoneNumber(
      String phoneNumber, BuildContext context, Function setData) async {
    PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential phoneAuthCredential) async {
      showSnackBar(context, "Verificación completada");
    };

    PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException exception) {
      showSnackBar(context, exception.toString());
    };

    PhoneCodeSent codeSent =
        (String verificationID, [int? forceResnedingtoken]) {
      showSnackBar(context, "Se envió el código de verificación");
      setData(verificationID);
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {
      showSnackBar(context, "Tiempo de espera finalizado");
    };
    try {
      await auth.verifyPhoneNumber(
          timeout: Duration(seconds: 60),
          phoneNumber: phoneNumber,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e);
    }
  }

  Future<void> signInwithPhoneNumber(
      String verificationId, String smsCode, BuildContext context) async {
    try {
      AuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      storeTokenAndData(userCredential);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (builder) => HomePage()),
          (route) => false);

      showSnackBar(context, "Bienvenido/a!");
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  /* ================================ 
    funciones de apoyo
  ================================ */
  Future<void> storeTokenAndData(UserCredential userCredential) async {
    await storage.write(
        key: "token", value: userCredential.credential!.token.toString());
    print('token guardado');
    await storage.write(
        key: "userCredential", value: userCredential.toString());
    await storage.write(key: "userId", value: userCredential.user?.uid);

    await storage.write(
        key: "userName", value: userCredential.user?.displayName);
    await storage.write(key: "email", value: userCredential.user?.email);
    print('user id guardado');
    print(userCredential.user?.uid);
    print('user name guardado');
    print(userCredential.user?.displayName);
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  Future<String?> getUserId() async {
    User? user = await auth.currentUser;

    String userId = user?.uid ?? '';

    return userId;  }

  Future<String?> getEmail() async {
    return await storage.read(key: "email");
  }

  Future<String?> getUserName() async {

     User? user = await auth.currentUser;

    String displayName = user?.displayName ?? '';
    String email = user?.email ?? '';

    String nameOrEmail = displayName.isNotEmpty ? displayName : email;

    return nameOrEmail;
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await auth.signOut();
      await storage.delete(key: "token");
    } catch (e) {
      print(e);
    }
  }

  void showSnackBar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
