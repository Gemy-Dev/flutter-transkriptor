import 'package:get_it/get_it.dart';
import 'package:transkriptor/core/network/network_info.dart';
import 'package:transkriptor/features/transkriper/data/data_sources/local/local_data_souce.dart';
import 'package:transkriptor/features/transkriper/data/data_sources/remote/remote_data_source.dart';
import 'package:transkriptor/features/transkriper/data/repositories_impl/transkription_repo_impl.dart';
import 'package:transkriptor/features/transkriper/domain/repositories/transkription_repo.dart';
import 'package:transkriptor/features/transkriper/domain/use_cases/create_transkript_usecase.dart';
import 'package:transkriptor/features/transkriper/domain/use_cases/get_transkripts_usecase.dart';
import 'package:transkriptor/features/transkriper/domain/use_cases/insert_transkript_usecase.dart';
import 'package:transkriptor/features/transkriper/presentation/blocs/bloc.dart';

final sl=GetIt.instance;
Future<void>init()async{
  sl.registerFactory(() => TranskripBloc(insert: sl(), transkript: sl(), getTranskriptsUseCase: sl()));
  sl.registerLazySingleton(() => CreateTranskriptUsecase(sl()));
  sl.registerLazySingleton(() => InsertTranskrikptUsecase(sl()));
  sl.registerLazySingleton(() => GetTranskriptsUseCase(sl()));
  sl.registerLazySingleton<TranskriptionRepo>(() => TranskriptionRepoImpl(database:  sl(), source:sl() ,internet:sl() ));
  sl.registerLazySingleton<Connection>(() => InternetChecker());
  sl.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl());
  sl.registerLazySingleton<LocalDatabase>(() => LocalDatabaseImpl());

}