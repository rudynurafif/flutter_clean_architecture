import 'package:clean_architecture/features/profile/data/datasources/remote/remote_datasource.dart';

void main() async {
  final ProfileRemoteDataSourceImpl profileRemoteDataSourceImpl = ProfileRemoteDataSourceImpl();

  // var response = await profileRemoteDataSourceImpl.getAllUser(2);

  // for (var element in response) {
  //   print(element.toJson());
  // }

  var response = await profileRemoteDataSourceImpl.getUserById(2);
  print(response.toJson());
}
