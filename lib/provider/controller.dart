import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class AppProvider extends ChangeNotifier{
  static final auth=FirebaseAuth.instance;
  String articleval="";
  String articletitle="";
  String htmlData = "<p>Loading from controller...</p>";
  String regionname="";
  String regioncode="";
  int article_specific_id=0;
  AppProvider(){
    // getarticle();
    // getregion();
  }
  setregion(String name,String code)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("regioncode", code);
    prefs.setString("regionname", name);
    notifyListeners();
  }
  getregion()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    regioncode=prefs.getString("regioncode")!;
    regionname=prefs.getString("regionname")!;
    notifyListeners();
  }

  setarticle(String articale,String title)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("catid", articale);
    prefs.setString("articletitle", title);

  }
  setarticle_specifi(int specificid)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("specificid", specificid);
  }

  getarticle()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    articleval=prefs.getString("catid")!;
    articletitle=prefs.getString("articletitle")!;
    article_specific_id=prefs.getInt("specificid")!;

    print(articletitle);
    notifyListeners();
  }
  removeaticle()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("catid")!;
    prefs.getString("articletitle")!;
    print(articletitle);
  }

  Future<List<dynamic>?> regions()async{
    try{
      var url=Uri.parse("https://portal.ylpghanaapp.com/api/v1/regions");
      var response=await http.get(url,headers: {
        'Authorization': 'Bearer 6|DyMM7tTXwU72lpMixtM3xXOVxYKLGx1KUMGCGvdg',
      });
      if(response.statusCode==200){
        var data = jsonDecode(response.body)['data'];
        if (data is List) {
          return data;  // Return the data as a List
        } else {
          return [];  // Return an empty list if the data is not a List
        }

      }
      else
      {
        print("Unseccessful");
        return [{"Error":"Bad Response"}];
      }

    }catch(e){

    }

  }
  Future<List<dynamic>?> articles_category()async{
    try{
      var url=Uri.parse("https://portal.ylpghanaapp.com/api/v1/ylpcat");
      var response=await http.get(url,headers: {
        'Authorization': 'Bearer 6|DyMM7tTXwU72lpMixtM3xXOVxYKLGx1KUMGCGvdg',
      });
      if(response.statusCode==200){
        var data = jsonDecode(response.body)['data'];
        if (data is List) {
          return data;  // Return the data as a List
        } else {
          return [];  // Return an empty list if the data is not a List
        }

      }
      else
      {
        print("Unseccessful");
        return [{"Error":"Bad Response"}];
      }

    }catch(e){

    }

  }

  Future<List<dynamic>?> constituencydata()async{
    try{
      var url=Uri.parse("https://portal.ylpghanaapp.com/api/v1/constituency?regionCode[eq]=${regioncode}");
      var response=await http.get(url,headers: {
        'Authorization': 'Bearer 6|DyMM7tTXwU72lpMixtM3xXOVxYKLGx1KUMGCGvdg',
      });
      if(response.statusCode==200){
        var data = jsonDecode(response.body)['data'];
        if (data is List) {
          return data;  // Return the data as a List
        } else {
          return [];  // Return an empty list if the data is not a List
        }

      }
      else
      {
        print("Unseccessful");
        return [{"Error":"Bad Response"}];
      }

    }catch(e){

    }

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


  Future<List<dynamic>?> fetchDataArticle() async {
    try{
      var url = Uri.parse('https://portal.ylpghanaapp.com/api/v1/ylp?catID[eq]=${articleval}');
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

  Future<void> fetchDataArticle_specific() async {
    try{
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
        for (var item in data) {
          if(article_specific_id==int.parse(item['id'])){
            htmlData = item['article'];
          }
          // Access individual properties
        }

        // for (int i=0; i<data.length;i++) {
        //   print(article_specific_id);
        //   print(data['id'][i]);
        //
        //   if(article_specific_id.toString()==data['id'][i].toString()){
        //     htmlData += data['article'][i];
        //
        //   }
        //   //   htmlData = region['article'];//"<h2>${region['title']}</h2>";
        // }
         htmlData += "</div>";
        print(htmlData);

        // Assuming the API returns a list of articles, convert it to HTML

      } else {

        htmlData = "<p>Error fetching data. Status code: ${response.statusCode}</p>";

      }
    }catch(e){
      print(e);
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


