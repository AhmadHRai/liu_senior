import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logein/profil_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      home:HomePaege(),
    ); 
  }
}
class HomePaege extends StatefulWidget {
  const HomePaege({Key? key}) : super(key: key);

  @override
  State<HomePaege> createState() => _HomePaegeState();
}

class _HomePaegeState extends State<HomePaege> {
     Future<FirebaseApp> _initializeFirebase() async{
         FirebaseApp firebaseApp = await Firebase.initializeApp();
        return firebaseApp;
     }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
       return loginScreen();
      }
          return const Center(child:  CircularProgressIndicator(),
       );
          },

      ),
    );
  }
}


class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {

  static Future<User?> loginUsingEmailPassword({required String email, required String password, required BuildContext context })async{
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email ,password: password);
      user =userCredential.user;

    }on FirebaseAuthException catch (e){
      if(e.code == "user not found") {
        print("no u f f thes email");
      }
      }
      return user;

  }
  @override
  Widget build(BuildContext context) {
   TextEditingController _emailController =TextEditingController();
   TextEditingController _passwordController =TextEditingController();
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:  [
        const Text(
              "aymanApp",
              style: TextStyle
                (color: Colors.blue,
                fontSize: 28.0,
              ),
          ),
      const Text(
              "login to my app",
              style: TextStyle
                (color: Colors.lightBlueAccent,
                fontSize: 44.0,
              ),
          ),
      const SizedBox(
         height: 12.0,
       ),
       TextField (
        controller: _emailController,
         keyboardType: TextInputType.emailAddress,
         decoration: const InputDecoration(
           hintText:  "User Email",

         ),



       ),
      const SizedBox(
      height: 12.0,
       ),
       TextField (
         controller: _passwordController,
        keyboardType: TextInputType.number,
       decoration: const InputDecoration(
         hintText:  "Password",
       ),
      ),
       const  SizedBox(
            height: 12.0,
          ),
       const  Text(
              "dont rememher u pass",style: TextStyle(color: Colors.lightBlueAccent),
          ),

       const  SizedBox(
            height: 88.0,
          ),
          Container(
           width: double.infinity,
            child: RawMaterialButton(
              fillColor:const Color(0xFF0069FE),
              elevation: 0.0,
              padding:const EdgeInsets.symmetric(vertical: 20.0),
                shape : RoundedRectangleBorder ( borderRadius : BorderRadius.circular (12.0)),

              onPressed: () async {
                User? user = await loginUsingEmailPassword(email: _emailController.text, password: _passwordController.text, context: context);
              print(user);
              if(user!=null){
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> ProfileScreen()));
              }
                },

            child:const Text("LOGIN",
                style: TextStyle(
                    color: Colors.white
                )),
    ),
          ),
          ],
    ),
    );
  }
}
