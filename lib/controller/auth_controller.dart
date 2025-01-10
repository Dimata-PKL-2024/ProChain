import 'package:get/get.dart';

class AuthController extends GetxController {
  final dummyUsers = [
    {'username': 'admin', 'password': '12345'},
    {'username': 'user', 'password': 'password'},
  ];

  bool login(String username, String password) {
    return dummyUsers.any((user) =>
        user['username'] == username && user['password'] == password);
  }
}
