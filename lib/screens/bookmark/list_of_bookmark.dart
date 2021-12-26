import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pingo_learn/screens/bookmark/bookmark_screen.dart';
import 'package:pingo_learn/services/firebase_database.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BookMarks extends StatefulWidget {
  const BookMarks({Key? key}) : super(key: key);

  @override
  _BookMarksState createState() => _BookMarksState();
}

class _BookMarksState extends State<BookMarks> {


  List<Map<dynamic,dynamic>> bookmarkData=[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(


      appBar: AppBar(
        title: Text(
          'History'
        ),
      ),


      body: Padding(
        padding: EdgeInsets.fromLTRB(20, 30, 20, 20),


        child: ListView(
          children: bookmarkData.map((value){
            return Container(

              margin: EdgeInsets.only(bottom: 10),
              // padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  //colors: [Color(0xFF6448FE),Color(0xFF5FC6FF)],

                  colors :  [
                    Color.fromARGB(255, 62, 182, 226),
                    Color.fromARGB(255, 148, 231, 225),

                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  tileMode: TileMode.clamp,
                ),
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: SizedBox(
                height: 55,

                child: InkWell(
                  onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BookmarkScreen(value)));

                  },
                  child: Row(
                    children: [

                      SizedBox(width: 20,),
                      Text(
                        value.values.elementAt(0)['word'],
                        style: TextStyle(
                            fontSize: 30
                        ),
                      ),

                      Spacer(),

                      IconButton(
                          onPressed: (){

                            print(value.keys.first);

                            FirebaseApi().deleteWord(value.keys.first);

                            getData();

                          },
                          icon: Icon(
                              Icons.delete,
                            color: Colors.red,
                            size: 30,
                          ),
                      ),

                    ],
                  ),
                ),
              )
            );
          }).toList(),
        ),

      ),

    );
  }

  void getData() async{

    DataSnapshot dataSnapshot = await FirebaseApi().fetchData();

    print(jsonDecode(jsonEncode(dataSnapshot.value)));


    Map data;
    try {
       data = Map<String, dynamic>.from(jsonDecode(jsonEncode(dataSnapshot.value)));
    } catch(e) {

      return;
      // TODO
    }

    bookmarkData.clear();

    data.forEach((key, value) {
      Map temp=Map();
      temp[key]=Map<String, dynamic>.from(jsonDecode(jsonEncode(value)));
      bookmarkData.add(temp);
      print(temp.keys.first);
    });

    setState(() {

    });

  }
}
