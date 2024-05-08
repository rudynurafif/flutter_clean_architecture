import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../../../core/error/failure.dart';
import '../../domain/entities/profile_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../datasources/local/local_datasource.dart';
import '../datasources/remote/remote_datasource.dart';
import '../models/profile_model.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final ProfileRemoteDataSource profileRemoteDataSource;
  final ProfileLocalDatasource profileLocalDatasource;
  final HiveInterface hive;

  ProfileRepositoryImpl({
    required this.profileRemoteDataSource,
    required this.profileLocalDatasource,
    required this.hive,
  });

  @override
  Future<Either<Failure, List<Profile>>> getAllUser(int page) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        // Network unavailable
        // Ngambil dari lokal
        List<ProfileModel> hasil = await profileLocalDatasource.getAllUser(page);
        return Right(hasil);
      } else {
        // Network available
        // Ambil dari network
        List<ProfileModel> hasil = await profileRemoteDataSource.getAllUser(page);

        // Put last data ke lokal box hive
        var box = Hive.box("profile_box");
        box.put("getAllUser", hasil);
        return Right(hasil);
      }
    } catch (e) {
      return Left(Failure());
    }
  }

  @override
  Future<Either<Failure, Profile>> getUserById(int id) async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

      if (connectivityResult.contains(ConnectivityResult.none)) {
        // Network unavailable
        // Ngambil dari lokal
        ProfileModel hasil = await profileLocalDatasource.getUserById(id);
        return Right(hasil);
      } else {
        // Network available
        // Ambil dari network
        ProfileModel hasil = await profileRemoteDataSource.getUserById(id);

        // Put last data ke lokal box hive
        var box = Hive.box("profile_box");
        box.put("getUser", hasil);
        return Right(hasil);
      }
    } catch (e) {
      return Left(Failure());
    }
  }
}
