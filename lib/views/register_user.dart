import 'package:flutter/material.dart';
import 'package:post_api/services/network.dart';
import 'package:post_api/views/post_image_view.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  State<RegisterUser> createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  Network network = Network();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
                fillColor: Colors.grey,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Password",
                fillColor: Colors.grey,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: (){
                final statusCode = network.registerUser(emailController.text, passwordController.text);
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PostImageView()));
              },
              // focusColor: Colors.white,
              // highlightColor: Colors.white,
              splashColor:Colors.red ,
              child: Ink(
                height: 40,
                width: 140,
                decoration: BoxDecoration(
                    color: Colors.teal, borderRadius: BorderRadius.circular(40)),
                child: Center(
                    child: Text(
                  "Register",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
