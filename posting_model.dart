import 'package:baiti_residential_services/global.dart';
import 'package:baiti_residential_services/model/app_constants.dart';
import 'package:baiti_residential_services/model/booking_model.dart';
import 'package:baiti_residential_services/model/contact_model.dart';
import 'package:baiti_residential_services/model/review_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PostingModel
{
  String? id;
  String? name;
  String? type;
  double? price;
  String? description;
  String? address;
  String? city;
  String? country;
  double? rating;



  ContactModel? host;


  List<String>? imageNames;
  List<MemoryImage>? displayImages;
  List<String>? amenities;

  Map<String, int>? beds;
  Map<String, int>? bathrooms;

  List<BookingModel>? bookings;
  List<ReviewModel>? reviews;

  PostingModel({this.id = "", this.name="", this.type="", this.price=0, this.description="",
   this.address="", this.city="", this.country="", this.host})
  {
    displayImages = [];
    amenities = [];

    beds = {};
    bathrooms = {};
    rating = 0;

    bookings = [];
    reviews = [];
  }

  setImagesNames()
  {
    imageNames = [];
    for(int i = 0; i < displayImages!.length; i++)
    {
      imageNames!.add("image${i}.png");
    }
  }

  getPostingInfoFromFirestore() async
  {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('postings').doc(id).get();
    getPostingInfoFromSnapshot(snapshot);

  }
  getPostingInfoFromSnapshot(DocumentSnapshot snapshot)
  {
    address = snapshot['address'] ?? "";
    amenities = List<String>.from(snapshot['amenities']) ?? [];
    bathrooms = Map<String,int>.from(snapshot['bathrooms']) ?? {};
    beds = Map<String,int>.from(snapshot['beds']) ?? {};
    city = snapshot['city'] ??"";
    country = snapshot['country'] ??"";
    description = snapshot['description'] ??"";

    String hostID = snapshot['hostID'] ??"";
    host = ContactModel(id: hostID);

    imageNames = List<String>.from(snapshot['imageNames']) ?? [];
    name = snapshot['name'] ??"";
    price = snapshot['price'].toDouble() ?? 0.0;
    rating = snapshot['rating'].toDouble() ?? 2.5;
    type = snapshot['type'] ?? "";


  }

  getAllImagesFromStorage() async
  {
    displayImages = [];
    for(int i = 0; i < imageNames!.length; i++)
    {
      final imageData = await FirebaseStorage.instance.ref()
        .child("postingImages").child(id!)
        .child(imageNames![i])
        .getData(1024*1024);

    displayImages!.add(MemoryImage(imageData!));
  }
  return displayImages;
 }
 getFirstImageFromStorage() async
 {
  if(displayImages!.isNotEmpty)
  {
    return displayImages!.first;
  }
final imageData = await FirebaseStorage.instance.ref()
        .child("postingImages").child(id!)
        .child(imageNames!.first)
        .getData(1024*1024);

     displayImages!.add(MemoryImage(imageData!));

     return displayImages!.first;

 }

  getAmenititesString()
  {
  if(amenities!.isEmpty)
  {
    return "";
  }
  String amenitiesString = amenities.toString();

  return amenitiesString.substring(1, amenitiesString.length-1);
 }

 double getCurrentRating()
 {
  if(reviews!.length == 0)
  {
    return 4;
  }
  double rating = 0;
  reviews!.forEach((review)
  {
    rating +=  review.rating!;
  });

  rating /=  reviews!.length;
  return rating;

 }

 getHostFromFirestore() async
 {
  await host!.getContactInfoFromFirestore();
  await host!.getImageFromStorage();
 }

 int getGuestsNumber()
 {
  int? numGuests = 0;

  numGuests = numGuests + beds!['small']!;
  numGuests = numGuests + beds!['medium']! *2;
  numGuests = numGuests + beds!['large']! *2;

  return numGuests;

 }
 String getBedroomText()
 {
  String text = "";
  if(this.beds!["small"] !=0)
  {
    text = text + beds!["small"].toString() + "single/twin";

  }

  if(this.beds!["medium"] !=0)
  {
    text = text + beds!["medium"].toString() + "double";

  }

  if(this.beds!["large"] !=0)
  {
    text = text + this.beds!["large"].toString() + "queen/king";

  }
  return text;

 }
 String getBathroomText()
 {
  String text = "";
  if(bathrooms!["full"] != 0)
  {
    text = text + bathrooms!["full"].toString() + "full";
  }
  if(bathrooms!["half"] != 0)
  {
    text = text + bathrooms!["half"].toString() + "half";
  }
  return text;
 }
 String getFullAddress()
 {
  return address! + ", " + city! + ", " + country!;
 }

 getAllBookingsFromFirestore() async
 {
  bookings = [];
  QuerySnapshot snapshots = await FirebaseFirestore.instance.collection('postings')
  .doc(id).collection('bookings').get();

  for(var snapshot in snapshots.docs)
  {
    BookingModel newBooking = BookingModel();
    await newBooking.getBookingInfoFromFirestoreFromPosting(this, snapshot);

    bookings!.add(newBooking);
  }
 }

 List<DateTime> getAllBookedDates()
 {
  List<DateTime> dates = [];
  bookings!.forEach((booking)
  {
    dates.addAll(booking.dates!);
  }
  );
  return dates;
 }
 Future<void> makeNewBooking(List<DateTime> dates, context, hostID) async
 {
   Map<String, dynamic> bookingData = {
    'dates' : dates,
    'name' : AppConstants.currentUser.getFullNameOfUser(),
    'userID' : AppConstants.currentUser.id,
    'payment' : bookingPrice,

   };

   DocumentReference reference = await FirebaseFirestore.instance.collection('postings')
   .doc(id).collection('bookings').add(bookingData);

   BookingModel newBooking = BookingModel();

   newBooking.createBooking(this,AppConstants.currentUser.createUserFromContact(),dates);
   newBooking.id = reference.id;

   bookings!.add(newBooking);
   await AppConstants.currentUser.addBookingToFirestore(newBooking, bookingPrice!, hostID);

   Get.snackbar("Listing", "Booked successfully");
 }
   
}
