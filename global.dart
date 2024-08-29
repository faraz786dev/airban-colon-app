import 'package:baiti_residential_services/model/posting_model.dart';
import 'package:baiti_residential_services/view_model/inbox_view_model.dart';
import 'package:baiti_residential_services/view_model/posting_view_model.dart';
import 'package:baiti_residential_services/view_model/user_view_model.dart';


PostingModel postingModel = PostingModel();

UserViewModel userViewModel = UserViewModel();
PostingViewModel postingViewModel = PostingViewModel();
InboxViewModel inboxViewModel = InboxViewModel();


String paymentResult = "";
double? bookingPrice = 0;
String hostID = "";