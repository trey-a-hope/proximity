import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

abstract class Modal {
  void showInSnackBar(
      {@required GlobalKey<ScaffoldState> scaffoldKey,
      @required String message});
  void showAlert(
      {@required BuildContext context,
      @required String title,
      @required String message});
  Future<bool> showConfirmation(
      {@required BuildContext context,
      @required String title,
      @required String message});
}

class ModalImplementation extends Modal {
  final GetIt getIt = GetIt.I;

  @override
  void showInSnackBar(
      {@required GlobalKey<ScaffoldState> scaffoldKey,
      @required String message}) {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  void showAlert(
      {@required BuildContext context,
      @required String title,
      @required String message}) {
    showDialog(
      context: context,
      builder: (BuildContext buildContext) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

 

  @override
  Future<bool> showConfirmation(
      {@required BuildContext context,
      @required String title,
      @required String message}) {
    return showDialog<bool>(
      barrierDismissible: false,
      context: context,
      child: AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
          FlatButton(
            child: const Text('NO', style: TextStyle(color: Colors.black)),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          FlatButton(
            child: const Text('YES', style: TextStyle(color: Colors.black)),
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          )
        ],
      ),
    );
  }
}
