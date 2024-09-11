import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
class AppProvider extends ChangeNotifier{
  static final auth=FirebaseAuth.instance;
  String articleval="";
  String htmlData = "<p>Loading from controller...</p>";
  AppProvider(){
    articleval;
  }

  setartitcie(String articale){
    print(articale);
    articleval=articale;
    notifyListeners();

  }

  Future<List<dynamic>?> fetchData() async {
    try{
      var url = Uri.parse('https://portal.ylpghanaapp.com/api/v1/ylp');
      var response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer 6|DyMM7tTXwU72lpMixtM3xXOVxYKLGx1KUMGCGvdg',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['data'];
        if (data is List) {
          return data;  // Return the data as a List
        } else {
          return [];  // Return an empty list if the data is not a List
        }
      } else {
        print('Failed to fetch data: ${response.statusCode}');
        return null;  // Return null in case of failure
      }
    }catch(e){
      print(e);
    }

  }


  Future<void> fetchDataArticle() async {

    var url = Uri.parse('https://portal.ylpghanaapp.com/api/v1/ylp?catID[eq]=${articleval}');
    var response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer 6|DyMM7tTXwU72lpMixtM3xXOVxYKLGx1KUMGCGvdg',
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)['data'];
      htmlData = "<div>";
      for (var region in data) {
        //   htmlData = region['article'];//"<h2>${region['title']}</h2>";
        htmlData += region['article'];
      }
      htmlData += "</div>";

      // Assuming the API returns a list of articles, convert it to HTML

    } else {

        htmlData = "<p>Error fetching data. Status code: ${response.statusCode}</p>";

    }
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
     // Create a new provider
     try {
       GoogleAuthProvider googleProvider = GoogleAuthProvider();
       googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
       googleProvider.setCustomParameters({
         'login_hint': 'user@example.com'
       });
       // Once signed in, return the UserCredential
       final my_login = await auth.signInWithPopup(googleProvider);
       if(my_login!=null)
       {
         String? displayname = auth.currentUser!.displayName;
         String? loginmail = auth.currentUser!.email;
         List? namelist = displayname!.split(" ");
         String fname = namelist[0];
         String lname = namelist[1];

       }
       //print(my_login);
     }on FirebaseException catch(e){
       // print(e);
       //errorMsgs=e.message!;
     }
     notifyListeners();
   }


}


