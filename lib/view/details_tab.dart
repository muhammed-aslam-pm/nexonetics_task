import 'package:flutter/material.dart';
import 'package:nexonetics_task/utils/color_constants.dart';
import 'package:nexonetics_task/widgets/download_button.dart';

import '../utils/style_constants.dart';

class DetailesTab extends StatelessWidget {
  const DetailesTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const gap = SizedBox(height: 20);
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: ColorConstants.colorGrey,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: DownloadButton(
                    onTap: () {},
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete_outline,
                      color: ColorConstants.colorRed,
                    ),
                  ),
                ),
              ),
            ],
          ),
          gap,
          Container(
            height: 1,
            width: double.infinity,
            color: ColorConstants.colorGrey,
          ),
          gap,
          Text(
            "Details",
            style: StyleConstants.title1,
          ),
          gap,
          Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: Center(
                    child: Icon(
                      Icons.image_outlined,
                      color: ColorConstants.colorGrey,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Screenshot 2024",
                      style: StyleConstants.description1,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
          gap,
          Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: Center(
                    child: Icon(
                      Icons.calendar_month,
                      color: ColorConstants.colorGrey,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Thu, 14 Mar, 2024 . 2:29 pm",
                      style: StyleConstants.description1,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ],
          ),
          gap,
          Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox(
                  child: Center(
                    child: Icon(
                      Icons.article_outlined,
                      color: ColorConstants.colorGrey,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "27.2 MB",
                      style: StyleConstants.description1,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
