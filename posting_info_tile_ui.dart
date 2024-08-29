import 'package:flutter/material.dart';

class PostingInfoTileUI extends StatefulWidget
 {
  IconData? iconData;
  String? category;
  String? categoryInfo;

  PostingInfoTileUI({super.key, this.iconData, this.category, this.categoryInfo});

  @override
  State<PostingInfoTileUI> createState() => _PostingInfoTileUIState();
}

class _PostingInfoTileUIState extends State<PostingInfoTileUI> {
  @override
  Widget build(BuildContext context)
   {
    return ListTile(
      leading: Icon(
        widget.iconData,
        size: 30,
        ),

        title: Text(
          widget.category!,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        subtitle: Text(
          widget.categoryInfo!,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
    );
  }
}