
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/services.dart';
import 'package:pingo_learn/screens/login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final FirebaseAuth  _auth=FirebaseAuth.instance;

  var _formKey= GlobalKey<FormState>();
  TextEditingController _email=TextEditingController();
  TextEditingController _name=TextEditingController();

  bool secureText=true;

  String _newPassword='',_conformPassword='';




  void getData() async{

    try {
      UserCredential result= await _auth.createUserWithEmailAndPassword(
          email:_email.text,
          password: _newPassword,
      );
      print(result);
      
      User? user = result.user;
      user!.updateDisplayName(_name.text);


      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.grey,

            content: SingleChildScrollView(
              child: ListBody(
                children:  <Widget>[
                  Text('account created successfully',style: TextStyle(color: Colors.black),),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                },
              ),
            ],
          );
        },
      );


    } on Exception catch (e) {
      // TODO

      print(e);
    }






  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 70, 20, 0),
          child: Form(

            key: _formKey,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[


                Center(
                  child: Text(
                    'Create Account',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontFamily: 'Aller',
                        letterSpacing: 2
                    ),
                  ),
                ),

                SizedBox(height: 150,),

                TextFormField(

                  controller: _name,

                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.5,
                  ),

                  decoration: InputDecoration(

                    labelText: "Name",
                    labelStyle: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 16,
                      letterSpacing: 1,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),

                  ),

                ),

                SizedBox(height: 20,),

                TextFormField(

                  controller: _email,

                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.5,
                  ),

                  keyboardType: TextInputType.emailAddress,





                  decoration: InputDecoration(



                    labelText: "E-Mail",
                    labelStyle: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 16,
                      letterSpacing: 1,
                    ),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),

                  ),

                ),

                SizedBox(height: 20,),


                // SizedBox(height: 20,),

                Center(
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.5
                    ),
                    onChanged: (text){
                      _newPassword=text;
                    },
                    obscureText: secureText,
                    decoration: InputDecoration(

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


                SizedBox(height: 20,),

                Center(
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.5
                    ),
                    onChanged: (text){
                      setState(() {
                        _conformPassword=text;

                      });
                    },
                    obscureText: true,

                    decoration: InputDecoration(

                      labelText: "Conform Password",
                      labelStyle: TextStyle(
                        fontSize: 16,
                        color: Colors.lightBlueAccent,
                        letterSpacing: 1,
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                    ),

                  ),
                ),


                SizedBox(height: 40,),

                SizedBox(
                  height: 45,
                  width: 340,
                  child: RaisedButton(
                    onPressed:(){

                      print('in sn ');

                      if(_newPassword!=_conformPassword || _newPassword=='')
                      {

                        print('password ');

                        showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              backgroundColor: Colors.grey,
                              title: const Text('Error',style: TextStyle(color: Colors.red),),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children:  <Widget>[
                                    Text('Password dose not match',style: TextStyle(color: Colors.black),),
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );

                      }else {

                        getData();
                      }

                    } ,

                    color: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      side: BorderSide(color: Colors.cyanAccent),
                    ),

                    child: Text(
                      'Sign up',

                      style:  TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                        letterSpacing: .5,
                      ),
                    ) ,

                    //onPressed: null,

                  ),
                ),


                SizedBox(height: 20,),

                Divider(color: Colors.grey,thickness: 1,),

                Center(
                    child: Row(

                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: Text(
                                'already have an account ?',
                                style: TextStyle(
                                  color: Colors.grey,
                                )
                            ),
                          ),

                          Center(

                            child: FlatButton(
                              onPressed: (){

                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Login()));
                              },
                              child: Text(
                                'log in',
                                style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontFamily: 'Aller',
                                ),
                              ),
                            ),
                          ),

                        ]
                    )
                )



              ],
            ),
          ),
        ),
      ),
    );
  }
}
