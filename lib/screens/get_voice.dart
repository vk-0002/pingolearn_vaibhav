import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:pingo_learn/models/word_details.dart';
import 'package:pingo_learn/screens/bookmark/list_of_bookmark.dart';
import 'package:pingo_learn/screens/settings/setting_page.dart';
import 'package:pingo_learn/services/api.dart';
import 'package:pingo_learn/services/firebase_database.dart';
import 'package:speech_to_text/speech_to_text.dart' as speechToText;
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';



class GetVoice extends StatefulWidget {
  @override
  _GetVoiceState createState() => _GetVoiceState();
}

class _GetVoiceState extends State<GetVoice> {
  late speechToText.SpeechToText speech;
  String textString = "Press the Button to start speaking";
  String word='';
  bool isListen = false;
  bool isSwitchOn=false;

  late WordDetails _wordDetails;


  void listen() async {
    if (!isListen) {
      bool avail = await speech.initialize();
      if (avail) {
        setState(() {
          isListen = true;
        });
        speech.listen(onResult: (value) async{

          word = textString = value.recognizedWords;
          textString= "Your Word : \n     "+textString;



          if(word.isNotEmpty && word != '' ){

            print(word);

            try {
              var details= await Api().getWordDetails(word);

              if(details!=null){

                _wordDetails = WordDetails.fromJson(details);

              }
            } on Exception catch (e) {
              // TODO
              print(e);
            }

          }



          setState(()  {

          });

        });
      }
    } else {
      setState(() {
        isListen = false;
      });
      speech.stop();
    }
  }

  @override
  void initState() {
    super.initState();
    speech = speechToText.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("PingoLearn - Round 1")),



        actions: [

          IconButton(
              onPressed: (){

                if(_wordDetails!=null)
                  FirebaseApi().saveData(_wordDetails);

              },
              icon: Icon(
                Icons.bookmark_border
              )
          )

        ],

      ),

      drawer: Drawer(


            child: Column(


             // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,


              children: [

                SizedBox(height: 100,),

                InkWell(
                  onTap: (){


                    Navigator.push(context, MaterialPageRoute(builder: (context)=>BookMarks()));


                  },

                  child: Row(
                    children: [

                      SizedBox(width: 10,),
                      Icon(
                        Icons.history,
                        size: 30,
                      ),

                      SizedBox(width: 10,),

                      Text(
                        'History',

                        style: TextStyle(
                          fontSize: 22
                        ),
                      )

                    ],
                  ),
                ),

                SizedBox(height: 10,),

                InkWell(
                  onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Settings()));

                  },

                  child: Row(
                    children: [

                      SizedBox(width: 10,),
                      Icon(
                        Icons.settings,
                        size: 30,
                      ),

                      SizedBox(width: 10,),

                      Text(
                        'Settings',

                        style: TextStyle(
                            fontSize: 22
                        ),
                      )

                    ],
                  ),
                ),

                SizedBox(height: 10,),

                InkWell(
                  onTap: (){



                  },

                  child: Row(
                    children: [

                      SizedBox(width: 10,),
                      Icon(
                        Icons.dark_mode,
                        size: 30,
                      ),

                      SizedBox(width: 10,),

                      Text(
                        'Dark Mode',

                        style: TextStyle(
                            fontSize: 22
                        ),
                      ),

                      SizedBox(width: 20,),
                      FlutterSwitch(
                        value: isSwitchOn,
                        activeColor: Colors.cyan,
                        onToggle: (value) {
                          setState(() {
                            isSwitchOn = value;

                            print(value);

                          });

                          if(value == true){
                            Get.changeTheme(ThemeData.dark());
                          }
                          if(value == false){
                            Get.changeTheme(ThemeData.light());

                          }

                        },
                      ),

                    ],
                  ),
                ),

              ],
            )

      ),

      body: Column(
        children: [
          SizedBox(
            height: 10.0,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              textString,
              style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),


          word != "" ? Container(

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
                        _wordDetails.definitions.first.definition.toString(),
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
                          _wordDetails.definitions.first.example.toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),

                      ],
                    )

                ),

                _wordDetails.definitions.first.imageUrl!='null' ? Image.network(
                  _wordDetails.definitions.first.imageUrl.toString(),
                  width: 280.0,

                ):

                Image.asset('assets/not_found.png'),

              ],
            ),

          ): Container(),


        ],
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      floatingActionButton: AvatarGlow(
        animate: isListen,
        glowColor: Colors.red,
        endRadius: 65.0,
        duration: Duration(milliseconds: 2000),
        repeatPauseDuration: Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          child: Icon(isListen ? Icons.mic : Icons.mic_none),
          onPressed: () {
            listen();
          },
        ),
      ),
    );
  }
}