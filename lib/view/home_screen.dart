import 'package:flutter/material.dart';
import 'package:nexonetics_task/controller/controller.dart';
import 'package:nexonetics_task/view/photo_open_screen.dart';
import 'package:nexonetics_task/view/video_open_screen.dart';
import 'package:nexonetics_task/widgets/custom_tabbar.dart';
import 'package:nexonetics_task/widgets/typeSelectingBottomSheet.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<Controller>(context, listen: false).fetchMedias();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Gallery"),
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              //----------------------------------------------------------------Tab bar
              child: CustomTabBar(),
            ),
            Expanded(
              child: TabBarView(children: [
                //--------------------------------------------------------------Photos Section
                Consumer<Controller>(
                  builder: (context, value, child) => value.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : value.photos.isEmpty
                          ? const Center(
                              child: Text("No Media Available"),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(10),
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                ),
                                itemCount: value.photos.length,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    Provider.of<Controller>(context,
                                            listen: false)
                                        .open(index);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PhotoOpenScreen()));
                                  },
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
                //--------------------------------------------------------------Videos Section
                Consumer<Controller>(
                  builder: (context, value, child) => value.loading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : value.videos.isEmpty
                          ? const Center(
                              child: Text("No Videos Available"),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(10),
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 5,
                                ),
                                itemCount: value.videos.length,
                                itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ViedoPlayScreen(
                                          video: value.videos[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: value.videos[index].url,
                                    child: value.thumbnails[index],
                                  ),
                                ),
                              ),
                            ),
                )
              ]),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.upload),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => const TypeSelectingBottomSheet(),
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
