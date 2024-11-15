class Result<T> {
  bool success;
  String mensagem;
  T? result;

  Result({this.success = true, this.mensagem = "", this.result});

  static Result get sucesso => Result(success: true);

  factory Result.sucessoWithObject(T value) =>
      Result(success: true, result: value);

  factory Result.failed(String error) =>
      Result(success: false, mensagem: error);
}
