import 'package:ecommerce/model/imports/generalImport.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return baseUi(children: [
      rowPositioned(
          child: GeneralIconDisplay(Icons.menu, black, UniqueKey(), 20),
          top: 25,
          left: 20),
      // title
      rowPositioned(
        child: GeneralTextDisplay(
            "My WishList", black, 1, 20, FontWeight.w600, "title"),
        top: 20,
      ),
      // list of items in cart
      Positioned(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                        onTap:(){
                          Navigator.pushNamed(context, '/productPage');
                        },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // s/n
                         Container(
                             width: sS(context).cW(width: 40),
                             height: sS(context).cH(height: 40),
                             decoration:const  BoxDecoration(
                                 color: desertStorm, shape:BoxShape.circle,

                             ),
                             alignment: Alignment.center,

                             child: GeneralTextDisplay(
                                 "${index+1}", black, 1, 15, FontWeight.w400, "index")),
                          S(w: 15),
                          // item image
                          Container(
                              width: sS(context).cW(width: 90),
                              height: sS(context).cH(height: 110),
                              decoration: BoxDecoration(
                                image: const DecorationImage(
                                    image: AssetImage(
                                      "assets/image.jpeg",
                                    ),
                                    fit: BoxFit.cover),
                                color: white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(sS(context).cH(height: 15)),
                                ),
                              )),

                          S(w: 15),
                          // item details
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // name
                              GeneralTextDisplay("Red Wide Gown", black, 1,
                                  12, FontWeight.w600, "name"),
                              // description
                              S(h: 5),
                              GeneralTextDisplay(
                                  "Long stretchy gown",
                                  regentGray,
                                  1,
                                  10,
                                  FontWeight.w600,
                                  "description"),
                              // price
                              S(h: 12),
                              GeneralTextDisplay("₦ 300,000", primary, 1, 15,
                                  FontWeight.w700, "price"),
                            ],
                          ),
                          // increment
                        ],
                      ),
                    ),
                    if(index==4)S(h:40)
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return S(h: 15);
              },
              itemCount: 2),
          top: sS(context).cH(height: 75),
          bottom: 0,
          left: 10,
          right: 0),
      // page tab
      pageTab(context, tabEnum: TabEnum.favorite)
    ], allowBackButton: false);
  }
}
