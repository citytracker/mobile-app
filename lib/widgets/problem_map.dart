import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:minhacidademeuproblema/core/utils/utils.dart';
import 'package:minhacidademeuproblema/domain/data/problem.dart';

class ProblemMap extends StatelessWidget {
  ProblemMap({super.key, required this.problem});

  Problem problem;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: 300,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Icon(Icons.account_circle),
              Padding(padding: EdgeInsets.only(right: 5)),
              Text(problem.user.split("@").first)
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 20)),
          Text(
            Utils().dateToStringFormat(problem.date),
            style: const TextStyle(fontSize: 10),
          ),
          Text(problem.descricao),
          Image.memory(
            base64Decode(problem.base64),
            fit: BoxFit.fitWidth,
            width: 200,
          ),
        ]),
      ),
    );
  }
}
