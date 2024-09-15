import 'package:ylp/main.dart';
import 'package:ylp/pages/Signup.dart';
import 'package:ylp/pages/constituency.dart';
import 'package:ylp/pages/createaccount.dart';
import 'package:ylp/pages/htmltest.dart';
import 'package:ylp/pages/membership.dart';
import 'package:ylp/pages/regions.dart';
import 'package:ylp/pages/titles.dart';

class Routes{
  static String login="login";
  static String membership="membership";
  static String dashboard="dashboard";
  static String createaccount="createaccount";
  static String html_data="ghana";
  static String titles="titles";
  static String regions="regions";
  static String constituency="constituency";

}

final pages={
  Routes.login:(context)=>const Signup(),
  Routes.membership:(context)=>const Leadership(),
  Routes.dashboard:(context)=>const MyHomePage(),
  Routes.createaccount:(context)=>const CreateAccount(),
  Routes.html_data:(context)=> Htmlapi(),
  Routes.titles:(context)=> Apptitle(),
  Routes.regions:(context)=> RegionList(),
  Routes.constituency:(context)=> Constituency(),
};