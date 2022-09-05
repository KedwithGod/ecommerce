

import '../../../model/imports/generalImport.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountViewModel>.reactive(
        onModelReady: (model) {
          model.guestStatus();
          // fetch user data
          model.userDetails(context);

    },
    disposeViewModel: false,
    viewModelBuilder: () => AccountViewModel(),
    builder: (context, model, child) =>drawer(context,
      asGuest: model.asGuest,
      child: baseUi(children: [
        if(model.asGuest==true)...[
          // menu
          rowPositioned(
              child: GestureDetector(
                  onTap: () {
                    model.advancedDrawerController.showDrawer();
                  },
                  child: GeneralIconDisplay(Icons.menu, secondaryColor, UniqueKey(), 20)),
              top: 25,
              left: 20),
          // title
          rowPositioned(
            child: GeneralTextDisplay(
                "Guest User", secondaryColor, 1, 20, FontWeight.w600, "title"),
            top: 20,
          ),
          Positioned(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [

                  Column(
                    children: [
                      for(var i in [0,1,2,3])...[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            S(w:22),
                            // days ago
                            S(
                              h:35,
                              w:41,
                              child: GeneralTextDisplay(
                                  "15 Days Ago", black51.withOpacity(0.45), 2, 10,
                                  FontWeight.w600, "days ago"),
                            ),
                            // investment type
                            S(w:10),
                            GeneralTextDisplay(
                                i==2?"Sweet shirt": "Black Gown", black51, 1, 11,
                                FontWeight.w600, "investment type"),
                            Spacer(),
                            // amount
                            GeneralTextDisplay(
                                "₦ ${displayWithComma(k_m_b_generator(300000))}",
                                fountainBlue, 1, 11, FontWeight.w600, "amount"),
                            S(w:20),
                          ],
                        ),
                        S(h:20)
                      ]

                    ],
                  )
                ],
              ),
            ),
            top: sS(context).cH(height: 80),
            left: sS(context).cW(width: 0),
            right:sS(context).cW(width: 0),
            bottom:sS(context).cH(height: 28.65),
          ),
        ],
         if(model.asGuest!=true&&model.userData!=null)...[
           // menu
           rowPositioned(
               child: GestureDetector(
                   onTap: () {
                     model.advancedDrawerController.showDrawer();
                   },
                   child: GeneralIconDisplay(Icons.menu, secondaryColor, UniqueKey(), 20)),
               top: 25,
               left: 20),
           // title
           rowPositioned(
             child: GeneralTextDisplay(
                 "My Profile", secondaryColor, 1, 20, FontWeight.w600, "title"),
             top: 20,
           ),
           // avatar
           rowPositioned(
               child: Container(
                 width: sS(context).cW(width: 100),
                 height: sS(context).cH(height: 100),

                 decoration: model.userData==null||model.userData!.avatarUrl.isEmpty?
                 BoxDecoration(
                   borderRadius:
                   BorderRadius.all(Radius.circular(sS(context).cH(height: 15))),
                   image: const DecorationImage(
                       image:AssetImage("assets/noUser.jpeg",),
                       fit: BoxFit.fill),
                 )
                     :BoxDecoration(
                   borderRadius:
                   BorderRadius.all(Radius.circular(sS(context).cH(height: 15))),
                   image: DecorationImage(
                       image: NetworkImage(model.userData!.avatarUrl),
                       fit: BoxFit.fill),
                 ),
               ),
               top: 65,
               left: 20),
           rowPositioned(child:Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               // name
               GeneralTextDisplay(model.userData!.firstName+" "+model.userData!.lastName, secondaryColor, 1,
                   12, FontWeight.w600, "name"),
               // status
               S(h: 5),
               GeneralTextDisplay(
                   model.userData!.username,
                   regentGray,
                   1,
                   10,
                   FontWeight.w600,
                   "description"),
               // email
               S(h: 8),
               GeneralTextDisplay( model.userData!.email,
                   black51,
                   1,
                   10,
                   FontWeight.w600,
                   "email"),
               // wallet balance
               S(h: 8),
               model.walletData==null?
               GeneralTextDisplay("", primary, 1, 15,
                   FontWeight.w700, "balance")
                   :GeneralTextDisplay(model.walletData!.currency.toString()+" "+ model.walletData!.balance!, primary, 1, 15,
                   FontWeight.w700, "balance"),
             ],
           ),
             top: 85,
           ),

           // history
           rowPositioned(
               child:   // name
               GeneralTextDisplay("Transaction Details", black51, 1,
                   14, FontWeight.w400, "name"),top:220,left:22
           ),
           Positioned(
             child: SingleChildScrollView(
               physics: const ClampingScrollPhysics(),
               child: Column(
                 children: [
                   if(model.transactionList.isEmpty)GeneralTextDisplay(
                       "You have no wallet transaction yet", black51.withOpacity(0.45), 1, 14,
                       FontWeight.w600, "no transaction"),
                   if(model.transactionList.isNotEmpty)Column(
                     children: [
                       for(var index in List.generate(model.transactionList.length, (index) => index))...[
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             S(w:22),
                             // days ago
                             S(
                               h:24,
                               w:41,
                               child: GeneralTextDisplay(
                                   WalletTransactionResponse.fromJson(model.transactionList[index]).date!, black51.withOpacity(0.45), 2, 10,
                                   FontWeight.w600, "days ago"),
                             ),
                             // details
                             S(w:10),
                             GeneralTextDisplay(
                                 WalletTransactionResponse.fromJson(model.transactionList[index]).details!, black51, 1, 11,
                                 FontWeight.w600, "details"),
                             Spacer(),
                             // amount
                             GeneralTextDisplay(
                                 "₦ ${displayWithComma(k_m_b_generator(
                                     double.parse(WalletTransactionResponse.fromJson(model.transactionList[index]).amount!)

                                 ))}",
                                 fountainBlue, 1, 11, FontWeight.w600, "amount"),
                             S(w:20),
                           ],
                         ),
                         S(h:20)
                       ]

                     ],
                   )
                 ],
               ),
             ),
             top: sS(context).cH(height: 280),
             left: sS(context).cW(width: 0),
             right:sS(context).cW(width: 0),
             bottom:sS(context).cH(height: 28.65),
           ),
          ],

        // page tab
        pageTab(context, tabEnum: TabEnum.profile)
      ], allowBackButton: false),controller: model.advancedDrawerController
    ));
  }
}
