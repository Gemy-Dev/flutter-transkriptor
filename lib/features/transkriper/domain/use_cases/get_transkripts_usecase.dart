import 'package:transkriptor/core/either.dart';
import 'package:transkriptor/core/errors/failures.dart';
import 'package:transkriptor/core/usecases/usecase.dart';
import 'package:transkriptor/features/transkriper/domain/repositories/transkription_repo.dart';

import '../entities/transkript_intities.dart';

class GetTranskriptsUseCase implements UseCase<List<Transkript>,NoPrams>{
  final TranskriptionRepo repo;

  GetTranskriptsUseCase(this.repo);
  
  @override
  Future<Either<Failure, List<Transkript>>> call(NoPrams param)async {
   return await repo.getTranskripts();

  }

}