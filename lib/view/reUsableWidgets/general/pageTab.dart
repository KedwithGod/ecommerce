// page tab


import 'package:ecommerce/model/imports/generalImport.dart';


Widget pageTab(context, {double? top, TabEnum? tabEnum}){
  return rowPositioned(
    child: Container(
      width: sS(context).cW(width: 375),
      height: sS(context).cH(height: 65),
      decoration:  BoxDecoration(
        color: white,
        boxShadow: [
          BoxShadow(
            offset:const Offset(15, 0),
            blurRadius: 12,
            color:secondaryColor.withOpacity(0.15)
          )
        ]
      ),
      child: Stack(
        children: [
          // home page
          tabWidget(context, icon: tabEnum==TabEnum.home?
          FontAwesomeIcons.house:LineIcons.home,
              isSelected:tabEnum==TabEnum.home?true:false,left:26,
          navigation: tabEnum==TabEnum.home?(){}:
          (){
            Navigator.pushNamed(context, '/homePage');
          }
          ),
          // cart page
          tabWidget(context, icon: tabEnum==TabEnum.cart?
          FontAwesomeIcons.shoppingCart:LineIcons.shoppingCart,
              isSelected:tabEnum==TabEnum.cart?true:false,left:99,
              navigation: tabEnum==TabEnum.cart?(){}:
                  (){
                Navigator.pushNamed(context, '/cartFirstPage');
              }
          ),
          // categories page
          tabWidget(context, icon: tabEnum==TabEnum.categories?
          FontAwesomeIcons.bellConcierge:LineIcons.conciergeBell,
              isSelected:tabEnum==TabEnum.categories?true:false,left:172,
              navigation: tabEnum==TabEnum.categories?(){}:
                  (){

              }
          ),
          // favorite page
          tabWidget(context, icon: tabEnum==TabEnum.favorite?
          FontAwesomeIcons.solidHeart:LineIcons.heart,
              isSelected:tabEnum==TabEnum.favorite?true:false,right:100,
              navigation:tabEnum==TabEnum.favorite?(){}:
                  (){
                Navigator.pushNamed(context, '/favoritePage');
              }),
          // profile page
      tabWidget(context, icon: tabEnum==TabEnum.profile?
      FontAwesomeIcons.solidUser:LineIcons.user,
          isSelected:tabEnum==TabEnum.profile?true:false,right:25,
          navigation: tabEnum==TabEnum.profile?(){}:
        (){
  Navigator.pushNamed(context, '/accountPage');
  }),
        ],
      ),
    ), top:top?? 670,
  );
}


Widget tabWidget(context,{required IconData icon,
required bool isSelected,double? left,double? right,
  Function? navigation
}){
  return Stack(
    children: [

        rowPositioned(child:
        GestureDetector(
          onTap:(){
            navigation!();
          },
      child: Column(
          children: [
            // home page
            GeneralIconDisplay(icon, primary, UniqueKey(), 25),

          ],
      ),
    )
          , top: 11,left:left,right:right),
      ],
  );
}