import 'package:flutter/material.dart';
import 'package:nexonetics_task/controller/controller.dart';
import 'package:nexonetics_task/view/details_tab.dart';
import 'package:provider/provider.dart';

class PhotoOpenScreen extends StatelessWidget {
  const PhotoOpenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context);
    final PageController pageController =
        PageController(initialPage: controller.selectedIndex);

    return Consumer<Controller>(
      builder: (context, value, child) => PageView.builder(
        itemCount: value.photos.length,
        controller: pageController,
        itemBuilder: (context, index) => GestureDetector(
          onVerticalDragEnd: (details) {
            showModalBottomSheet(
              context: context,
              builder: (context) => DetailesTab(media: value.photos[index]),
            );
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(value.photos[index].title),
            ),
            body: Center(
              child: SizedBox(
                width: double.infinity,
                child: Hero(
                  tag: value.photos[index].url,
                  child: Image.network(
                    value.photos[index].url,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
