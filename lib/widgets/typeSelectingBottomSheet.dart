import 'package:flutter/material.dart';
import 'package:nexonetics_task/controller/controller.dart';
import 'package:nexonetics_task/utils/color_constants.dart';
import 'package:nexonetics_task/utils/style_constants.dart';
import 'package:provider/provider.dart';

class TypeSelectingBottomSheet extends StatelessWidget {
  const TypeSelectingBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
              child: InkWell(
            onTap: () => Provider.of<Controller>(context, listen: false)
                .uploadPhoto(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(50)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.image_outlined,
                    color: ColorConstants.colorWhite,
                  ),
                  Text(
                    "Photo",
                    style: StyleConstants.buttonText1,
                  ),
                ],
              ),
            ),
          )),
          const SizedBox(
            width: 20,
          ),
          Expanded(
              child: Expanded(
                  child: InkWell(
            onTap: () =>
                Provider.of<Controller>(context, listen: false).uploadVideo(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                  color: Colors.amber, borderRadius: BorderRadius.circular(50)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(
                    Icons.video_collection_rounded,
                    color: ColorConstants.colorWhite,
                  ),
                  Text(
                    "Video",
                    style: StyleConstants.buttonText1,
                  ),
                ],
              ),
            ),
          )))
        ],
      ),
    );
  }
}
