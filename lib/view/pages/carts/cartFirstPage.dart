import 'package:ecommerce/model/imports/generalImport.dart';

class CartFirstPage extends StatelessWidget {
  const CartFirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CartFirstPageViewModel>.reactive(
        onModelReady: (model) {
          model.initializeCheck();
        },
        disposeViewModel: false,
        viewModelBuilder: () => CartFirstPageViewModel(),
        builder: (context, model, child) => baseUi(children: [
              // menu
              rowPositioned(
                  child: GeneralIconDisplay(Icons.menu, black, UniqueKey(), 20),
                  top: 25,
                  left: 20),
              // title
              rowPositioned(
                child: GeneralTextDisplay(
                    "My Cart", black, 1, 20, FontWeight.w600, "title"),
                top: 20,
              ),
              // list of items in cart
              Positioned(
                  child: ListView.separated(
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // check box
                                Checkbox(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(
                                                sS(context).cH(height: 3)))),
                                    activeColor: primary,
                                    value: model.isChecked[index],
                                    onChanged: (value) {
                                      model.checkBox(index,value!);
                                    }),

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
                                S(w: 15),
                                Row(
                                  children: [
                                    // subtract
                                    GestureDetector(
                                        onTap: () {
                                          model.decrement();
                                        },
                                        child: GeneralIconDisplay(LineIcons.minus,
                                            regentGray, UniqueKey(), 15)),
                                    // value
                                    S(w: 15),
                                    GeneralTextDisplay(model.cartValue.toString(),
                                        black, 1, 13, FontWeight.w600, "title"),
                                    // add
                                    S(w: 15),
                                    GestureDetector(
                                        onTap: () {
                                          model.increment();
                                        },
                                        child: GeneralIconDisplay(LineIcons.plus,
                                            primary, UniqueKey(), 16.5))
                                  ],
                                )
                              ],
                            ),
                            if(index==4)S(h:40)
                          ],
                        );
                      },
                      separatorBuilder: (context, index) {
                        return S(h: 15);
                      },
                      itemCount: 5),
    top: sS(context).cH(height: 75),
    bottom: 0,
    left: 10,
    right: 0),
              // page tab
              pageTab(context, tabEnum: TabEnum.cart)
            ], allowBackButton: false));
  }
}
