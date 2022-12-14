import 'dart:convert';
import 'dart:developer';
import 'package:homeservice/core/localdisk.repo.dart/disk.repo.dart';
import 'package:homeservice/model/jwt_model.dart';
import 'package:homeservice/model/model.dart';
import 'package:http/http.dart' as http;

class ResgitrationRepo {
  int getstatus = 0;

  Future<JwtModel?> registration(
      {required String username,
      required String email,
      required String password}) async {
    var body = {"username": username, "email": email, "password": password};
    final response = await http.post(
        Uri.parse(
            'https://ehomeservices.herokuapp.com/api/auth/local/register'),
        body: body);
    var data = jsonDecode(response.body);
    print(data);
    getstatus = response.statusCode;

    if (getstatus == 200) {
      JwtModel finalmodel = JwtModel.fromJson(data);
      DiskRepo().save(
          savekey1: finalmodel.jwt,
          savekey2: '',
          getusername: finalmodel.user.username,
          getcode: getstatus,
          id: finalmodel.user.id);
      return finalmodel;
    } else {}
  }

  Future<JwtModel?> login(
      {required String email, required String password}) async {
    var body = {"identifier": email, "password": password};

    final response = await http.post(
        Uri.parse('https://ehomeservices.herokuapp.com/api/auth/local'),
        body: body);
    var data = jsonDecode(response.body);
    getstatus = response.statusCode;
    if (getstatus == 200) {
      JwtModel finalmodel2 = JwtModel.fromJson(data);
      print(finalmodel2);

      DiskRepo().save(
          savekey1: '',
          savekey2: finalmodel2.jwt,
          getusername: finalmodel2.user.username,
          getcode: getstatus,
          id: finalmodel2.user.id);
      return finalmodel2;
    } else {
      DiskRepo().save2(getcode: getstatus);
    }
  }

  Future<List<ItemModel>?> Getdata() async {
    final response = await http.get(Uri.parse(
        'https://ehomeservice-722a5-default-rtdb.asia-southeast1.firebasedatabase.app/ehomeservices3.json'));
    final data = jsonDecode(response.body) as List;
    if (response.statusCode == 200) {
      var users = data.map((e) => ItemModel.fromJson(e)).toList();
      log('Successfully Shown Profile');
      return users;
    } else {
      log('Failed to Getdata.');
    }
  }
}
