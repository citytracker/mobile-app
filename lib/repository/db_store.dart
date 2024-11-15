import 'package:minhacidademeuproblema/core/result.dart';
import 'package:minhacidademeuproblema/domain/data/problem.dart';
import 'package:minhacidademeuproblema/domain/data/users.dart';
import 'package:minhacidademeuproblema/repository/imodel_db.dart';
import 'package:sqflite/sqflite.dart';

class DBStore {
  Future<Database> openDb() async {
    var db = await openDatabase(
      'app.db',
      version: 1,
      onCreate: (db, version) async {
        await db.execute(Users.createTable());
        await db.execute(Problem.createTable());
      },
      onUpgrade: (db, oldVersion, newVersion) {},
    );

    return db;
  }

  closeDb(Database db) async {
    await db.close();
  }

  Future<Result> insert(String table, IModelDB model) async {
    try {
      var db = await openDb();

      db.insert(table, model.toInsert());

      db.close();
      return Result.sucesso;
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  Future<Result<List<Map<String, Object?>>>> read<T extends IModelDB>(
      String table) async {
    try {
      var db = await openDb();

      var result = await db.query(table);

      db.close();

      return Result.sucessoWithObject(result);
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  Future<Result<List<Map<String, Object?>>>> readWithArgs<T extends IModelDB>(
      String table, String idABuscar, String colunaABuscar) async {
    try {
      var db = await openDb();

      var result = await db
          .query(table, where: '$colunaABuscar = ?', whereArgs: [idABuscar]);

      db.close();

      return Result.sucessoWithObject(result);
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  Future<Result> update(String table, IModelDB model) async {
    try {
      var db = await openDb();

      await db.update(table, model.toInsert(), where: 'id = ${model.id}');

      db.close();
      return Result.sucesso;
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  Future<Result> remove(String table, IModelDB model) async {
    try {
      var db = await openDb();

      await db.delete(table, where: 'id = ${model.id}');

      db.close();
      return Result.sucesso;
    } catch (e) {
      return Result.failed(e.toString());
    }
  }

  Future<Result> clear(String table) async {
    try {
      var db = await openDb();

      await db.delete(table);

      db.close();
      return Result.sucesso;
    } catch (e) {
      return Result.failed(e.toString());
    }
  }
}
