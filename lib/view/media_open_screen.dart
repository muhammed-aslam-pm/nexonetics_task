import 'package:flutter/material.dart';

class MediaOpenScreen extends StatelessWidget {
  const MediaOpenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onVerticalDragCancel: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("cancel")));
          },
          onVerticalDragEnd: (details) {
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text("end")));
            showModalBottomSheet(
              context: context,
              builder: (context) => Container(
                height: 100,
              ),
            );
          },
          child: Image.network(
            "https://www.bing.com/th?id=ORES.MMS_2fe0cde68c7abb2aea260d32b73cdb3f",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
