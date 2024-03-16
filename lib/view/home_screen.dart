import 'package:flutter/material.dart';
import 'package:nexonetics_task/controller/controller.dart';
import 'package:nexonetics_task/view/media_open_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<Controller>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gallery"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemCount: controller.images.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Provider.of<Controller>(context, listen: false).open(index);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MediaOpenScreen()));
          },
          child: Image.network(
            controller.images[index],
            fit: BoxFit.cover,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.upload),
        onPressed: () {
          Controller().pickImageOrVideo();
        },
      ),
    );
  }
}
