import 'package:flutter/material.dart';
import 'package:minhacidademeuproblema/widgets/dialog.dart';
import 'package:minhacidademeuproblema/widgets/loading.dart';

class UtilView {
  static BuildContext? isLoadingContext;

  static process<T>(BuildContext context, Future<T> Function() exec,
      Function(T) sucess, Function(String) error) {
    showLoading(context);
    try {
      exec().then((value) {
        closeLoading();

        sucess(value);
      });
    } catch (e) {
      closeLoading();
      error("Tivemos um problema ao processar sua consulta. Tente mais tarde!");
    }
  }

  static void showLoading(context, {String text = ""}) {
    isLoadingContext = context;

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Loading(
          text: text,
        );
      },
    );
  }

  static void closeLoading() {
    if (isLoadingContext != null) {
      Navigator.pop(isLoadingContext!);
      isLoadingContext = null;
    }
  }

  static double widthFull(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double heightFull(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static bool isSmallScreen(BuildContext context) {
    return MediaQuery.of(context).size.width < 900;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width > 1200;
  }

  static bool isMediumScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= 600 &&
        MediaQuery.of(context).size.width <= 1200;
  }

  static showError(BuildContext context, String msg) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return WDialog(status: WDialogStatus.error(), text: msg, onOK: () {});
        });
  }

  static showSuccess(BuildContext context, String msg) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return WDialog(
              status: WDialogStatus.success(), text: msg, onOK: () {});
        });
  }
}
