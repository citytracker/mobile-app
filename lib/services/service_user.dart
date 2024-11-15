import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:minhacidademeuproblema/core/result.dart';
import 'package:minhacidademeuproblema/core/utils/utils.dart';
import 'package:minhacidademeuproblema/domain/data/users.dart';
import 'package:minhacidademeuproblema/repository/db_store.dart';

class ServiceUser {
  late DBStore _dbStore;

  ServiceUser() {
    _dbStore = DBStore();
  }

  Future<Result> create(Users user) async {
    user.pass = Utils.crypto(user.pass);
    return await _dbStore.insert(Users.toName(), user);
  }

  Future<Result<Users>> sign_in(String email, String pass) async {
    var result = await findByEmail(email);

    if (!result.success) {
      return Result.failed(result.mensagem);
    }

    bool isValidPass = Utils.crypto(pass).compareTo(result.result!.pass) == 0;
    if (!isValidPass) {
      return Result.failed("Senha incorreta");
    }

    return Result.sucessoWithObject(result.result!);
  }

  Future<Result<Users>> findByEmail(String email) async {
    var result = await _dbStore.readWithArgs(Users.toName(), email, "email");
    if (!result.success) {
      return Result.failed(result.mensagem);
    }

    if (result.result!.isEmpty) {
      return Result.failed("Usuário não encontrado");
    }

    var user = Users.fromTable(result.result!.first);
    return Result.sucessoWithObject(user);
  }
}
