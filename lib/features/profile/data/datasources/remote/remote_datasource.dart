import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/profile_model.dart';

abstract class ProfileRemoteDataSource {
  Future<List<ProfileModel>> getAllUser(int page);
  Future<ProfileModel> getUserById(int id);
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {
  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    // https://reqres.in/api/users?page=1
    Uri url = Uri.parse("https://reqres.in/api/users?page=$page");
    var response = await http.get(url);

    Map<String, dynamic> dataBody = jsonDecode(response.body);
    List<dynamic> data = dataBody["data"];

    return ProfileModel.fromJsonList(data);
  }

  @override
  Future<ProfileModel> getUserById(int id) async {
    // https://reqres.in/api/users/1
    Uri url = Uri.parse("https://reqres.in/api/users/$id");
    var response = await http.get(url);

    Map<String, dynamic> dataBody = jsonDecode(response.body);
    Map<String, dynamic> data = dataBody["data"];

    return ProfileModel.fromJson(data);
  }
}
