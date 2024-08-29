import 'package:baiti_residential_services/model/app_constants.dart';
import 'package:baiti_residential_services/model/posting_model.dart';
import 'package:baiti_residential_services/view/widgets/calender_ui.dart';
import 'package:baiti_residential_services/view/widgets/posting_list_tile_ui.dart';
import 'package:flutter/material.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsScreen>
 {
  List<DateTime> _bookedDates = [];
  List<DateTime> _allBookedDates = [];
  PostingModel? _selectedPosting;

  List<DateTime> _getSelectedDates()
  {
    return [];
  }

   _selectDate(DateTime date)
  {

  }
  
   _selectAPosting(PostingModel posting)

  {
    _selectedPosting = posting;

    _bookedDates = posting.getAllBookedDates();
    
    
    setState(() {
      
    });
  }

  _clearSelectedPosting()
  {
    _bookedDates = _allBookedDates;
    _selectedPosting = null;

    setState(() {
      
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _bookedDates = AppConstants.currentUser.getAllBookedDates();
    _allBookedDates = AppConstants.currentUser.getAllBookedDates();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25, 25, 25, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
      
            const Row(
             mainAxisSize: MainAxisSize.max,
             mainAxisAlignment: MainAxisAlignment.spaceAround,
             children: <Widget>[
      
              Text('Sun'),
              Text('Mon'),
              Text('Tues'),
              Text('Wed'),
              Text('Thur'),
              Text('Fri'),
              Text('Sat'),
          ],
        ),
      
        Padding(padding: const EdgeInsets.only(top: 15, bottom: 35),
        child: SizedBox(
         height: MediaQuery.of(context).size.height / 1.0,
         child: PageView.builder(
            itemCount: 12,
            itemBuilder: (context, index)
             {
               return CalenderUI(
                monthIndex: index,
                bookedDates: _bookedDates,
                selectDates: _selectDate,
                getSelectedDates: _getSelectedDates,
               );
      
            }
          ),
         ),
        ),
           
      
           //reset
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 25, 0, 25),
           child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
      
              const Text(
                'Filter by Listing', 
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
      
              MaterialButton(
                onPressed: ()
                {
                  _clearSelectedPosting();
                },
                child: const Text(
                  'Reset',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  ),
                 ), 
                ),
      
                Padding(padding: const EdgeInsets.only(top: 25, bottom: 25),
                child: Container(),
                ),
      
            ],
           ),     
          ),
      
            //hosts display the listings
            ListView.builder(
              shrinkWrap: true,
              itemCount: AppConstants.currentUser.myPostings!.length,
              itemBuilder: (context, index) {
               return Padding(
                padding: const EdgeInsets.only(bottom: 26.0),
                child: InkResponse(
                  onTap: ()
                  {
                    _selectAPosting(AppConstants.currentUser.myPostings![index]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _selectedPosting == AppConstants.currentUser.myPostings![index] ? Colors.yellow : Colors.orange,
                      width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  child: PostingListTileUI(
                    posting: AppConstants.currentUser.myPostings![index],
                  ),
                  ),
                  ),
                 ); 
              }
            ),
             ],
            ),
           ),
      ),
    );
  }
}