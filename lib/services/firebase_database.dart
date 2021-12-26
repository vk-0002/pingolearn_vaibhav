import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pingo_learn/models/word_details.dart';
import 'dart:math';

class FirebaseApi{

  final database = FirebaseDatabase.instance.reference();
  final FirebaseAuth auth = FirebaseAuth.instance;


  Future saveData (WordDetails wordDetails) async
  {

    print('in upload data');



    final deviceIdReference = database.child(auth.currentUser!.uid +'/'+ DateTime.now().millisecondsSinceEpoch.toString());

    Map<String,dynamic> data =Map();

    data['word']=wordDetails.word;
    data['meaning']=wordDetails.definitions[0].definition;
    data['img']=wordDetails.definitions[0].imageUrl;
    data['example']=wordDetails.definitions[0].example;

    deviceIdReference.update(
        data
    );
  }

  Future<bool> deleteAccount()async{

    final deviceIdReference = database.child(auth.currentUser!.uid);

    try {
      await FirebaseAuth.instance.currentUser!.delete();
      await deviceIdReference.remove();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        print('The user must reauthenticate before this operation can be executed.');
        return false;
      }
    }
    return false;

  }

  Future<bool> changePassword(String currentPassword, String newPassword) async {



    User? user = await FirebaseAuth.instance.currentUser;

    final cred = EmailAuthProvider.credential(
        email: user!.email.toString(), password: currentPassword);

    user.reauthenticateWithCredential(cred).then((value) {
      user.updatePassword(newPassword).then((_) {

        return true;
      }).catchError((error) {
        print('first');
        print(error);
        return false;
      });
    }).catchError((err) {
      print('sec');
      print(err);
      return false;
    });
    return false;
  }


  Future fetchData() async{



    DataSnapshot data = await database.child(auth.currentUser!.uid).once() ;

    print(data.value);

    return data;

  }

  Future deleteWord(String id)async{

    final deviceIdReference = database.child(auth.currentUser!.uid).child(id);
    await deviceIdReference.remove();


  }



}

