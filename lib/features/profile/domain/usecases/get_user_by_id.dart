import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/profile_entity.dart';
import '../repositories/profile_repository.dart';

class GetUserById {
  final ProfileRepository profileRepository;

  const GetUserById(this.profileRepository);

  Future<Either<Failure, Profile>> execute(int id) async {
    return await profileRepository.getUserById(id);
  }
}
