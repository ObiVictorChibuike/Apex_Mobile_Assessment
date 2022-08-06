import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app/shared_widget/empty_screen.dart';
import '../../home/controller/controller.dart';

class ViewAllAuthAccount extends StatelessWidget {
  const ViewAllAuthAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(onPressed: (){
              Get.back();
            }, icon: const Icon(Icons.arrow_back, color: Colors.black,)),
            centerTitle: true, backgroundColor: Colors.white, elevation: 0.0,
            title: Text("Auth Accounts",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 24),),
          ),
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                 controller.accountListViewState.data!.data!.isEmpty ? const EmptyScreen() :
                 Column(
                   children: [
                     ...List.generate(controller.accountListViewState.data!.data!.length, (index){
                       final items = controller.accountListViewState.data!.data;
                       const defaultImageUrl = "https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png";
                       return ListTile(
                         trailing: Text(items![index].balance == null ? "N 0.0" : "N ${items[index].balance.toString()}",
                           style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),),
                         leading:  Container(height: 48, width: 48,
                           decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey.withOpacity(0.15),
                               image: const DecorationImage(image: NetworkImage(defaultImageUrl),
                                 fit: BoxFit.cover,
                               )
                           ),
                         ),
                         title: Text(items[index].phoneNumber!,
                           style: Theme.of(context).textTheme.bodyText1?.copyWith(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),),
                       );
                     })
                   ],
                 )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
