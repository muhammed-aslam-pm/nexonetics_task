import 'package:flutter/material.dart';
import 'package:nexonetics_task/utils/color_constants.dart';
import 'package:nexonetics_task/utils/style_constants.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicator: BoxDecoration(
        color: ColorConstants.colorBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      labelStyle: StyleConstants.tabbarSelectedLabel,
      unselectedLabelStyle: StyleConstants.tabbarUnselectedLabel,
      indicatorSize: TabBarIndicatorSize.tab,
      tabs: const [
        Tab(
          text: "Photos",
        ),
        Tab(
          text: "Videos",
        )
      ],
    );
  }
}
