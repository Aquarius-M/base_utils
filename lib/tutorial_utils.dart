import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TutorialUtils {
  final BuildContext context;

  TutorialUtils(this.context);

  void showTutorial({
    bool? hideSkip,
    String? skipText,
    Color? bgColor,
    double? opacity,
    double? padding,
    List? keyList,
  }) {
    TutorialCoachMark(
      targets: _createTargets(
        keyList: keyList ?? [],
      ),
      colorShadow: bgColor ?? Colors.red,
      textSkip: skipText ?? "跳过",
      hideSkip: hideSkip ?? false,
      paddingFocus: padding ?? 10,
      opacityShadow: opacity ?? 0.5,
      imageFilter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
      onFinish: () {},
      onClickTarget: (target) {},
      onClickTargetWithTapPosition: (target, tapDetails) {},
      onClickOverlay: (target) {},
      onSkip: () {
        return true;
      },
    ).show(context: context);
  }

  List<TargetFocus> _createTargets({List? keyList, double? radius}) {
    List<TargetFocus> targets = [];

    for (var i in keyList!) {
      targets.add(
        TargetFocus(
          identify: i['id'],
          keyTarget: i['key'],
          shape: ShapeLightFocus.RRect,
          radius: radius ?? 6,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              builder: (context, controller) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      i['content'],
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      );
    }

    return targets;
  }
}
