import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:transkriptor/core/either.dart';

import 'package:transkriptor/core/errors/failures.dart';
import 'package:transkriptor/core/extensions/time_formate_ex.dart';
import 'package:transkriptor/core/network/network_info.dart';
import 'package:transkriptor/features/transkriper/data/data_sources/local/local_data_souce.dart';
import 'package:transkriptor/features/transkriper/data/data_sources/remote/remote_data_source.dart';
import 'package:transkriptor/features/transkriper/data/models/transkript_model.dart';

import 'package:transkriptor/features/transkriper/domain/entities/transkript_intities.dart';

import '../../../../core/errors/exceptions.dart';
import '../../domain/repositories/transkription_repo.dart';

class TranskriptionRepoImpl implements TranskriptionRepo {
  final RemoteDataSource source;
  final Connection internet;
  final LocalDatabase database;
  TranskriptionRepoImpl(
      {required this.database, required this.source, required this.internet});
  @override
  Future<Either<Failure, String>> transkript(String path) async {
    if (!(await internet.isConnected())) {
      return Either.left(NoInternetFailure());
    }
    try {
      final result = await source.createTranscription(path);

      return Either.right(result);
    } on ServerException {
      return Either.left(ServerFailure());
    } catch (e) {
      return Either.left(UnkownFailure());
    }
  }

  @override
  Future<Either<Failure, List<Transkript>>> getTranskripts() async {
    try {
      final result = await database.getAll();
      return Either.right(result);
    } on CacheException {
      return Either.left(CacheFailure());
    } catch (e) {
      return Either.left(UnkownFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteTranskript(int index) async {
    return await _helperLocal(database.delete(index));
  }

  @override
  Future<Either<Failure, void>> insert(Transkript transkript) async {
    return await _helperLocal(database.insert(TranskriptModel(
        text: transkript.text, timeStamp: transkript.timeStamp)));
  }









  Future<Either<Failure, void>> _helperLocal(Future op) async {
    try {
      await op;
      return Either.right(null);
    } on CacheException {
      return Either.left(CacheFailure());
    } catch (e) {
      return Either.left(UnkownFailure());
    }
  }
}
