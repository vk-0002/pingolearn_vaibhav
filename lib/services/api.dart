import 'dart:convert';

import 'package:http/http.dart';


class Api{

  String token = "Token 08a5e3222b8be11a8bdcbaa455cb0f7ab1e7f608";


  Future getWordDetails(String word) async {

    if(word==null)
      return null;

    Uri url= Uri.parse('https://owlbot.info/api/v4/dictionary/$word');

    Response response;

    try{

      response= await get(
        url,
        headers: <String, String>{
          "Authorization": token
        },
      );

      print('responce');
      print(response.body);

    }catch(e){

      return null;

    }


    try{
      jsonDecode(response.body);
    }catch(e){
      print(e);
      return null;
    }


    if(response!=null && response.statusCode==200)
    {
      return jsonDecode(response.body);
    }
    else{
      return null;
    }



  }


}