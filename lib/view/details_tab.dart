// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nexonetics_task/controller/controller.dart';
import 'package:nexonetics_task/model/media_item_model.dart';
import 'package:nexonetics_task/utils/color_constants.dart';
import 'package:nexonetics_task/widgets/download_button.dart';
import 'package:provider/provider.dart';
import '../utils/style_constants.dart';

class DetailesTab extends StatelessWidget {
  const DetailesTab({
    super.key,
    required this.media,
  });
  final MediaItemModel media;

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
                  //------------------------------------------------------------download button
                  child: DownloadButton(
                    onTap: () {
                      Provider.of<Controller>(context, listen: false)
                          .launchURL(media.url);
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  //------------------------------------------------------------delete button
                  child: IconButton(
                    onPressed: media.type == "photo"
                        ? () {
                            Provider.of<Controller>(context, listen: false)
                                .deletePhoto(context: context, id: media.id!);
                          }
                        : () async {
                            await Provider.of<Controller>(context,
                                    listen: false)
                                .deleteVideo(context: context, id: media.id!);
                            Navigator.pop(context);
                          },
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
          //--------------------------------------------------------------------Other Detailes
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
                      media.title,
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
                      DateFormat('E, d MMM, y . h:mm a').format(media.date),
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
                      media.size,
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
