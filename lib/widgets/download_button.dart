import 'package:flutter/material.dart';
import 'package:nexonetics_task/utils/color_constants.dart';
import 'package:nexonetics_task/utils/style_constants.dart';

class DownloadButton extends StatelessWidget {
  const DownloadButton({
    super.key,
    this.onTap,
  });
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
            color: ColorConstants.colorGreen,
            borderRadius: BorderRadius.circular(50)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Download",
              style: StyleConstants.buttonText1,
            ),
            Icon(
              Icons.download,
              color: ColorConstants.colorWhite,
            )
          ],
        ),
      ),
    );
  }
}
