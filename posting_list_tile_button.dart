import 'package:flutter/material.dart';

class PostingListTileButton extends StatelessWidget {
  const PostingListTileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 11.8,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add),
          Text(
            "Create a listing",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
            ),
        ],
      ),
    );
  }
}