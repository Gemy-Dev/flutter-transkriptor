// ignore_for_file: overridden_fields

import 'package:transkriptor/features/transkriper/data/data_sources/local/local_data_souce.dart';
import 'package:transkriptor/features/transkriper/domain/entities/transkript_intities.dart';

class TranskriptModel extends Transkript{


  
  const TranskriptModel({ int? id,  required String text,required String timeStamp}) : super(id:id, text: text, timeStamp: timeStamp);

  factory TranskriptModel.fromJson(Map<String,dynamic>json)=>TranskriptModel(id:json[columnId], text: json[columnText], timeStamp:json [columnTime]);
  Map<String,dynamic>toMap()=>{
    columnText:text,
    columnTime:timeStamp
  };


}