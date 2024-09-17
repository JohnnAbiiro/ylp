import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ylp/provider/routes.dart';
class AppProvider extends ChangeNotifier{
   final auth=FirebaseAuth.instance;
   final db=FirebaseFirestore.instance;
  String articleval="";
  String articletitle="";
  String htmlData = "<p>Loading...</p>";
  String regionname="";
  String regioncode="";
  int article_specific_id=0;
  String userphone="";
  String usertype="";
  bool logout_status=false;
  AppProvider(){
    if(auth.currentUser==null){
      print("logout");
      logout_status=true;
      notifyListeners();
      //logout(context);
    }
    else
      {
        print("Login as ${auth.currentUser!.email}");
      }
    getarticle();
    getregion();
    getuserdata();
  }
  setregion(String name,String code)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("regioncode", code);
    prefs.setString("regionname", name);
    notifyListeners();
  }
  getregion()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    regioncode=prefs.getString("regioncode")??"No region Code"!;
    regionname=prefs.getString("regionname")??"No Region Name";
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
    articleval=prefs.getString("catid")??"no catid";
    articletitle=prefs.getString("articletitle")??"no article ID";
    article_specific_id=prefs.getInt("specificid")??0;

    print(articletitle);
    notifyListeners();
  }
  getuserdata()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userphone=prefs.getString("phone")!;
    usertype=prefs.getString("usertype")!;
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

  FuturefetchDataArticle_specific() async {
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
        for (var item in data) {
          if(article_specific_id==int.parse(item['id'])){
            return item['article'];
          }
          else
            {
              print("id");
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

        // Assuming the API returns a list of articles, convert it to HTML

      } else {
        return "<p>Error fetching data. Status code: ${response.statusCode}</p>";
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
      print(e);
      //errorMsgs=e.message!;
    }
    notifyListeners();
  }

  emaillogin(String email,String password,BuildContext context)async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password);
      if(auth.currentUser!=null){
        final userdata=await db.collection("users").doc(email).get();
        if(userdata.exists){
          String phone=userdata['phone'];
          String fname=userdata['fname'];
          String lname=userdata['sname'];
          String fullname="${lname} ${fname}";
          prefs.setString("phone", phone);
          prefs.setString("usertype", "Junior Level");
          auth.currentUser!.updateDisplayName(fullname);
          getuserdata();
          SnackBar snackBar=SnackBar(content: Text("Hello ${auth.currentUser!.displayName}, welcome to Youth Leadership Parliament Dashboard",style: TextStyle(color: Colors.white,fontSize: 18),),backgroundColor: Colors.green,);
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          Navigator.pushReplacementNamed(context, Routes.dashboard);
        }
      }
    }on FirebaseAuthException catch(e){
      SnackBar snackBar=SnackBar(content: Text("Error!! ${e.message}",style: TextStyle(color: Colors.white,fontSize: 18),),backgroundColor: Colors.red[900],);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(e);
    }


  }

  logout(BuildContext context)async{
    try{
      await auth.signOut();
      Navigator.pushReplacementNamed(context, Routes.login);

    }catch(e){
      print(e);
    }
  }
}


