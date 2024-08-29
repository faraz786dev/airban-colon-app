import 'package:baiti_residential_services/model/posting_model.dart';
import 'package:flutter/material.dart';

class PostingListTileUI extends StatefulWidget
 {

  PostingModel? posting;

  PostingListTileUI({super.key, this.posting,});

  @override
  State<PostingListTileUI> createState() => _PostingListTileUIState();
}

class _PostingListTileUIState extends State<PostingListTileUI>
 {
  PostingModel? posting;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    posting = widget.posting;
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListTile(
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            posting!.name!,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
         ),
        ),
       ),

       trailing: AspectRatio(
        aspectRatio: 3/2,
        child: Image(
          image: posting!.displayImages!.first,
          fit: BoxFit.fitWidth,
        ),
        ),
      ),
    );
  }
}