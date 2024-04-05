import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:transkriptor/core/errors/failures.dart';
import 'package:transkriptor/core/extensions/time_formate_ex.dart';
import 'package:transkriptor/core/usecases/usecase.dart';
import 'package:transkriptor/features/transkriper/domain/entities/transkript_intities.dart';
import 'package:transkriptor/features/transkriper/domain/use_cases/create_transkript_usecase.dart';
import 'package:transkriptor/features/transkriper/domain/use_cases/get_transkripts_usecase.dart';
import 'package:transkriptor/features/transkriper/domain/use_cases/insert_transkript_usecase.dart';
import 'package:transkriptor/features/transkriper/presentation/blocs/state.dart';

class TranskripBloc extends Cubit<TranskriptState> {
  final CreateTranskriptUsecase transkript;
  final InsertTranskrikptUsecase insert;
  final GetTranskriptsUseCase getTranskriptsUseCase;
  TranskripBloc(  {required this.insert, required this.transkript, required this.getTranskriptsUseCase,}) : super(InitState());

  createTranskript(String path) async {
    emit(Loading());
    final result = await transkript(path);
    result.fold((left) {
      if (left is ServerFailure) {
        emit(ErrorState('Error On Server'));
      } else if (left is NoInternetFailure)
        emit(ErrorState('No Enternet'));
      else {
        emit(ErrorState('Unkown Error'));
      }
    }, (value) async {
      emit(Loaded(value));
      await _insertTranskriptToLocal(value);
    });
  }

  Future<void> _insertTranskriptToLocal(String text) async {
    final result = await insert
        .call(Transkript(text: text, timeStamp: DateTime.now().formattedDate));
    result.fold((left) {
      log(left.toString());
      emit(state);
    }, (right) {
       log('right');
      emit(state);
    });
  }

  Future<void> getTranskripts()async{
  
    final result=await getTranskriptsUseCase.call(NoPrams());
    result.fold((left) {
   if (left is CacheFailure) {
        emit(ErrorState('Error On Database'));
      } 
      else {
        emit(ErrorState('Unkown Error'));
      }
    }, (right) {log(right.toString());
      emit(Loaded(right));
    });
  }
}
