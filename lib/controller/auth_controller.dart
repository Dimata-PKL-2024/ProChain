import 'package:get/get.dart';

class AuthController extends GetxController {
  var username = ''.obs;  // Menggunakan string kosong sebagai nilai default

  final dummyUsers = [
    {'username': 'admin', 'password': '12345'},
    {'username': 'user', 'password': 'password'},
  ];

  bool login(String username, String password) {
    final user = dummyUsers.firstWhere(
        (user) => user['username'] == username && user['password'] == password,
        orElse: () => {});
    if (user.isNotEmpty) {
      this.username.value = user['username'] ?? '';  // Gunakan fallback empty string jika null
      return true;
    }
    return false;
  }
}
