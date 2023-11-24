import 'package:flutter/material.dart';

import 'app_info/view.dart';

class InfoUtils {
  static showInfo(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const AppInfoPage(),
      ),
    );
  }

  static String? setProxy(String ip) {
    return "";
  }
}
