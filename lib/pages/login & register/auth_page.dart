//authentication page :if user login then go to home page,
//if user not login then go to login page

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mental_heatlh_app/pages/home_page.dart';
import 'package:mental_heatlh_app/pages/login%20&%20register/login_or_register.dart';



class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
            //if user log in
            if(snapshot.hasData){
              return HomePage();
            }
            //if user not log in
            else{
              return LoginOrRegisterPage();
            }
          },
      ),
    );
  }
}
