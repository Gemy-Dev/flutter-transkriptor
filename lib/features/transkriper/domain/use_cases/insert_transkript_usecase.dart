import 'package:transkriptor/core/either.dart';
import 'package:transkriptor/core/errors/failures.dart';
import 'package:transkriptor/core/usecases/usecase.dart';
import 'package:transkriptor/features/transkriper/domain/entities/transkript_intities.dart';
import 'package:transkriptor/features/transkriper/domain/repositories/transkription_repo.dart';

class InsertTranskrikptUsecase implements UseCase<void,Transkript>{
  final TranskriptionRepo repo;

  InsertTranskrikptUsecase(this.repo);
  @override
  Future<Either<Failure, void>> call(Transkript transkript)async {
  return await repo.insert(transkript) ;
  }
}