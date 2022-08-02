


import '../../../model/imports/generalImport.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountViewModel>.reactive(
        onModelReady: (model) {
    },
    disposeViewModel: false,
    viewModelBuilder: () => AccountViewModel(),
    builder: (context, model, child) =>drawer(context,
      child: baseUi(children: [
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
              height: sS(context).cH(height: 120),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.all(Radius.circular(sS(context).cH(height: 15))),
                image:const DecorationImage(
                    image: AssetImage("assets/smallImage.jpeg"),
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
            GeneralTextDisplay("Daniel Racheal", secondaryColor, 1,
                12, FontWeight.w600, "name"),
         // status
            S(h: 5),
            GeneralTextDisplay(
                "Guest",
                regentGray,
                1,
                10,
                FontWeight.w600,
                "description"),
          // wallet balance
            S(h: 8),
            GeneralTextDisplay("₦ 300,000", primary, 1, 15,
                FontWeight.w700, "price"),
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

                Column(
                  children: [
                    for(var i in [0,1,2,3])...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          S(w:22),
                          // days ago
                          S(
                            h:24,
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
          top: sS(context).cH(height: 280),
          left: sS(context).cW(width: 0),
          right:sS(context).cW(width: 0),
          bottom:sS(context).cH(height: 28.65),
        ),
        // page tab
        pageTab(context, tabEnum: TabEnum.profile)
      ], allowBackButton: false),controller: model.advancedDrawerController
    ));
  }
}
