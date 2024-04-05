import 'package:flutter/material.dart';
import 'package:transkriptor/features/transkriper/domain/entities/transkript_intities.dart';
import 'package:transkriptor/features/transkriper/presentation/pages/main_screen.dart';
import 'package:transkriptor/features/transkriper/presentation/pages/view_transkript.dart';

import '../../features/transkriper/presentation/pages/home_screen.dart';
 const home='/';
 const viewTranskript='viewTranskript';
class Routs {
// static const home='/';
// static const home='/';

Route<dynamic>?  onGenerateRoute(RouteSettings settings){
 switch (settings.name) {
 case home: return MaterialPageRoute(builder: (_)=>const MainScreen());
 
 case viewTranskript:{
  final data=settings.arguments as Transkript;
  return MaterialPageRoute(builder: (_)=> ViewTranskript(text: data.text, time: data.timeStamp,));
 } 
 }
 return MaterialPageRoute(builder: (_)=>const MainScreen());
}}