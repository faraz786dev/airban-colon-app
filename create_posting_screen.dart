
import 'dart:io';

import 'package:baiti_residential_services/global.dart';
import 'package:baiti_residential_services/model/app_constants.dart';
import 'package:baiti_residential_services/model/posting_model.dart';
import 'package:baiti_residential_services/view/guest_home_screen.dart';
import 'package:baiti_residential_services/view/host_home_screen.dart';
import 'package:baiti_residential_services/view/widgets/amenities_ui.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostingScreen extends StatefulWidget
 {

   PostingModel? posting;
  
   CreatePostingScreen({super.key, this.posting,});

  @override
  State<CreatePostingScreen> createState() => _CreatePostingScreenState();
}

class _CreatePostingScreenState extends State<CreatePostingScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _nameTextEditingController = TextEditingController();
  TextEditingController _priceTextEditingController = TextEditingController();
  TextEditingController _descriptionTextEditingController = TextEditingController();
  TextEditingController _addressTextEditingController = TextEditingController();
  TextEditingController _cityTextEditingController = TextEditingController();
  TextEditingController _countryTextEditingController = TextEditingController();
  TextEditingController _amenitiesTextEditingController = TextEditingController();

  final List<String> residenceTypes = [
    'Detached House',
    'Villa',
    'Apartment',
    'Condo',
    'Flat',
    'Town House',
    'Studio',
  ];
  String residenceTypeSelected = "";

  Map<String, int>? _beds;
  Map<String, int>? _bathrooms;

  List<MemoryImage>? _imagesList;

  _selectImageFromGallery(int index) async {
    var imageFilePickedFromGallery = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFilePickedFromGallery != null) {
      MemoryImage imageFileInBytesForm = MemoryImage((File(imageFilePickedFromGallery.path)).readAsBytesSync());

      if (index < 0) {
        _imagesList!.add(imageFileInBytesForm);
      } else {
        _imagesList![index] = imageFileInBytesForm;
      }
      setState(() {});
    }
  }

  initializeValues()
   {
     if(widget.posting == null)
     {
      _nameTextEditingController = TextEditingController(text: "");
      _priceTextEditingController = TextEditingController(text: "");
      _descriptionTextEditingController = TextEditingController(text: "");
      _addressTextEditingController = TextEditingController(text: "");
      _cityTextEditingController = TextEditingController(text: "");
      _countryTextEditingController = TextEditingController(text: "");
      _amenitiesTextEditingController = TextEditingController(text: "");
      residenceTypeSelected = residenceTypes.first;

      _beds = {
       'small': 0,
       'medium': 0,
       'large': 0,
      };
      _bathrooms = {
       'full': 0,
       'half': 0,
     };
      _imagesList = [];
     }
     else
     {
      _nameTextEditingController = TextEditingController(text: widget.posting!.name);
       _priceTextEditingController = TextEditingController(text: widget.posting!.price.toString());
      _descriptionTextEditingController = TextEditingController(text: widget.posting!.description);
      _addressTextEditingController = TextEditingController(text: widget.posting!.address);
      _cityTextEditingController = TextEditingController(text: widget.posting!.city);
      _countryTextEditingController = TextEditingController(text: widget.posting!.country);
      _amenitiesTextEditingController = TextEditingController(text: widget.posting!.getAmenititesString());
      _beds = widget.posting!.beds;
      _bathrooms = widget.posting!.bathrooms;
      _imagesList = widget.posting!.displayImages;
      residenceTypeSelected = widget.posting!.type!;
     }
    
      setState(() {
        
      });
  }

  @override
  void initState() {
    super.initState();
    initializeValues();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange,
                Colors.deepOrangeAccent,
              ],
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(1, 0),
              stops: [0, 1],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: const Text("Create / Update a post"),
        actions: [
          IconButton(
            onPressed: () async
            {
              if(!formKey.currentState!.validate())
              {
                return;
              }
              if(residenceTypeSelected == "")
              {
                return;
              }
              if(_imagesList!.isEmpty)
              {
                return;
              }
           
              postingModel.name = _nameTextEditingController.text;
              postingModel.price = double.parse(_priceTextEditingController.text);
              postingModel.description = _descriptionTextEditingController.text;
              postingModel.address = _addressTextEditingController.text;
              postingModel.city = _cityTextEditingController.text;
              postingModel.country = _countryTextEditingController.text;
              postingModel.amenities = _amenitiesTextEditingController.text.split(",");
              postingModel.type = residenceTypeSelected;
              postingModel.beds = _beds;
              postingModel.bathrooms = _bathrooms;
              postingModel.displayImages = _imagesList;

              postingModel.host = AppConstants.currentUser.createUserFromContact();

              postingModel.setImagesNames();

              //if this is new post or old post
              if(widget.posting == null)
              {
                postingModel.rating = 3.5;
                postingModel.bookings = [];
                postingModel.reviews = [];


             await postingViewModel.addListingInfoToFirestore();

             await postingViewModel.addImagesToFirebaseStorage();

             Get.snackbar("New Listing", "your new listing is uploaded successfully.");

              }
              else
              {
                postingModel.rating = widget.posting!.rating;
                postingModel.bookings = widget.posting!.bookings;
                postingModel.reviews = widget.posting!.reviews;
                postingModel.id = widget.posting!.id;

                for(int i = 0; i < AppConstants.currentUser.myPostings!.length; i++)
                {
                  if(AppConstants.currentUser.myPostings![i].id == postingModel.id)
                  {
                    AppConstants.currentUser.myPostings![i] = postingModel;
                    break;
                  }
                }

                 await postingViewModel.updatePostingInfoToFirestore();

                 Get.snackbar("Update Listing", "your listing is uploaded successfully.");
              }

              postingModel = PostingModel();
             
             Get.to(HostHomeScreen());
            },
            icon: const Icon(Icons.upload),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(26, 26, 26, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Listing name
                      Padding(
                        padding: const EdgeInsets.only(top: 1.0),
                        child: TextFormField(
                          decoration: const InputDecoration(labelText: "Listing name"),
                          style: const TextStyle(
                            fontSize: 25.0,
                          ),
                          controller: _nameTextEditingController,
                          validator: (textInput) {
                            if (textInput!.isEmpty) {
                              return "Please enter a valid name";
                            }
                            return null;
                          },
                        ),
                      ),
                      // Select property type
                      Padding(
                        padding: const EdgeInsets.only(top: 28.0),
                        child: DropdownButton(
                          items: residenceTypes.map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (valueItem) {
                            setState(() {
                              residenceTypeSelected = valueItem.toString();
                            });
                          },
                          isExpanded: true,
                          value: residenceTypeSelected,
                          hint: const Text(
                            "Select property type",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      // Price / night
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(labelText: "Price"),
                                style: const TextStyle(
                                  fontSize: 25.0,
                                ),
                                keyboardType: TextInputType.number,
                                controller: _priceTextEditingController,
                                validator: (text) {
                                  if (text!.isEmpty) {
                                    return "Please enter a valid price";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 10.0, bottom: 10.0),
                              child: Text(
                                "\$ / night",
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Description
                      Padding(
                        padding: const EdgeInsets.only(top: 21.0),
                        child: TextFormField(
                          decoration: const InputDecoration(labelText: "Description"),
                          style: const TextStyle(
                            fontSize: 25.0,
                          ),
                          controller: _descriptionTextEditingController,
                          maxLines: 3,
                          minLines: 1,
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "Please enter a valid description";
                            }
                            return null;
                          },
                        ),
                      ),
                      // Address
                      Padding(
                        padding: const EdgeInsets.all(21.0),
                        child: TextFormField(
                          decoration: const InputDecoration(labelText: "Address"),
                          maxLines: 3,
                          style: const TextStyle(
                            fontSize: 25.0,
                          ),
                          controller: _addressTextEditingController,
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "Please enter a valid address";
                            }
                            return null;
                          },
                        ),
                      ),
                      // Beds
                      const Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: Text(
                          'Beds',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 21, left: 15.0, right: 15.0),
                        child: Column(
                          children: <Widget>[
                            // Twin/single bed
                            AmenitiesUi(
                              type: 'Twin/Single',
                              startVlue: _beds!['small']!,
                              decreaseValue: () {
                                setState(() {
                                  _beds!['small'] = (_beds!['small']! - 1).clamp(0, double.infinity).toInt();
                                });
                              },
                              increaseValue: () {
                                setState(() {
                                  _beds!['small'] = _beds!['small']! + 1;
                                });
                              },
                            ),
                            // Double bed
                            AmenitiesUi(
                              type: 'Double',
                              startVlue: _beds!['medium']!,
                              decreaseValue: () {
                                setState(() {
                                  _beds!['medium'] = (_beds!['medium']! - 1).clamp(0, double.infinity).toInt();
                                });
                              },
                              increaseValue: () {
                                setState(() {
                                  _beds!['medium'] = _beds!['medium']! + 1;
                                });
                              },
                            ),
                            // Queen/king bed
                            AmenitiesUi(
                              type: 'Queen/King',
                              startVlue: _beds!['large']!,
                              decreaseValue: () {
                                setState(() {
                                  _beds!['large'] = (_beds!['large']! - 1).clamp(0, double.infinity).toInt();
                                });
                              },
                              increaseValue: () {
                                setState(() {
                                  _beds!['large'] = _beds!['large']! + 1;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      // Bathrooms
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Bathrooms',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
                        child: Column(
                          children: <Widget>[
                            // Full bathroom
                            AmenitiesUi(
                              type: 'Full',
                              startVlue: _bathrooms!['full']!,
                              decreaseValue: () {
                                setState(() {
                                  _bathrooms!['full'] = (_bathrooms!['full']! - 1).clamp(0, double.infinity).toInt();
                                });
                              },
                              increaseValue: () {
                                setState(() {
                                  _bathrooms!['full'] = _bathrooms!['full']! + 1;
                                });
                              },
                            ),
                            // Half bathroom
                            AmenitiesUi(
                              type: 'Half',
                              startVlue: _bathrooms!['half']!,
                              decreaseValue: () {
                                setState(() {
                                  _bathrooms!['half'] = (_bathrooms!['half']! - 1).clamp(0, double.infinity).toInt();
                                });
                              },
                              increaseValue: () {
                                setState(() {
                                  _bathrooms!['half'] = _bathrooms!['half']! + 1;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      // Extra amenities
                      Padding(
                        padding: const EdgeInsets.all(21.0),
                        child: TextFormField(
                          decoration: const InputDecoration(labelText: "Amenities (comma separated)"),
                          style: const TextStyle(
                            fontSize: 25.0,
                          ),
                          controller: _amenitiesTextEditingController,
                          validator: (text) {
                            if (text!.isEmpty) {
                              return "Please enter valid amenities (comma separated)";
                            }
                            return null;
                          },
                          maxLines: 3,
                          minLines: 1,
                        ),
                      ),
                      // Photos
                      const Padding(
                        padding: EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Photos',
                          style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0, bottom: 25.0),
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: _imagesList!.length + 1,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 25,
                            crossAxisSpacing: 25,
                            childAspectRatio: 3 / 2,
                          ),
                          itemBuilder: (context, index) {
                            if (index == _imagesList!.length) {
                              return IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  _selectImageFromGallery(-1);
                                },
                              );
                            }

                            return MaterialButton(
                              onPressed: () {
                                // Add any action for the image button if needed
                              },
                              child: Image(
                                image: _imagesList![index],
                                fit: BoxFit.fill,
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



