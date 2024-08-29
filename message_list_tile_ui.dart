import 'package:baiti_residential_services/model/app_constants.dart';
import 'package:baiti_residential_services/model/message_model.dart';
import 'package:flutter/material.dart';

class MessageListTileUI extends StatelessWidget
 {
  MessageModel? message;
  MessageListTileUI({super.key, this.message,});

  @override
  Widget build(BuildContext context)
   {
    if(message!.sender!.firstName == AppConstants.currentUser.firstName)
    {
       return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 36, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          
         

         Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 11),
            child: Container(
                   padding: const EdgeInsets.all(15),
                   decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.pink,
                        Colors.green,
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 0.0],
                      tileMode: TileMode.clamp,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                            message!.text!,
                            style: const TextStyle(
                              fontSize: 20.0
                            ),
                            textWidthBasis: TextWidthBasis.parent,
                          ),
                          ),

                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              message!.getMessageDateTime(),
                              style: const TextStyle(
                                fontSize: 15
                              ),
                            ),
                          ),


                        ],
                      ),
                   ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      
                    },
                    child: CircleAvatar(
                      backgroundImage: AppConstants.currentUser.displayImage,
                      radius: MediaQuery.of(context).size.width / 20,
                      ),
                  ),
                ),


          ],
         ),
       );
    }

    else
    {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 36, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          
          GestureDetector(
            onTap: () {
              
            },
            child: CircleAvatar(
              backgroundImage: message!.sender!.displayImage,
              radius: MediaQuery.of(context).size.width / 20,
            ),
          ),


         Flexible(
          child: Padding(
            padding: const EdgeInsets.only(left: 11),
            child: Container(
                   padding: const EdgeInsets.all(15),
                   decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Colors.orange,
                        Colors.yellow,
                      ],
                      begin: FractionalOffset(0.0, 0.0),
                      end: FractionalOffset(1.0, 0.0),
                      stops: [0.0, 0.0],
                      tileMode: TileMode.clamp,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [


                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text(
                            message!.text!,
                            style: const TextStyle(
                              fontSize: 20.0
                            ),
                            textWidthBasis: TextWidthBasis.parent,
                          ),
                          ),

                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              message!.getMessageDateTime(),
                              style: const TextStyle(
                                fontSize: 15
                              ),
                            ),
                          ),


                        ],
                      ),
                   ),
                  ),
                ),


          ],
         ),
       );
     }
   
  }
}