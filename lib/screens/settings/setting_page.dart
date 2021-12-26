import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pingo_learn/screens/login.dart';
import 'package:pingo_learn/screens/settings/change_password.dart';
import 'package:pingo_learn/services/firebase_database.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  final FirebaseAuth auth = FirebaseAuth.instance;



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Center(child: Text("Settings")),



      ),

      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 70, 20, 20),

        child: Column(
          children: [

            Center(
              child: CircleAvatar(
                maxRadius: 40,
                backgroundColor: Colors.cyan,
              )
            ),

            SizedBox(height: 20,),

            Center(
              child: Text(
                auth.currentUser!.displayName.toString(),
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),

            SizedBox(height: 10,),

            Center(
              child: Text(
                auth.currentUser!.email.toString(),
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,

                ),
              ),
            ),

            SizedBox(height: 50,),

            InkWell(
              onTap: (){

                Navigator.push(context, MaterialPageRoute(builder: (context)=>ChangePassword()));

              },
              child: Row(
                children: [

                  Icon(
                      Icons.lock,
                    size: 30,
                  ),

                  SizedBox(width: 20,),

                  Text(
                    'Change Password',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,

                    ),

                  ),

                  Spacer(),

                  Icon(
                    Icons.arrow_forward_ios,
                    size: 30,
                  ),


                ],
              ),
            ),

            SizedBox(height: 10),

            InkWell(
              onTap: () async{


                showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.grey,
                      title:  Text('Confirm',style: TextStyle(color: Colors.black),),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children:  <Widget>[
                            Text('Your account deleted permanently and All data ',style: TextStyle(color: Colors.black),),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () async{
                            Navigator.of(context).pop();
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login()), (route) => false);

                            await FirebaseApi().deleteAccount();


                          },
                        ),
                      ],
                    );
                  },
                );


              },
              child: Row(
                children: [

                  Icon(
                    Icons.delete,
                    size: 30,
                  ),

                  SizedBox(width: 20,),

                  Text(
                    'Delete Account',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,

                    ),

                  ),

                  Spacer(),

                  Icon(
                    Icons.arrow_forward_ios,
                    size: 30,
                  ),


                ],
              ),
            ),


            SizedBox(height: 10),

            InkWell(
              onTap: (){

                showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.grey,
                      title:  Text('Confirm',style: TextStyle(color: Colors.black),),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children:  <Widget>[
                            Text('Click ok to confirm',style: TextStyle(color: Colors.black),),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () async{
                            Navigator.of(context).pop();

                            await FirebaseAuth.instance.signOut();

                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login()), (route) => false);


                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Row(
                children: [

                  Icon(
                    Icons.logout,
                    size: 30,
                  ),

                  SizedBox(width: 20,),

                  Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,

                    ),

                  ),

                  Spacer(),

                  Icon(
                    Icons.arrow_forward_ios,
                    size: 30,
                  ),


                ],
              ),
            ),

          ],
        ),
      ),

    );
  }
}
