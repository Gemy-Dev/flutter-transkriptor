import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:transkriptor/features/transkriper/data/models/transkript_model.dart';

class Transkript extends Equatable{
  final int? id;
  final String text;
  final String timeStamp;

  const Transkript ({ this.id, required this.text, required this.timeStamp});
  
  factory Transkript.fromModel(TranskriptModel model)=>Transkript(id:model.id,  text: model.text, timeStamp: model.timeStamp);
  @override

  List<Object?> get props => [text,timeStamp];
}