import 'package:minhacidademeuproblema/repository/imodel_db.dart';

class Users extends IModelDB {
  String nome;
  String email;

  String pass;

  Users(
      {super.id, required this.email, required this.nome, required this.pass});

  static String createTable() {
    return "CREATE TABLE ${Users.toName()} (id INTEGER PRIMARY KEY, nome TEXT NOT NULL, email TEXT NOT NULL, pass TEXT NOT NULL)";
  }

  static String toName() {
    return "Users";
  }

  static Users fromTable(Map<String, Object?> result) {
    return Users(
        id: int.parse(result['id'].toString()),
        nome: result['nome'].toString(),
        email: result['email'].toString(),
        pass: result['pass'].toString());
  }

  @override
  Map<String, Object> toInsert() {
    return {"nome": nome, "email": email, "pass": pass};
  }
}
