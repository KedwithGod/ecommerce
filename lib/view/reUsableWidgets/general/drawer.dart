

import '../../../model/imports/generalImport.dart';

Widget drawer (context,{required Widget child,AdvancedDrawerController? controller}){
  return AdvancedDrawer(
    backdropColor: desertStorm,
    controller:controller,
    animationCurve: Curves.easeInOut,
    animationDuration: const Duration(milliseconds: 300),
    animateChildDecoration: true,
    rtlOpening: false,
    // openScale: 1.0,
    disabledGestures: false,
    childDecoration: const BoxDecoration(
      // NOTICE: Uncomment if you want to add shadow behind the page.
      // Keep in mind that it may cause animation jerks.
      // boxShadow: <BoxShadow>[
      //   BoxShadow(
      //     color: Colors.black12,
      //     blurRadius: 0.0,
      //   ),
      // ],
      borderRadius: BorderRadius.all(Radius.circular(16)),
    ),
    child: child,
    drawer: SafeArea(
      child: S(
        h:768,
        w: 375,
        child:Stack(
          children: [
            // menu
            rowPositioned(
              child: GeneralTextDisplay("Menu", secondaryColor,
                  1, 19.08, FontWeight.w500, "500") ,top: 22,
              left: 24
            ),
            // edit profile
            drawerItem(Icons.account_box_rounded,"Login", 78,onTap: (){
              Navigator.pushNamed(context, '/login',
              );
            }),
            // account
            drawerItem(Icons.favorite, "My Wish List", 126,onTap:(){
              Navigator.pushNamed(context, '/favoritePage',
              );
            }),
            // statement
            drawerItem(FontAwesomeIcons.bell, "Get Notification", 174),
            // link account
            drawerItem(FontAwesomeIcons.globe, "Languages", 222),
            // security
            drawerItem(Icons.money, "Currencies", 270),
            //  referral
            drawerItem(FontAwesomeIcons.moon, "Dark theme", 318),
            // terms of use
            drawerItem(Icons.star, "Rate the application", 362),

            // terms of use
            drawerItem(FontAwesomeIcons.key, "Privacy and Term", 414),

            drawerItem(Icons.info, "About Us", 462),

            // sign out
           // drawerItem(Icons.logout_rounded, "Sign Out", 622,color:const Color.fromRGBO(255,41,41,1)),
            // version
            rowPositioned(child:  GeneralTextDisplay("Ver 1.0.0", secondaryColor.withOpacity(0.5),
                1, 14, FontWeight.w500, "version",letterSpacing: 0.8,), top: 657,left:24)
          ],
        ) ,
      ),
    ),

  );
}


Widget drawerItem(IconData icon,String name,double top, {Color? color,Function? onTap}){
  return  rowPositioned(
      child: GestureDetector(
        onTap: (){
          onTap!();
        },
        child: Row(
          children: [
            Center(child: GeneralIconDisplay(icon, color??primary, UniqueKey(), 16))
            ,
            S(w:14),
             GeneralTextDisplay(name, color??secondaryColor,
                1, 14, FontWeight.w500, "text",letterSpacing: 0.8,),
          ],
        ),
      ) ,top: top,
      left: 24
  );
}