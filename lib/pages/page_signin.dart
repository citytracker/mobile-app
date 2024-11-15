import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minhacidademeuproblema/core/utils/utils.dart';
import 'package:minhacidademeuproblema/core/utils/utils_views.dart';
import 'package:minhacidademeuproblema/services/auth_user.dart';
import 'package:minhacidademeuproblema/services/service_user.dart';
import 'package:minhacidademeuproblema/widgets/WButton.dart';

class PageSignIn extends StatefulWidget {
  const PageSignIn({super.key});

  @override
  State<PageSignIn> createState() => _PageSignInState();
}

class _PageSignInState extends State<PageSignIn> {
  GlobalKey<FormState> _form = GlobalKey();
  TextEditingController _loginController = TextEditingController();

  TextEditingController _passController = TextEditingController();

  bool isPassVisible = false;

  ServiceUser _service = ServiceUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Form(
          key: _form,
          autovalidateMode: AutovalidateMode.always,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Padding(padding: EdgeInsets.only(top: 16)),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Informe um usuário válido!";
                      }
                    },
                    controller: _loginController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.account_circle),
                      hintText: 'Usuário',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Informe uma senha válida!";
                      }
                    },
                    controller: _passController,
                    obscureText: !isPassVisible,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.account_circle),
                      hintText: 'Senha',
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      suffixIcon: isPassVisible
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  isPassVisible = false;
                                });
                              },
                              icon: const Icon(Icons.visibility))
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  isPassVisible = true;
                                });
                              },
                              icon: const Icon(Icons.visibility_off)),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                WButton(
                    text: 'Acessar',
                    onPressed: () async {
                      if (_form.currentState!.validate()) {
                        var result = await _service.sign_in(
                            _loginController.text, _passController.text);

                        if (result.success) {
                          GetIt.I<AuthUser>().setUser(result.result!);
                          Navigator.pushNamedAndRemoveUntil(
                              context, "/", (route) => true);
                        } else {
                          UtilView.showError(context, result.mensagem);
                        }
                      }
                    }),
                const Padding(padding: EdgeInsets.only(top: 10)),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/cadastro");
                    },
                    child: const Text("Primeiro acesso? Registre-se"))
              ]),
            ],
          )),
    );
  }
}
