import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String? text;

  const Loading({super.key, this.text});

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
            if (text != null)
              Text(
                text!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            if (text != null) const SizedBox(height: 5),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
