abstract class IModelDB {
  int id;

  IModelDB({this.id = 0});

  static String toName() {
    throw Exception("Implements not Found");
  }

  static String createTable() {
    throw Exception("Implements not Found");
  }

  static IModelDB fromTable(Map<String, Object?> result) {
    throw Exception("Implements not Found");
  }

  Map<String, Object> toInsert();
}
