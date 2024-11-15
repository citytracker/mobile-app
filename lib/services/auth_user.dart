import 'package:minhacidademeuproblema/domain/data/users.dart';

class AuthUser {
  Users? _user;

  void setUser(Users user) {
    _user = user;
  }

  Users? getUser() {
    //TODO: Implement Local Storage User
    return _user;
  }

  bool isLogged() {
    return _user != null;
  }

  void logout() {
    _user = null;
  }
}
