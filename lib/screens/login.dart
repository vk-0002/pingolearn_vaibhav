import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pingo_learn/screens/get_voice.dart';
import 'package:pingo_learn/screens/register.dart';


class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  bool secureText=true;

  TextEditingController _userName=TextEditingController();
  TextEditingController _userPassword=TextEditingController();
  var _formKey= GlobalKey<FormState>();
  String _userNameError='',_userPasswordError='';



  void getData() async
  {

    print('in login');

    FirebaseAuth _auth=FirebaseAuth.instance;

    UserCredential result;

    try {
       result= await _auth.signInWithEmailAndPassword(
           email: _userName.text,
           password: _userPassword.text,
       );

       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GetVoice()));

    } on Exception catch (e) {
      // TODO

      print(e);

      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey,
            title:  Text('Error',style: TextStyle(color: Colors.black),),
            content: SingleChildScrollView(
              child: ListBody(
                children:  <Widget>[
                  Text('Invalid Email or Password',style: TextStyle(color: Colors.black),),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () async{
                  Navigator.of(context).pop();

                },
              ),
            ],
          );
        },
      );

    }





  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(


        body: Padding(
          padding: EdgeInsets.fromLTRB(20,40,20,0),
          child: SingleChildScrollView(

            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [

                  SizedBox(height: 250,),

                  //User Name Textfield.
                  Center(
                    child: TextFormField(
                      controller: _userName,
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.5
                      ),
                      onChanged: (val){
                        setState(() {
                          setState(() {
                            _userNameError='';
                          });
                        });
                      },
                      decoration: InputDecoration(
                        // fillColor: Colors.grey[900],
                        // filled: true,

                        labelText: "User Name",
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.lightBlueAccent,
                          letterSpacing: 1,
                        ),
                        hintText: "Email",
                        hintStyle: TextStyle(
                          color: Colors.white70,
                          letterSpacing: 1.5,
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                      ),

                    ),
                  ),

                  SizedBox(height: 20,),

                  //Password TextField
                  Center(
                    child: TextFormField(
                      controller: _userPassword,
                      style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1.5
                      ),
                      onChanged: (val){
                        setState(() {
                          _userPasswordError='';
                        });
                      },
                      obscureText: secureText,
                      decoration: InputDecoration(
                        // fillColor: Colors.grey[900],
                        // filled: true,

                        labelText: "Password",
                        labelStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.lightBlueAccent,
                          letterSpacing: 1,
                        ),


                        suffixIcon: IconButton(
                          icon: Icon(secureText? Icons.remove_red_eye : Icons.security),
                          onPressed: (){
                            setState(() {
                              secureText= !secureText;
                            });
                          },

                          splashRadius: .1,
                        ),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(7)),
                        ),
                      ),

                    ),
                  ),

                  // Login Button


                  SizedBox(height: 20,),

                  Center(
                    child: SizedBox(
                      height: 45,
                      width: 340,
                      child: RaisedButton(
                        onPressed:  () {

                          setState(() {


                              getData();

                          });
                        },

                        color: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(color: Colors.cyanAccent ),
                        ),
                        child: Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.grey[800],
                            letterSpacing: 0.5,
                            fontSize: 16,
                          ),
                        ),

                      ),
                    ),
                  ),

                  Center(

                    child: FlatButton(
                      onPressed: (){

                        Navigator.pushReplacementNamed(context, '/register');
                      },
                      child: Text(
                        'Forgot password',
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.blueAccent,
                            fontFamily: 'Aller'

                        ),
                      ),
                    ),
                  ),


                  //  SizedBox(height: 300,),

                  Divider(color: Colors.grey,thickness: 1,),

                  Center(
                      child: Row(

                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Text(
                                  'Don\'t have an account ?',
                                  style: TextStyle(
                                    color: Colors.grey,
                                  )
                              ),
                            ),

                            Center(

                              child: FlatButton(
                                onPressed: (){

                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Register()));
                                },
                                child: Text(
                                  'Sign up',
                                  style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontFamily: 'Aller'
                                  ),
                                ),
                              ),
                            ),

                          ]
                      )
                  )

                  // SizedBox(height: 300,),

                ],
              ),
            ),
          ),
        )

    );
  }
}
