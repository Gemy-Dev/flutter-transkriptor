import 'package:transkriptor/core/either.dart';
import 'package:transkriptor/core/errors/failures.dart';
import 'package:transkriptor/core/usecases/usecase.dart';
import 'package:transkriptor/features/transkriper/domain/repositories/transkription_repo.dart';

import '../entities/transkript_intities.dart';

class CreateTranskriptUsecase implements UseCase<String,String>{
  final TranskriptionRepo repo;

  CreateTranskriptUsecase(this.repo);
  @override
  Future<Either<Failure, String>> call(String path)async {
  return await repo.transkript(path);
  }

}