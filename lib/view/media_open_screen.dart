import 'package:flutter/material.dart';
import 'package:nexonetics_task/controller/controller.dart';
import 'package:nexonetics_task/view/details_tab.dart';
import 'package:provider/provider.dart';

class MediaOpenScreen extends StatelessWidget {
  const MediaOpenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context);
    final PageController pageController =
        PageController(initialPage: controller.selectedIndex);

    return PageView.builder(
      itemCount: controller.images.length,
      controller: pageController,
      itemBuilder: (context, index) => GestureDetector(
        onVerticalDragEnd: (details) {
          showModalBottomSheet(
            context: context,
            builder: (context) => const DetailesTab(),
          );
        },
        child: Scaffold(
          body: Center(
            child: Image.network(
              controller.images[index],
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
