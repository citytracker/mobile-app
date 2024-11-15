import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:minhacidademeuproblema/core/utils/utils.dart';
import 'package:minhacidademeuproblema/core/utils/utils_views.dart';
import 'package:minhacidademeuproblema/domain/data/problem.dart';
import 'package:minhacidademeuproblema/services/auth_user.dart';
import 'package:minhacidademeuproblema/services/service_problem.dart';
import 'package:minhacidademeuproblema/widgets/WButton.dart';
import 'package:minhacidademeuproblema/widgets/loading.dart';

class PageProblemForm extends StatefulWidget {
  const PageProblemForm({super.key});

  @override
  State<PageProblemForm> createState() => _PageProblemFormState();
}

class _PageProblemFormState extends State<PageProblemForm> {
  LatLng? _value;

  TextEditingController _descricaoController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  ServiceProblem _service = ServiceProblem();

  String? base64Image = null;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (ModalRoute.of(context) != null) {
        var args = ModalRoute.of(context)!.settings.arguments;
        if (args is LatLng) {
          setState(() {
            _value = args as LatLng;
          });
        }
      }

      if (_value == null) {
        if (Navigator.canPop(context))
          Navigator.pop(context);
        else
          Navigator.pushNamed(context, "/");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo problema"),
      ),
      body: _value == null
          ? Center(
              child: Loading(),
            )
          : Form(
              child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(children: [
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length <= 10) {
                            return "Informe uma descrição válida!";
                          }
                        },
                        controller: _descricaoController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.account_circle),
                          hintText: 'Descricao',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    SizedBox(
                      width: 350,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.length <= 10) {
                            return "Informe uma descrição válida!";
                          }
                        },
                        readOnly: true,
                        controller: _dateController,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.account_circle),
                          hintText: 'Data',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                        onTap: () async {
                          var pickedDate = await showDatePicker(
                            context: context,
                            currentDate: _dateController.text == ""
                                ? DateTime.now()
                                : Utils()
                                    .convertStringToDate(_dateController.text),
                            initialEntryMode: DatePickerEntryMode.calendarOnly,
                            initialDate: _dateController.text == ""
                                ? DateTime.now()
                                : Utils()
                                    .convertStringToDate(_dateController.text),
                            firstDate:
                                DateTime.now().add(const Duration(days: -365)),
                            lastDate: DateTime(2030),
                          );

                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('dd/MM/yyyy').format(pickedDate);

                            setState(() {
                              _dateController.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },
                        keyboardType: TextInputType.text,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    TextButton(
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();

                          final XFile? image = await picker.pickImage(
                              source: ImageSource.gallery);

                          if (image != null) {
                            var bytes = await image.readAsBytes();
                            var base64File = base64.encode(bytes);
                            print(base64File);
                            setState(() {
                              base64Image = base64File;
                            });
                          }
                        },
                        child: Text("Adicione fotos")),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    if (base64Image != null)
                      Image.memory(
                        base64Decode(base64Image!),
                        width: 200,
                        height: 200,
                      ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    WButton(
                        text: "Salvar",
                        onPressed: () async {
                          if (base64Image == null) {
                            UtilView.showError(context, "Insira uma imagem");
                            return;
                          }
                          var date =
                              _dateController.text.split("/").reversed.join("");
                          var result = await _service.create(Problem(
                              date: date,
                              descricao: _descricaoController.text,
                              lat: _value!.latitude,
                              log: _value!.longitude,
                              user: GetIt.I<AuthUser>().getUser()!.email,
                              base64: base64Image!));

                          if (result.success) {
                            await UtilView.showSuccess(
                                context, "Problema inserido com sucesso!");
                            Navigator.pushNamed(context, "/");
                          } else {
                            UtilView.showError(context, result.mensagem);
                          }
                        })
                  ]),
                ],
              ),
            )),
    );
  }
}
