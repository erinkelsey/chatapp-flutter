import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../widgets/auth/auth_form.dart';

/// Authentication screen for the app.
///
/// Can switch between signup and login mode.
class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  /// [FirebaseAuth.instance] containing the authentication
  /// info for this user.
  final _auth = FirebaseAuth.instance;

  /// Boolean for tracking if info is currently loading.
  var _isLoading = false;

  /// Called when auth form is to be submitted.
  void _submitAuthForm(
    String email,
    String userName,
    File image,
    String password,
    bool isLogin,
    BuildContext ctx,
  ) async {
    AuthResult authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        // upload image to Firebase Storage
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child(authResult.user.uid + '.jpg');
        await ref.putFile(image).onComplete;
        final url = await ref.getDownloadURL();

        // save the username to Firebase
        await Firestore.instance
            .collection('users')
            .document(authResult.user.uid)
            .setData({
          'username': userName,
          'email': email,
          'image_url': url,
        });
      }
    } on PlatformException catch (err) {
      var message = 'An error occurred, please check your credentials.';

      if (err.message != null) {
        message = err.message;
      }

      // show error as snackbar
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(
        _submitAuthForm,
        _isLoading,
      ),
    );
  }
}
