import 'package:flutter/material.dart';
import 'package:flutter_floating/floating/assist/floating_slide_type.dart';
import 'package:flutter_floating/floating/floating.dart';
import 'package:flutter_floating/floating/manager/floating_manager.dart';

import 'app_info/view.dart';

class InfoUtils {
  static showInfo(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const AppInfoPage(),
      ),
    );
  }

  static void createDevFloating(
    BuildContext context, {
    required Widget content,
    bool? withOpen,
  }) {
    // 初始化dev悬浮窗
    Floating floating = Floating(
      content,
      slideType: FloatingSlideType.onRightAndBottom,
      isShowLog: false,
      moveOpacity: 1.0,
      slideTopHeight: MediaQuery.of(context).padding.top,
      slideBottomHeight: MediaQuery.of(context).padding.bottom + kBottomNavigationBarHeight,
      right: 10,
      snapToEdgeSpace: 10,
      bottom: MediaQuery.of(context).padding.bottom + kBottomNavigationBarHeight,
    );

    if (withOpen!) {
      floatingManager.createFloating("dev_info", floating).open(context);
    } else {
      floatingManager.createFloating("dev_info", floating);
    }
  }

  static closeDevFloating() {
    floatingManager.closeFloating("dev_info");
  }

  static String? setProxy(String ip) {
    return "";
  }
}
