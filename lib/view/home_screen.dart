import 'package:flutter/material.dart';
import 'package:nexonetics_task/controller/controller.dart';
import 'package:nexonetics_task/view/media_open_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gallery"),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
        ),
        itemCount: 20,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MediaOpenScreen()));
          },
          child: Image.network(
            "https://www.bing.com/th?id=ORES.MMS_2fe0cde68c7abb2aea260d32b73cdb3f",
            fit: BoxFit.cover,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.upload),
        onPressed: () {
          Controller().pickImageOrVideo();
        },
      ),
    );
  }
}
