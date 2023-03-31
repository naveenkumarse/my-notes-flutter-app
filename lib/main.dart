import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_notes/view/login_view.dart';
import 'package:my_notes/view/register_view.dart';
import 'package:my_notes/view/verify_email_view.dart';

import 'firebase_options.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: HomePage(),
    routes: {
      '/login/': (context) => const LoginView(),
      '/register/': (context) => const RegisterView()
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            // if (user?.emailVerified ?? false) {
            //   return Text("Done");
            // } else {
            //   return const VerifyEmailView();
            // }
            if (user != null) {
              if (user.emailVerified) {
                print("Email is verifird");
              } else {
                return const VerifyEmailView();
              }
            }

            return LoginView();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
