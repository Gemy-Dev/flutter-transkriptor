import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/transkript_intities.dart';

@immutable
abstract class TranskriptState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitState extends TranskriptState {}

class Loading extends TranskriptState {}

class Loaded<T extends Object> extends TranskriptState {

  final T transkript;
  Loaded(this.transkript);

  @override
  List<Object> get props => [transkript];
}


class ErrorState extends TranskriptState {

  final String msgError;
  ErrorState(this.msgError);

  @override
  List<Object> get props => [msgError];
}
