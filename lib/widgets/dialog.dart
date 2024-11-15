import 'package:flutter/material.dart';
import 'package:minhacidademeuproblema/widgets/WButton.dart';

class WDialogStatus {
  Color color;

  WDialogStatus._internal({required this.color});

  factory WDialogStatus.error() => WDialogStatus._internal(color: Colors.red);

  factory WDialogStatus.success() =>
      WDialogStatus._internal(color: Colors.green);
}

class WDialog extends StatefulWidget {
  final String title;
  final String text;
  final String buttonText;

  final WDialogStatus? status;

  final Function onOK;

  const WDialog(
      {super.key,
      this.title = "Atenção",
      this.text = "",
      required this.onOK,
      this.buttonText = "Entendido",
      this.status});

  @override
  State<WDialog> createState() => _WDialogState();
}

class _WDialogState extends State<WDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 5),
            Flexible(
                child: SingleChildScrollView(
                    child: Text(
              widget.text,
              textAlign: TextAlign.center,
            ))),
            const SizedBox(height: 15),
            WButton(
              color: widget.status?.color,
              onPressed: () {
                Navigator.pop(context);
                widget.onOK();
              },
              text: widget.buttonText,
            ),
          ],
        ),
      ),
    );
  }
}
