import 'package:flutter/material.dart';
import 'package:pingo_learn/services/firebase_database.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  TextEditingController _oldPassword=TextEditingController();


  bool secureText=true;

  String _newPassword='',_conformPassword='';






  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 70, 20, 0),
          child: Form(


            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[


                Center(
                  child: Text(
                    'Change Password',
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

                  obscureText: true,
                  controller: _oldPassword,

                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: 1.5,
                  ),

                  keyboardType: TextInputType.emailAddress,





                  decoration: InputDecoration(

                    labelText: "Current Password",
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

                      labelText: "New Password",
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
                    onPressed:() async {


                      if(_newPassword!=_conformPassword || _newPassword=='')
                      {



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



                        bool res = await FirebaseApi().changePassword(_oldPassword.text, _newPassword);

                        if(res==false){

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
                                      Text('Something Wrong',style: TextStyle(color: Colors.red),),
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

                    } ,

                    color: Colors.lightBlueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      side: BorderSide(color: Colors.cyanAccent),
                    ),

                    child: Text(
                      'Change Password',

                      style:  TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                        letterSpacing: .5,
                      ),
                    ) ,

                    //onPressed: null,

                  ),
                ),




              ],
            ),
          ),
        ),
      ),
    );
  }
}
