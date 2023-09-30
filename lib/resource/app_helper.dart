import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class AppHelper {
  static bool isShowing = false;

  static void showLog(String message) {
    print(message);
  }

  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (Platform.isIOS) {
      if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
        FocusManager.instance.primaryFocus!.unfocus();
      }
    } else if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static bool isValidString(String text) {
    bool isValid = false;
    if (text.isNotEmpty && text.toLowerCase().trim() != 'null') {
      isValid = true;
    }
    return isValid;
  }

}
