import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:minhacidademeuproblema/core/utils/HexColor.dart';
import 'package:minhacidademeuproblema/domain/data/users.dart';
import 'package:minhacidademeuproblema/services/auth_user.dart';
import 'package:minhacidademeuproblema/widgets/WButton.dart';

class PageInicial extends StatefulWidget {
  const PageInicial({super.key});

  @override
  State<PageInicial> createState() => _PageInicialState();
}

class _PageInicialState extends State<PageInicial> {
  Users? _user;
  bool isLogged = false;

  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration.zero, () {
      verifyUser();
    });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    verifyUser();
  }

  @override
  void didUpdateWidget(covariant PageInicial oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    verifyUser();
  }

  verifyUser() {
    print("Verificando");
    setState(() {
      if (GetIt.I<AuthUser>().isLogged()) {
        _user = GetIt.I<AuthUser>().getUser();
        isLogged = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerscaffoldkey,
      appBar: AppBar(
          leading: const Text(''),
          backgroundColor:
              HexColor.fromHex(Colors.blue.toHex()).withOpacity(0.1)),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.0, 0.5, 0.7, 0.9],
            colors: [
              HexColor.fromHex(Colors.blue.toHex()).withOpacity(0.1),
              HexColor.fromHex(Colors.blue.toHex()).withOpacity(0.1),
              HexColor.fromHex(Colors.blue.toHex()).withOpacity(0.3),
              HexColor.fromHex(Colors.blue.toHex()).withOpacity(0.5),
            ],
          ),
        ),
        child: Column(
          children: [
            const Text(
              'Minha Cidade!\nMeu Problema!',
              style: TextStyle(fontSize: 24),
            ),
            Image.asset(
              'assets/logo.png',
            ),
            const Padding(padding: EdgeInsets.only(bottom: 40)),
            const Text(
              'powered by Pedro & Diego',
              style: TextStyle(fontSize: 14),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 80)),
            if (isLogged) Text('Seja bem vindo, ${_user!.nome}'),
            if (!isLogged) const Text('Seja bem vindo'),
            const Padding(padding: EdgeInsets.only(top: 50)),
            WButton(
              text: 'Acessar menu',
              onPressed: () {
                _drawerscaffoldkey.currentState!.openDrawer();
              },
            )
          ],
        ),
      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Card(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    const Icon(
                      Icons.account_circle,
                      size: 50,
                      color: Colors.white,
                    ),
                    if (isLogged)
                      Text(
                        "Acesso: ${_user!.nome}",
                        softWrap: true,
                        style: const TextStyle(color: Colors.white),
                      ),
                  ]),
            ),
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.map),
                Padding(padding: EdgeInsets.only(right: 5)),
                Text('Mapa problemas')
              ],
            ),
            onTap: () {
              Navigator.pushNamed(context, "/map");
            },
          ),
          Visibility(
            visible: isLogged,
            child: ListTile(
              title: const Row(
                children: [
                  Icon(Icons.report_problem),
                  Padding(padding: EdgeInsets.only(right: 5)),
                  Text('Inserir problemas')
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, "/problema");
              },
            ),
          ),
          Visibility(
            visible: !isLogged,
            child: ListTile(
              title: const Row(
                children: [
                  Icon(Icons.login),
                  Padding(padding: EdgeInsets.only(right: 5)),
                  Text('Login')
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, "/login");
              },
            ),
          ),
          Visibility(
            visible: isLogged,
            child: ListTile(
              title: const Row(
                children: [
                  Icon(Icons.logout),
                  Padding(padding: EdgeInsets.only(right: 5)),
                  Text('Sair')
                ],
              ),
              onTap: () {
                setState(() {
                  GetIt.I<AuthUser>().logout();
                  isLogged = false;
                  _user = null;
                });
              },
            ),
          ),
        ],
      )),
    );
  }
}
