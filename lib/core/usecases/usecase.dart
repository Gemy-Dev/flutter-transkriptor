import 'package:equatable/equatable.dart';

import '../either.dart';
import '../errors/failures.dart';

abstract class UseCase<Type,Params>{
Future<Either<Failure,Type>>call(Params param);

}

class NoPrams extends Equatable{
  @override
  List<Object?> get props => [];

}