import 'package:minhacidademeuproblema/repository/imodel_db.dart';

class Problem extends IModelDB {
  String descricao;

  double lat;
  double log;

  String date;
  String user;

  String base64;

  Problem(
      {super.id,
      required this.date,
      required this.descricao,
      required this.lat,
      required this.log,
      required this.user,
      required this.base64}) {}

  static String createTable() {
    return "CREATE TABLE ${Problem.toName()} (id INTEGER PRIMARY KEY, descricao TEXT NOT NULL, date TEXT NOT NULL, user TEXT NOT NULL, lat REAL, log REAL, base64 TEXT NOT NULL)";
  }

  static String toName() {
    return "Problem";
  }

  static Problem fromTable(Map<String, Object?> result) {
    return Problem(
        id: int.parse(result['id'].toString()),
        lat: double.parse(result['lat'].toString()),
        log: double.parse(result['log'].toString()),
        user: result['user'].toString(),
        descricao: result['descricao'].toString(),
        date: result['date'].toString(),
        base64: result['base64'].toString());
  }

  @override
  Map<String, Object> toInsert() {
    return {
      "descricao": descricao,
      "user": user,
      "date": date,
      "lat": lat,
      "log": log,
      "base64": base64
    };
  }
}
