import 'package:ecommerce/model/imports/generalImport.dart';



class ProductPage extends StatelessWidget {
  final ProductResponse data;
  const ProductPage({Key? key,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductPageViewModel>.reactive(
        onModelReady: (model) {
    },
    disposeViewModel: false,
    viewModelBuilder: () => ProductPageViewModel(),
    builder: (context, model, child) =>baseUi(children: [
      Container(
        width: sS(context).cW(width: 375),
        height: sS(context).cH(height: 400),
        decoration: BoxDecoration(
          image:  DecorationImage(
              image:
              NetworkImage(data.images![0].src!),
              fit: BoxFit.fill),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, 4),
                blurRadius: 12,
                color: secondaryColor.withOpacity(0.25))
          ],
          color: white,
          borderRadius: BorderRadius.only(
            bottomLeft:Radius.circular(
                sS(context).cH(height: 15)),
            bottomRight:Radius.circular(
                sS(context).cH(height: 15)),
          ),
        ),
      ),
      // back button
      backButton(context,top: 17,color: fountainBlue.withOpacity(0.4)),
      // favorite button
      rowPositioned(
        child: GestureDetector(
          onTap:(){
            model.addToFavorite();
          },
          child: Container(
          width: sS(context).cW(width: 40),
    height: sS(context).cH(height: 40),
    decoration:  BoxDecoration(
    color: white, shape:BoxShape.circle,
      boxShadow: [
          BoxShadow(
            offset:const Offset(0,4),
            blurRadius: 12,
            color: petiteOrchid.withOpacity(0.3)
          )
      ]
    ),
    alignment: Alignment.center,
          child: GeneralIconDisplay(FontAwesomeIcons.solidHeart,
              model.isProductSelected?primary:regentGray, UniqueKey(), 25),
          ),
        ),
        top:17,right:30
      ),
      // product

      // title
      rowPositioned(child:GeneralTextDisplay(
          data.name!, secondaryColor, 1, 20, FontWeight.w800, "title"),top: 420,left: 20),
      // subtitle
      rowPositioned(child:GeneralTextDisplay(
          data.type!, regentGray, 1, 12, FontWeight.w400, "title"),top: 450,left: 22),
      // amount
      rowPositioned(child:GeneralTextDisplay(data.price!, primary, 1, 20,
          FontWeight.w700, "price"),right:22,top:440),
      // rating
      rowPositioned(child:
      Row(children: [
        for(int i in [0,1,2,3,4])...[
          GeneralIconDisplay(Icons.star, petiteOrchid, UniqueKey(), 23),
          S(w:3)
        ]

      ],), top: 470,left:22),
      // details
      rowPositioned(
          child: S(
            h: 100,
            w: 335,
            child: GeneralTextDisplay(
               data.shortDescription!,
                regentGray, 5, 13, FontWeight.w500, "details"),
          ),
          top: 503,left:22),
      // add to cart
      rowPositioned(
          child: GestureDetector(
            onTap:(){
              Navigator.pushNamed(context, '/cartFirstPage');
            },
            child: Container(
              width: sS(context).cW(width: 65),
              height: sS(context).cH(height: 65),
              decoration:  BoxDecoration(
                  color: desertStorm.withOpacity(0.6), shape:BoxShape.circle,

              ),
              alignment: Alignment.center,
              child: GeneralIconDisplay(FontAwesomeIcons.cartShopping,
                  primary, UniqueKey(), 20),
            ),
          ),
          top:610,left:30
      ),
      // buy now
      rowPositioned(
          child: ButtonWidget(
                () {

            },
            primary,
            230,
            45,
            GeneralTextDisplay("Buy Now", white, 1, 13,
                FontWeight.w400, "Buy Now"),
            Alignment.center,
            20,
          ),
          top: 620,right:25),

    ], allowBackButton: false));
  }
}
