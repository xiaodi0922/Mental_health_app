import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../components/button.dart';
import '../../../components/square_tile.dart';
import '../../../components/text_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({
    super.key,
    required this.onTap
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final  emailController = TextEditingController();
  final  passwordController = TextEditingController();
  final  confirmPasswordController = TextEditingController();


  void signUserUp() async {
    //loading indicator
    showDialog(
      context: context,
      builder: (context){
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    //Creating user
    try{
      //check if password and confirm password are the same
      if(passwordController.text == confirmPasswordController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text,
        );
      }
      else{
        //close loading indicator
        showErrorMessage('Password and Confirm Password must be the same');
        Navigator.pop(context);

      }

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


                Text('Welcome, lets create account',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10,),

                //Email
                MyTextField(
                  hintText: 'Email',
                  obscureText: false,
                  icon: Icons.email,
                  controller: emailController,
                ),
                const SizedBox(height: 10,),

                //Password
                MyTextField(
                  hintText: 'Password',
                  obscureText: true,
                  icon: Icons.lock,
                  controller: passwordController,
                ),
                const SizedBox(height: 10,),
                //Confirm Password
                MyTextField(
                  hintText: 'Confirm Password',
                  obscureText: true,
                  icon: Icons.lock,
                  controller: confirmPasswordController,
                ),

                const SizedBox(height: 25,),
                //Sign in button
                MyButton(
                  text: 'Sign Up',
                  onTap: signUserUp,
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
                    Text('Already have account?',),
                    const SizedBox(width: 5,),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text('Login now ',
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
