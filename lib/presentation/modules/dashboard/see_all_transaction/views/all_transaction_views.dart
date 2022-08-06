import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

import '../../../../../app/shared_widget/empty_screen.dart';
import '../../../../../app/utils/asset_path.dart';
import '../../home/controller/controller.dart';
import '../../home/widgets/transaction_tile.dart';

class AllTransactionViews extends StatelessWidget {
  const AllTransactionViews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
        builder: (controller){
      return SafeArea(top: false, bottom: false,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(centerTitle: true, backgroundColor: Colors.white, elevation: 0.0,
              leading: IconButton(onPressed: (){
                Get.back();
              }, icon: const Icon(Icons.arrow_back, color: Colors.black,)),
              title: Text("Transactions", style: Theme.of(context).textTheme.bodyText1?.copyWith(color: Colors.black, fontSize: 24, fontWeight: FontWeight.w700),),),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                children: [
                  controller.viewState.data!.data!.isEmpty ? const EmptyScreen() :
                 Column(
                   children: [
                     ...List.generate(controller.viewState.data!.data!.length > 3 ? 3 : controller.viewState.data!.data!.length, (index){
                       final items = controller.viewState.data!.data!;
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
                 )
                ],
              ),
            ),
          ));
    });
  }
}
