import 'package:get/get.dart';

class OnBoardingController extends GetxController{

  int currentIndex = 0;


String? changeOnBoardingHeaderIndex(){
  if(currentIndex == 0){
    return "Finance app the safest \nand most trusted";
  }else if(currentIndex == 1){
    return "The fastest transaction \nprocess only here";
  }
  return null;
}

String? changeOnBoardingMessageIndex(){
  if (currentIndex == 0){
    return "Your finance work starts here. Our here to help \nyou track and deal with speeding up your \ntransactions.";
  }else if(currentIndex == 1){
    return "Get easy to pay all your bills with just a few \nsteps. Paying your bills become fast and \nefficient.";
  }
  return null;
}

}