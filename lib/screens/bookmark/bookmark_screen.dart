import 'package:flutter/material.dart';
import 'package:pingo_learn/screens/bookmark/list_of_bookmark.dart';
import 'package:pingo_learn/services/firebase_database.dart';

class BookmarkScreen extends StatefulWidget {
  //const BookmarkScreen({Key? key}) : super(key: key);

  final Map value;
  const BookmarkScreen(this.value);

  @override
  _BookmarkScreenState createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(


      body: Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(20, 50, 20, 30),
            child: Text(
              'Your Word is \n   ${widget.value.values.elementAt(0)['word']}',
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),


          Container(

            child: Column(
              children: [

                Container(

                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),

                    decoration: BoxDecoration(

                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),


                    child: Column(
                      children: [

                        Text(
                          'Meaning',
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),



                        Text(
                          widget.value.values.elementAt(0)['meaning'].toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),

                      ],
                    )

                ),


                Container(

                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),

                    decoration: BoxDecoration(

                      color: Colors.grey.shade400,
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),


                    child: Column(
                      children: [

                        Text(
                          'Example',
                          style: TextStyle(
                              fontSize: 25.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),



                        Text(
                          widget.value.values.elementAt(0)['example'].toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),

                      ],
                    )

                ),

                widget.value.values.elementAt(0)['img']!='null' ? Image.network(
                  widget.value.values.elementAt(0)['img'].toString(),
                  width: 280.0,

                ):

                Image.asset('assets/not_found.png'),

              ],
            ),

          ),


        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton:FloatingActionButton(
        backgroundColor: Colors.red,
          child: Icon(
              Icons.delete,

          ),
          onPressed: () {

            FirebaseApi().deleteWord(widget.value.keys.first);


            Navigator.pop(context);
            Navigator.pop(context);

            Navigator.push(context, MaterialPageRoute(builder: (context)=>BookMarks()));

          },
        ),


    );
  }
}
