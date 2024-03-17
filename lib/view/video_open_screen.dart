import 'package:flutter/material.dart';
import 'package:nexonetics_task/model/media_item_model.dart';
import 'package:nexonetics_task/view/details_tab.dart';
import 'package:video_player/video_player.dart';

class ViedoPlayScreen extends StatefulWidget {
  const ViedoPlayScreen({super.key, required this.video});
  final MediaItemModel video;
  @override
  State<ViedoPlayScreen> createState() => _ViedoPlayScreenState();
}

class _ViedoPlayScreenState extends State<ViedoPlayScreen> {
  late final VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.video.url));
    _controller.initialize().then((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.video.title),
      ),
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          showModalBottomSheet(
            context: context,
            builder: (context) => DetailesTab(media: widget.video),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Center(
                  child: _controller.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : const CircularProgressIndicator(),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                        setState(() {});
                      } else {
                        _controller.play();
                        setState(() {});
                      }
                    },
                    child: Icon(_controller.value.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow))
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
