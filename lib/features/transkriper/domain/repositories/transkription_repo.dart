import 'package:transkriptor/core/either.dart';

import '../../../../core/errors/failures.dart';
import '../entities/transkript_intities.dart';

abstract class TranskriptionRepo{
  Future<Either<Failure,String>>transkript(String path);
  Future<Either<Failure,List<Transkript>>>getTranskripts();
  Future<Either<Failure,void>>deleteTranskript(int index);
  Future<Either<Failure,void>>insert(Transkript transkript);
 
}