import 'dart:io';

import 'package:chat_app/widgets/user_image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

final firebase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() {
    return _AuthScreenState();
  }
}

class _AuthScreenState extends State<AuthScreen> {
  final formKey = GlobalKey<FormState>();
  bool showPassword = false;
  bool isLogin = true;
  bool isLoading = false;

  File? userPickedImage;

  late String enteredEmail;
  late String enteredPassword;
  String? enteredUsername;

  void submit() async {
    final isValid = formKey.currentState!.validate();
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    if (!isValid) {
      return;
    }

    if (!isLogin && userPickedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please upload an image to continue.'),
        ),
      );
      return;
    }

    formKey.currentState?.save();

    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredentials;
      if (isLogin) {
        userCredentials = await firebase.signInWithEmailAndPassword(
            email: enteredEmail, password: enteredPassword);
      } else {
        userCredentials = await firebase.createUserWithEmailAndPassword(
            email: enteredEmail, password: enteredPassword);

        final storageRf = FirebaseStorage.instance
            .ref()
            .child('user_images')
            .child('${userCredentials.user!.uid}.jpg');

        await storageRf.putFile(userPickedImage!);
        final downloadUrl = await storageRf.getDownloadURL();

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredentials.user!.uid)
            .set({
          'username': enteredUsername,
          'email_id': enteredEmail,
          'image_url': downloadUrl
        });
      }

      setState(() {
        isLoading = false;
        formKey.currentState!.reset();
        enteredEmail = '';
        enteredPassword = '';
        isLogin = !isLogin;
      });
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message ?? 'Authentication failed'),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(20),
                width: 100,
                child: Image.asset('assets/images/chat.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (!isLogin)
                            UserImagePicker(
                              pickedImage: (image) {
                                userPickedImage = image;
                              },
                            ),
                          TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'email id'),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              enteredEmail = value!;
                            },
                          ),
                          if (!isLogin)
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Username'),
                              enableSuggestions: false,
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().length < 4) {
                                  return 'username must be 4 character long';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                enteredUsername = value!;
                              },
                            ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'password',
                              suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    showPassword = !showPassword;
                                  });
                                },
                                icon: showPassword
                                    ? const Icon(Icons.remove_red_eye)
                                    : const Icon(Icons.remove_red_eye_outlined),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().length < 6) {
                                return 'Password must be at least 6 characters long.';
                              }
                              return null;
                            },
                            obscureText: !showPassword,
                            onSaved: (value) {
                              enteredPassword = value!;
                            },
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: isLoading ? null : submit,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer),
                            child: !isLoading
                                ? Text(isLogin ? 'Login' : 'Signup')
                                : const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(),
                                  ),
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () {
                              formKey.currentState!.reset();
                              setState(() {
                                isLogin = !isLogin;
                              });
                            },
                            child: Text(isLogin
                                ? 'Create an account.'
                                : 'Already have an account.'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
