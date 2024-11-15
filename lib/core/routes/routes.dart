import 'package:flutter/material.dart';
import 'package:minhacidademeuproblema/pages/page_inicial.dart';
import 'package:minhacidademeuproblema/pages/page_map_problems.dart';

import 'package:minhacidademeuproblema/pages/page_signin.dart';
import 'package:minhacidademeuproblema/pages/page_signup.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> getRoutes(context) {
    return {
      "/": (context) => const PageInicial(),
      "/login": (context) => const PageSignIn(),
      "/cadastro": (context) => const PageSignUp(),
      "/map": (context) => const PageMapProblems(),
    };
  }
}
