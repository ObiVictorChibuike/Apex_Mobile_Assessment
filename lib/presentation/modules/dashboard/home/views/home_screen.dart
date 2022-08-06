import 'package:assessment/presentation/modules/auth/login/view/login.dart';
import 'package:assessment/presentation/modules/dashboard/home/controller/controller.dart';
import 'package:assessment/presentation/modules/dashboard/see_all_transaction/views/all_transaction_views.dart';
import 'package:assessment/presentation/modules/dashboard/view_all_account/views/all_auth_accounts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import '../../../../../app/constants/app_string/strings.dart';
import '../../../../../app/shared_widget/button_widget.dart';
import '../../../../../app/shared_widget/cutom_formfield_widget.dart';
import '../../../../../app/shared_widget/empty_screen.dart';
import '../../../../../app/shared_widget/error_screen.dart';
import '../../../../../app/shared_widget/loading_screen.dart';
import '../../../../../app/utils/asset_path.dart';
import '../../../../../app/utils/flush_bar_loader.dart';
import '../../../../../app/utils/loading_dialog.dart';
import '../../../../../app/utils/validator.dart';
import '../../../../../core/state/view_state.dart';
import '../../../../../data/local/local_storage.dart';
import '../widgets/carousel_widget.dart';
import '../widgets/transaction_tile.dart';
import 'package:carousel_slider/carousel_slider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


void withdrawal(BuildContext context, HomeScreenController controller)async{
  if(controller.formKeyTransaction.currentState!.validate()){
    controller.formKeyTransaction.currentState!.save();
    ProgressDialogHelper().loadingState;
    await controller.withdrawal();
    if(controller.viewState.state == ResponseState.COMPLETE){
      ProgressDialogHelper().loadStateTerminated;
      Get.offAll(()=> const HomeScreen());
      FlushBarHelper(context,"Withdrawal Successful").showSuccessBar;
    }else if(controller.viewState.state == ResponseState.ERROR){
      ProgressDialogHelper().loadStateTerminated;
      FlushBarHelper(context, controller.errorMessage == Strings.emptyString ? Strings.internalServerError : controller.errorMessage).showErrorBar;
    }
  }
}


Widget _buildTransactionView(BuildContext context, HomeScreenController homeScreenController) {
  switch (homeScreenController.viewState.state) {
    case ResponseState.LOADING:
      return const LoadingScreen(loadingMessage: "Loading Transactions...",);
    case ResponseState.COMPLETE:
      final items = homeScreenController.viewState.data!.data ?? List.empty();
      final scrollController = ScrollController();
      return Card(
        child: Container(height: MediaQuery.of(context).size.height / 3, width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25,),
                Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      controller: scrollController,
                      child: Column(
                        children: [
                          ...List.generate(items.length > 3 ? 3 : items.length, (index){
                            final format = NumberFormat("#,##0", "en_US");
                            String date = Jiffy(items[index].created).yMMMMd;
                            return TransactionTile(padding: 0.0,
                              image:  SvgPicture.asset(AssetPath.transIcon, theme: const SvgTheme(fontSize: 25),),
                              title: Text(items[index].type!, overflow: TextOverflow.fade, maxLines: 1,
                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14, fontWeight: FontWeight.w500,)),
                              subTitle: Text(date,  overflow: TextOverflow.fade, maxLines: 1,
                                  style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.black45)),
                              amount: Text("N ${items[index].amount!.toString()}",  overflow: TextOverflow.fade, maxLines: 1,
                                style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14, fontWeight: FontWeight.w700,),),
                            );
                          }),
                        ],
                      ),
                    )
                ),
              ]
          ),
        ),
      );
    case ResponseState.ERROR:
      return const ErrorScreen();
    case ResponseState.EMPTY:
      return const EmptyScreen();
  }
}


void showTransferBottomSheet(BuildContext context, HomeScreenController homeScreenController){
  Get.bottomSheet(
    FractionallySizedBox(
      heightFactor: 0.5,
      child: Container(
        decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height/1.8,),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Container(height: 5, width: 50,
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5),),),
            const SizedBox(height: 30,),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Form(
                        key: homeScreenController.formKeyTransaction,
                        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(alignment: Alignment.centerLeft,
                              child: Text("Transfer",
                                style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 24, fontWeight: FontWeight.w700 ),),
                            ),
                            Text("Please enter your PhoneNumber and Amount to proceed",
                              style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14 ),),
                            const SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child:  FormFieldWidget(
                                controller: homeScreenController.withdrawalPhoneNumberController,
                                hintText: "Phone Number",
                                validator: Validator.isPhone,
                              ),
                            ),
                            const SizedBox(height: 40,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child:  FormFieldWidget(
                                keyboardType: TextInputType.phone,
                                controller: homeScreenController.withdrawalAmountController,
                                hintText: "Amount",
                                validator: (v) {
                                  if(v!.isEmpty){
                                    return "Please enter Amount";
                                  }else {
                                    return null;
                                  }},
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height / 20,),
                            ButtonWidget(
                              onPressed: (){
                                withdrawal(context, homeScreenController);
                              },
                              buttonText: "Transfer Funds", height: 48, width: double.maxFinite, buttonColor: Colors.blue,
                            ),
                          ],
                        ),
                      )
                    ]
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
    ),
    isScrollControlled: true,
  );
}


void showWithdrawalBottomSheet(BuildContext context, HomeScreenController homeScreenController){
  Get.bottomSheet(
    FractionallySizedBox(
      heightFactor: 0.5,
      child: Container(
        decoration: const BoxDecoration(color: Colors.white,borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height/1.8,),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
        child: Column(
          children: [
            const SizedBox(height: 10,),
            Container(height: 5, width: 50,
              decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(5),),),
            const SizedBox(height: 30,),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      Form(
                        key: homeScreenController.formKeyTransaction,
                        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(alignment: Alignment.centerLeft,
                              child: Text("Withdraw",
                                style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 24, fontWeight: FontWeight.w700 ),),
                            ),
                            Text("Please enter your PhoneNumber and Amount to proceed",
                              style: Theme.of(context).textTheme.bodyText2?.copyWith(fontSize: 14 ),),
                            const SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child:  FormFieldWidget(
                                controller: homeScreenController.withdrawalPhoneNumberController,
                                hintText: "Phone Number",
                                validator: Validator.isPhone,
                              ),
                            ),
                            const SizedBox(height: 40,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child:  FormFieldWidget(
                                keyboardType: TextInputType.phone,
                                controller: homeScreenController.withdrawalAmountController,
                                hintText: "Amount",
                                validator: (v) {
                                  if(v!.isEmpty){
                                    return "Please enter Amount";
                                  }else {
                                    return null;
                                  }},
                              ),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height / 20,),
                            ButtonWidget(
                                onPressed: (){
                                  withdrawal(context, homeScreenController);
                                },
                                buttonText: "Withdraw Funds", height: 48, width: double.maxFinite, buttonColor: Colors.blue,
                            ),
                          ],
                        ),
                      )
                    ]
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
    ),
    isScrollControlled: true,
  );
}


_showAlertDialog(BuildContext context) {
  Widget cancelButton = TextButton(
    child: const Text("No", style: TextStyle(color: Colors.blue)),
    onPressed:  () {
      Get.back();
    },
  );
  Widget continueButton = TextButton(
    child: const Text("Yes", style: TextStyle(color: Colors.blue),),
    onPressed:  () async {
      Get.put<LocalCachedData>(await LocalCachedData.create());
      await LocalCachedData.instance.cacheLoginStatus(isLoggedIn: false);
      Get.back();
      Get.offUntil(GetPageRoute(page: ()=> const LoginScreen()), (Route<dynamic> route) => false);
    },
  );

  AlertDialog alert = AlertDialog(
    content: const Text("Are you sure"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

int carouselCurrentIndex = 0;


class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    const defaultImageUrl = "https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png";
    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(elevation: 0.0, backgroundColor: Colors.white,),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Welcome,", style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.w700, fontSize: 28)),
                      Row(
                        children: [
                          IconButton(onPressed: (){
                            _showAlertDialog(context);
                          }, icon: const Icon(Icons.power_settings_new_outlined, color: Colors.red,)),
                          Container(height: 48, width: 48,
                            decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(0.15),
                                image: const DecorationImage(image: NetworkImage(defaultImageUrl),
                                  fit: BoxFit.cover,
                                )
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.all(20), decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.blue),
                    child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Account Balance", style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 15, color: Colors.white),),
                            GestureDetector(onTap: (){
                              Get.to(()=> const ViewAllAuthAccount());
                            },
                              child: Text("View all Auth Account",
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 15, color: Colors.white,
                                    decoration: TextDecoration.underline),),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(controller.amountToggle == true ?"N10,000,000.00," : "************", style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700),),
                            IconButton(onPressed: (){
                              controller.toggleAmount();
                            }, icon: controller.amountToggle == true ? const Icon(Icons.visibility, color: Colors.blueGrey,) :
                            const Icon(Icons.visibility_off_outlined, color: Colors.blueGrey,))
                          ],
                        ),
                        const SizedBox(height: 20,),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                showWithdrawalBottomSheet(context, controller);
                              },
                              child: Container(
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15,),
                                child: Text("Withdraw", style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                showTransferBottomSheet(context, controller);
                              },
                              child: Container(
                                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15,),
                                child: Text("Transfer", style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Transactions", style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400),),
                      GestureDetector(onTap: (){
                        Get.to(()=> const AllTransactionViews());
                      },
                          child: Text("See all", style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.grey, fontSize: 15, fontWeight: FontWeight.w400),)),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  _buildTransactionView(context, controller),
                  SizedBox(
                      height: MediaQuery.of(context).size.height / 8,
                      child: CarouselSlider(
                          options: CarouselOptions(
                              scrollDirection: Axis.vertical,
                              height: MediaQuery.of(context).size.height/8,
                              viewportFraction: 1.0,
                              enlargeCenterPage: false,
                              autoPlay: true,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  carouselCurrentIndex = index;
                                });
                              }
                          ),
                          items: List.generate(controller.carouselHeadings.length, (index){
                            final items = controller.carouselHeadings;
                            return CarouselWidget(
                              imagePath: items[index]["image_path"],
                              title: items[index]["title"],
                              message: items[index]["message"],
                              children: [
                                ...items.map((x) {
                                  int index = items.indexOf(x);
                                  return Container(
                                    height: 12, width: 12,
                                    decoration: BoxDecoration(shape: BoxShape.circle,
                                      color: carouselCurrentIndex == index ? const Color(0xFF70B2E2): const Color(0xFFD3EDFF),
                                    ),
                                  );
                                }).toList(),
                              ],
                            );
                          })
                      )
                  ),
                ],
              ),
            ),
          )
      );
    });
  }
}
