import 'package:get_it/get_it.dart';
import 'package:minhacidademeuproblema/domain/data/users.dart';
import 'package:minhacidademeuproblema/services/auth_user.dart';

class GetItCore {
  static void setup() {
    GetIt.I.registerSingleton<AuthUser>(AuthUser());
  }
}
