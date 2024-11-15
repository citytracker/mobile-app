import 'package:flutter/material.dart';
import 'package:minhacidademeuproblema/core/utils/utils_views.dart';
import 'package:minhacidademeuproblema/domain/data/users.dart';
import 'package:minhacidademeuproblema/services/service_user.dart';
import 'package:minhacidademeuproblema/widgets/WButton.dart';

class PageSignUp extends StatefulWidget {
  const PageSignUp({super.key});

  @override
  State<PageSignUp> createState() => _PageSignUpState();
}

class _PageSignUpState extends State<PageSignUp> {
  ServiceUser _service = ServiceUser();

  TextEditingController _nomeController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _passConfirmController = TextEditingController();

  bool isPassVisible = false;
  bool isPassConfirmVisible = false;

  GlobalKey<FormState> _form = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cadastros")),
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
                    controller: _nomeController,
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
                        return "Informe um email válido!";
                      }

                      final bool emailValid =
                          RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$")
                              .hasMatch(value);
                      if (!emailValid) {
                        return "E-mail mal inserido!";
                      }
                    },
                    controller: _emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.account_circle),
                      hintText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                    keyboardType: TextInputType.emailAddress,
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
                SizedBox(
                  width: 350,
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Informe uma senha válida!";
                      }
                    },
                    controller: _passConfirmController,
                    obscureText: !isPassConfirmVisible,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.account_circle),
                      hintText: 'Confirme sua senha',
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      suffixIcon: isPassConfirmVisible
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  isPassConfirmVisible = false;
                                });
                              },
                              icon: const Icon(Icons.visibility))
                          : IconButton(
                              onPressed: () {
                                setState(() {
                                  isPassConfirmVisible = true;
                                });
                              },
                              icon: const Icon(Icons.visibility_off)),
                    ),
                    keyboardType: TextInputType.text,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                WButton(
                    text: 'Cadastrar',
                    onPressed: () {
                      if (_form.currentState!.validate()) {
                        if (_passController.text
                                .compareTo(_passConfirmController.text) !=
                            0) {
                          UtilView.showError(context, "Senhas não são iguais");
                          return;
                        }

                        Users _user = Users(
                            email: _emailController.text,
                            nome: _nomeController.text,
                            pass: _passConfirmController.text);
                        UtilView.process(context, () => _service.create(_user),
                            (p0) async {
                          if (p0.success) {
                            await UtilView.showSuccess(
                                context, "Usuário criado com sucesso!");
                            Navigator.pop(context);
                          } else {
                            await UtilView.showError(context, p0.mensagem);
                          }
                        }, (p0) async {
                          await UtilView.showError(context, p0);
                        });
                      }
                    }),
              ]),
            ],
          )),
    );
  }
}
