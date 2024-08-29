// import 'dart:io';
// import 'package:baiti_residential_services/model/app_constants.dart';
// import 'package:baiti_residential_services/model/user_model.dart';
// import 'package:baiti_residential_services/view/guestScreens/account_screen.dart';
// import 'package:baiti_residential_services/view/guest_home_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';


// class UserViewModel
// {
//     UserModel userModel = UserModel();

//   signUp(email, password, firstName, lastName, city, country, bio, imageFileOfUser) async
//   {
//      Get.snackbar("Please waite", "we are creating account for you.");

//    try
//    {
//      await FirebaseAuth.instance.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//       ).then((result) async
//       {
//         String currentUserID = result.user!.uid;

//           AppConstants.currentUser.id = currentUserID;
//           AppConstants.currentUser.firstName = firstName;
//           AppConstants.currentUser.lastName = lastName;
//           AppConstants.currentUser.city = city;
//           AppConstants.currentUser.country = country;
//           AppConstants.currentUser.bio = bio;
//           AppConstants.currentUser.email = email;
//           AppConstants.currentUser.password = password;

//          await saveUserToFirestore(bio, city, country, email, firstName, lastName, currentUserID)
//          .whenComplete(() async
//          {
//           await addImageToFirebaseStorage(imageFileOfUser, currentUserID);
//          });
//         Get.to(GuestHomeScreen());
//          Get.snackbar("Congratulation", "Your account has been created");
      
//       });
//    }
//    catch(e)
//    {
//     Get.snackbar("Error", e.toString());
//    }
//   }
  
//   Future<void> saveUserToFirestore(bio, city, country, email, firstName, lastName, id) async
//   {
//     Map<String, dynamic> dataMap = 
//     {
//       "bio": bio,
//       "city": city,
//       "country": country,
//       "email": email,
//       "firstName": firstName,
//       "lastName": lastName,
//       "isHost": false,
//       "myPostingIDs": [],
//       "savePostingIDs": [],
//       "earnings": 0,
//     };
//     await FirebaseFirestore.instance.collection("users").doc(id).set(dataMap);
// }
//  addImageToFirebaseStorage(File imageFileOfUser, currentUserID) async
//  {
//   Reference referenceStorage = FirebaseStorage.instance.ref()
//   .child("userImages")
//   .child(currentUserID)
//   .child(currentUserID + ".png");

//   await referenceStorage.putFile(imageFileOfUser).whenComplete((){});

//   AppConstants.currentUser.displayImage = MemoryImage(imageFileOfUser.readAsBytesSync());
//  }

//  login(email, password) async
//  {
//   Get.snackbar("Please wait", "checking your credentials....");
//   try
//   {
//     FirebaseAuth.instance.signInWithEmailAndPassword(
//       email: email, 
//       password: password,
//       ).then((result) async
//       {
//         String currentUserID = result.user!.uid;
//         AppConstants.currentUser.id = currentUserID;
      
//       await getUserInfoFromFirestore(currentUserID); 
//       await getImageFromStorage(currentUserID);

//       Get.snackbar("Logged-In", "you are logged-in successful.");
//       Get.to(GuestHomeScreen()); 
//       });
//   }
//   catch(e)
//    {
//     Get.snackbar("Error", e.toString());
//    }
//  }

//  getUserInfoFromFirestore(userID) async
//  {
//   DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(userID).get();

//   AppConstants.currentUser.snapshot = snapshot;
//   AppConstants.currentUser.firstName = snapshot["firstName"] ?? "";
//   AppConstants.currentUser.lastName = snapshot['lastName'] ?? "";
//   AppConstants.currentUser.email = snapshot['email'] ?? "";
//   AppConstants.currentUser.bio = snapshot['bio'] ?? "";
//   AppConstants.currentUser.city = snapshot['city'] ?? "";
//   AppConstants.currentUser.country = snapshot['country'] ?? "";
//   AppConstants.currentUser.isHost = snapshot['isHost'] ?? false;

//  }

//  getImageFromStorage(userID) async
//  {
//   if(AppConstants.currentUser.displayImage != null)
//   {
//     return AppConstants.currentUser.displayImage;
//   }
//   final imageDataInBytes = await FirebaseStorage.instance.ref()
//   .child("userImages")
//   .child(userID)
//   .child(userID + ".png")
//   .getData(1024 * 1024);

//   return AppConstants.currentUser.displayImage;
//  }

//  becomeHost(String userID) async
//  {

//   userModel.isHost = true;
//   Map<String, dynamic> dataMap = 
//   {
//     "isHost": true,
//   };
//   await FirebaseFirestore.instance.collection("users").doc(userID).update(dataMap);
//  }
//  modifyCurrentlyHosting(bool isHosting)
//  {
//   userModel.isCurrentlyHosting = isHosting;
//  }
// }


// gpt code below




import 'dart:io';
import 'package:baiti_residential_services/model/app_constants.dart';
import 'package:baiti_residential_services/model/user_model.dart';
import 'package:baiti_residential_services/view/guestScreens/account_screen.dart';
import 'package:baiti_residential_services/view/guest_home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserViewModel {
  UserModel userModel = UserModel();

  Future<void> signUp(String email, String password, String firstName, String lastName, String city, String country, String bio, File imageFileOfUser) async {
    Get.snackbar("Please wait", "We are creating an account for you.");

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      ).then((result) async {
        String currentUserID = result.user!.uid;

        AppConstants.currentUser.id = currentUserID;
        AppConstants.currentUser.firstName = firstName;
        AppConstants.currentUser.lastName = lastName;
        AppConstants.currentUser.city = city;
        AppConstants.currentUser.country = country;
        AppConstants.currentUser.bio = bio;
        AppConstants.currentUser.email = email;
        AppConstants.currentUser.password = password;

        await saveUserToFirestore(bio, city, country, email, firstName, lastName, currentUserID)
            .whenComplete(() async {
          await addImageToFirebaseStorage(imageFileOfUser, currentUserID);
        });

        Get.to(const GuestHomeScreen());
        Get.snackbar("Congratulations", "Your account has been created");
      });
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> saveUserToFirestore(String bio, String city, String country, String email, String firstName, String lastName, String id) async {
    Map<String, dynamic> dataMap = {
      "bio": bio,
      "city": city,
      "country": country,
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "isHost": false,
      "myPostingIDs": [],
      "savePostingIDs": [],
      "earnings": 0,
    };
    await FirebaseFirestore.instance.collection("users").doc(id).set(dataMap);
  }

  Future<void> addImageToFirebaseStorage(File imageFileOfUser, String currentUserID) async {
    Reference referenceStorage = FirebaseStorage.instance.ref()
        .child("userImages")
        .child(currentUserID)
        .child("$currentUserID.png");

    await referenceStorage.putFile(imageFileOfUser).whenComplete(() {});

    AppConstants.currentUser.displayImage = MemoryImage(imageFileOfUser.readAsBytesSync());
  }

  Future<void> login(String email, String password) async {
    Get.snackbar("Please wait", "Checking your credentials....");
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      ).then((result) async {
        String currentUserID = result.user!.uid;
        AppConstants.currentUser.id = currentUserID;

        await getUserInfoFromFirestore(currentUserID);
        await getImageFromStorage(currentUserID);
        await AppConstants.currentUser.getMyPostingsFromFirestore();

        Get.snackbar("Logged-In", "You are logged in successfully.");
        Get.to(const GuestHomeScreen());
      });
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Future<void> getUserInfoFromFirestore(String userID) async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('users').doc(userID).get();

    AppConstants.currentUser.snapshot = snapshot;
    AppConstants.currentUser.firstName = snapshot["firstName"] ?? "";
    AppConstants.currentUser.lastName = snapshot['lastName'] ?? "";
    AppConstants.currentUser.email = snapshot['email'] ?? "";
    AppConstants.currentUser.bio = snapshot['bio'] ?? "";
    AppConstants.currentUser.city = snapshot['city'] ?? "";
    AppConstants.currentUser.country = snapshot['country'] ?? "";
    AppConstants.currentUser.isHost = snapshot['isHost'] ?? false;
  }

  Future<MemoryImage?> getImageFromStorage(String userID) async {
    if (AppConstants.currentUser.displayImage != null) {
      return AppConstants.currentUser.displayImage;
    }
    final imageDataInBytes = await FirebaseStorage.instance.ref()
        .child("userImages")
        .child(userID)
        .child("$userID.png")
        .getData(1024 * 1024);

    if (imageDataInBytes != null) {
      AppConstants.currentUser.displayImage = MemoryImage(imageDataInBytes);
      return AppConstants.currentUser.displayImage;
    }

    return null;
  }

  Future<void> becomeHost(String userID) async {
    userModel.isHost = true;
    Map<String, dynamic> dataMap = {
      "isHost": true,
    };
    await FirebaseFirestore.instance.collection("users").doc(userID).update(dataMap);
  }

  void modifyCurrentlyHosting(bool isHosting) {
    userModel.isCurrentlyHosting = isHosting;
  }
}
