import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:tect_ggf/model/user_model.dart';

class UserService {
  String url = 'https://65046156c8869921ae24f38f.mockapi.io/api/Users';
  Dio dio = Dio();

  Future<Either<String, List<UserModel>>> fetchDataUser() async {
    try {
      final response = await dio.get(url,
          options: Options(headers: {'Accept': 'aplication/json'}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        List<UserModel> users =
            List<UserModel>.from(data.map((user) => UserModel.fromJson(user)));

        return Right(users);
      }
      return Left("Failed Get Data User");
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<String, UserModel>> addDataUser(
      {required UserModel request}) async {
    try {
      final response = await dio.post(url,
          data: request.toJson(),
          options: Options(headers: {'Accept': 'aplication/json'}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        var user = UserModel.fromJson(data);
        return Right(user);
      }
      return Left("Failed Add Data User");
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<String, UserModel>> updateDataUser(
      {required UserModel request}) async {
    try {
      final response = await dio.put('$url/${request.id}',
          data: request.toJson(),
          options: Options(headers: {'Accept': 'aplication/json'}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        var user = UserModel.fromJson(data);
        return Right(user);
      }
      return Left("Failed Update Data User User");
    } catch (e) {
      rethrow;
    }
  }

  Future<Either<String, UserModel>> deleteDataUser(
      {required UserModel request}) async {
    try {
      final response = await dio.delete('$url/${request.id}',
          options: Options(headers: {'Accept': 'aplication/json'}));

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        var user = UserModel.fromJson(data);
        return Right(user);
      }
      return Left("Failed Delete Data User User");
    } catch (e) {
      rethrow;
    }
  }
}
