import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../../models/profile_model.dart';

abstract class ProfileLocalDatasource {
  Future<List<ProfileModel>> getAllUser(int page);
  Future<ProfileModel> getUserById(int id);
}

class ProfileLocalDatasourceImpl extends ProfileLocalDatasource {
  final HiveInterface hive;

  ProfileLocalDatasourceImpl({required this.hive});

  @override
  Future<List<ProfileModel>> getAllUser(int page) async {
    var box = hive.box("profile_box");

    return box.get("getAllUser");
  }

  @override
  Future<ProfileModel> getUserById(int id) async {
    var box = hive.box("profile_box");

    return box.get("getUser");
  }
}
