import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mental_heatlh_app/components/button.dart';
import 'package:mental_heatlh_app/components/square_tile.dart';
import 'package:mental_heatlh_app/components/text_field.dart';


class LoginPages extends StatefulWidget {
  final Function()? onTap;
  const LoginPages({
    super.key,
    required this.onTap
  });

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  final  emailController = TextEditingController();
  final  passwordController = TextEditingController();


  void signUserIn() async {
    //loading indicator
    showDialog(
      context: context,
      builder: (context){
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
    );
    //sign in user
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //close loading indicator
        Navigator.pop(context);
    } on FirebaseAuthException catch (e){
        Navigator.pop(context);
      //Wrong email or password
      showErrorMessage(e.code);
    }

  }
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Error',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'OK',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                //logo
                const SizedBox(
                  height: 200,
                  child: Icon(Icons.lock,
                  size: 100,),
                ),
                const SizedBox(height: 20,),

                Text('Welcome back, you\'ve been missed',
                style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 25,),

                //Email
                MyTextField(
                  hintText: 'Email',
                  obscureText: false,
                  icon: Icons.email,
                  controller: emailController,
                ),
                const SizedBox(height: 25,),

                //Password
                MyTextField(
                  hintText: 'Password',
                  obscureText: true,
                  icon: Icons.lock,
                  controller: passwordController,
                ),


                //Forget password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Forget password?',
                        style:TextStyle(
                          color: Colors.grey[600],

                        ) ,),
                    ],
                  ),
                ),
                const SizedBox(height: 25,),

                //Sign in button
                MyButton(
                  text: 'Sign In',
                  onTap: signUserIn,
                ),
                const SizedBox(height: 50,),

                //Sign in option
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(child:
                      Divider(
                        thickness: 1.0,
                        color: Colors.grey[400],
                      ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text('Or Continue with',
                        style: TextStyle(
                          color: Colors.grey[600],

                        ),
                        ),
                      ),
                      Expanded(child:
                      Divider(
                        thickness: 1.0,
                        color: Colors.grey[400],
                      ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      imagePaths:'assets/images/google.png',
                    ),
                    const SizedBox(width: 10,),
                    SquareTile(
                      imagePaths:'assets/images/apple.png',
                    ),
                  ],
                ),
                const SizedBox(height: 50,),

                //Don't have an account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have account? ',),
                    const SizedBox(width: 5,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text('Register now ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
