import 'package:minhacidademeuproblema/core/result.dart';
import 'package:minhacidademeuproblema/domain/data/problem.dart';
import 'package:minhacidademeuproblema/repository/db_store.dart';

class ServiceProblem {
  late DBStore _dbStore;

  ServiceProblem() {
    _dbStore = DBStore();
  }

  Future<Result> create(Problem problem) async {
    var result = await _dbStore.insert(Problem.toName(), problem);
    if (!result.success) {
      return Result.failed(result.mensagem);
    }

    return Result.sucesso;
  }

  Future<List<Problem>> getProblems() async {
    var result = await _dbStore.read(Problem.toName());
    if (!result.success) return List.empty();

    var list = result.result!.map((e) => Problem.fromTable(e));
    return list.toList();
  }
}
