import 'package:baiti_residential_services/model/app_constants.dart';
import 'package:baiti_residential_services/view/hostScreens/create_posting_screen.dart';
import 'package:baiti_residential_services/view/widgets/posting_list_tile_button.dart';
import 'package:baiti_residential_services/view/widgets/posting_list_tile_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MyPostingsScreen extends StatefulWidget {
  const MyPostingsScreen({super.key});

  @override
  State<MyPostingsScreen> createState() => _MyPostingsScreenState();
}

class _MyPostingsScreenState extends State<MyPostingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),

      child: Padding(padding: const EdgeInsets.fromLTRB(26, 0, 26, 26),
     
      child: ListView.builder(
        itemCount: AppConstants.currentUser.myPostings!.length +1,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(26, 0, 26, 26),
      child: InkResponse(
        onTap: ()
       {
         Get.to(CreatePostingScreen(
          posting: (index == AppConstants.currentUser.myPostings!.length) ? null
          : AppConstants.currentUser.myPostings![index],
         ));
       },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
          color: Colors.grey,
          width: 1.2,
        ),
        ),
        child: (index == AppConstants.currentUser.myPostings!.length)
         ? PostingListTileButton()
          : PostingListTileUI(posting: AppConstants.currentUser.myPostings![index]),
      ),
      ),
      );
        },
      ),
    ),
    );
  }
}