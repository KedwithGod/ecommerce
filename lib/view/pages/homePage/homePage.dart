import 'package:ecommerce/model/imports/generalImport.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return baseUi(children: [
      // menu
      rowPositioned(
          child: GeneralIconDisplay(Icons.menu, black, UniqueKey(), 20),
          top: 24,
          left: 20),
      // logo
      rowPositioned(
          child: GeneralTextDisplay(
              "CARDIZERR", black, 1, 20, FontWeight.w800, "title"),
          top: 18),
      // notification
      rowPositioned(
          child: GeneralIconDisplay(
              FontAwesomeIcons.solidBell, black, UniqueKey(), 17),
          top: 24,
          right: 20),
      Positioned(
          child: SingleChildScrollView(
            child: Column(
              children: [
                S(h:1300,
                    w:375,
                child: Stack(
                  children: [
                    // slider
                    Positioned(
                        child: SingleChildScrollView(
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: 180.0,
                              enlargeCenterPage: true,
                              autoPlay: true,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: false,
                              autoPlayAnimationDuration: const Duration(milliseconds: 600),
                              viewportFraction: 0.6,
                            ),
                            items: [1, 2, 3,4].map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: sS(context).cW(width: 300),
                                      height: sS(context).cH(height: 390),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(image: AssetImage(i==1?
                                           "assets/shoe.jpeg" :i==2?
                                            "assets/shirt.jpeg"
                                            :i==3?"assets/bag.jpeg":"assets/image.jpeg"),
                                            fit: BoxFit.fill),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: const Offset(0,4),
                                              blurRadius: 12,
                                              color: black.withOpacity(0.25)
                                          )
                                        ],
                                        color: white,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(sS(context).cH(height: 15)),

                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        top: sS(context).cH(height: 0),
                        bottom: 0,
                        left: 0,
                        right: 0),
                    // add banner
                    rowPositioned(child:
                    Container(
                      width: sS(context).cW(width: 325),
                      height: sS(context).cH(height: 150),
                      decoration: BoxDecoration(
                        color: desertStorm,
                        image:const DecorationImage(
                            image: AssetImage("assets/banner.jpeg"),
                            fit: BoxFit.fill),


                        borderRadius: BorderRadius.all(
                          Radius.circular(sS(context).cH(height: 15)),

                        ),
                      ),
                    ), top: 170),
                    // category
                    rowPositioned(
                        child: GeneralTextDisplay(
                            "Category", black, 1, 15, FontWeight.w500, "category"),
                        top: 340,left:20),

                    // see all
                    rowPositioned(
                        child: Container(
                          width: sS(context).cW(width: 68),
                          height: sS(context).cH(height: 20),
                          decoration: BoxDecoration(

                            color: petiteOrchid.withOpacity(0.7),
                            borderRadius: BorderRadius.all(
                              Radius.circular(sS(context).cH(height: 15)),

                            ),
                          ),
                          alignment: Alignment.center,
                          child: GeneralTextDisplay(
                              "See All", white, 1, 12, FontWeight.w400, "see all",
                          ),
                        ),
                        top: 340,right:25),
                    // category grid
                    Positioned(
                      child: GridView.builder(
                        itemCount: 12,
                        physics:const NeverScrollableScrollPhysics(),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisExtent: 265,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 12
                        ), itemBuilder:
                          (context,index){
                        return Padding(
                            padding:  EdgeInsets.symmetric(
                                horizontal: sS(context).cW(width: 3),
                                vertical: sS(context).cH(height: 3)
                            ),child: S(
                          h: 265,
                          w: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: sS(context).cW(width: 150),
                                height: sS(context).cH(height: 180),
                                decoration: BoxDecoration(
                                  image:const DecorationImage(image: AssetImage("assets/image.jpeg"),
                                    fit: BoxFit.fill
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(0,4),
                                        blurRadius: 12,
                                        color: black.withOpacity(0.25)
                                    )
                                  ],
                                  color: white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(sS(context).cH(height: 15)),

                                  ),
                                ),
                              ),
                              // category name
                              S(h:10),
                              GeneralTextDisplay("Category Name", black, 1, 13,
                                  FontWeight.w400, "category name"),
                            ],
                          ),
                        ));
                      }, ),
                      top: sS(context).cH(height: 375),
                      left: sS(context).cW(width: 10),
                      right:sS(context).cW(width: 10),
                      bottom:sS(context).cH(height: 230),
                    ),
                    // reviews
                    Positioned(
                        child: SingleChildScrollView(
                          child: CarouselSlider(
                            options: CarouselOptions(
                              height: 235.0,
                              enlargeCenterPage: false,
                              autoPlay: true,
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enableInfiniteScroll: true,
                              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                              viewportFraction: 1,
                            ),
                            items: [1, 2, 3,4].map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: sS(context).cW(width: 325),
                                      height: sS(context).cH(height: 180),
                                      decoration: BoxDecoration(
                                        color: jaggedIce,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(sS(context).cH(height: 15)),

                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          // rating
                                          rowPositioned(
                                              child: Row(
                                                children: [
                                                  GeneralTextDisplay(
                                                      "4.7 ", black, 1, 15, FontWeight.w500, "rating"),
                                                  GeneralIconDisplay(Icons.star, primary, UniqueKey(), 20)
                                                ],
                                              ),
                                              top: 20,right:20),
                                          // title
                                          rowPositioned(
                                              child: GeneralTextDisplay(
                                                  "Amazing Dress", black, 1, 15, FontWeight.w500, "title"),
                                              top: 20,left:20),
                                          // details
                                          rowPositioned(
                                              child: S(
                                                h: 100,
                                                w: 285,
                                                child: GeneralTextDisplay(
                                                    "A wealthy character might show off their expensive clothing. But they could also dress in modest, inexpensive-looking clothes.",
                                                    regentGray, 5, 13, FontWeight.w500, "title"),
                                              ),
                                              top: 50,left:20,right:20),
                                          // photo
                                          rowPositioned(child:
                                          Container(
                                            width: sS(context).cW(width: 50),
                                            height: sS(context).cH(height: 50),
                                            decoration: const BoxDecoration(
                                                image:DecorationImage(
                                                    image: AssetImage("assets/smallImage.jpeg"),
                                                    fit: BoxFit.fill),
                                                shape: BoxShape.circle
                                            ),
                                          ), top: 120,right:20),
                                          // name
                                          rowPositioned(
                                              child: GeneralTextDisplay(
                                                  "Jaye ifeoluwa", black51, 1, 10, FontWeight.w500, "name"),
                                              top: 140,right:90),
                                          // client type
                                          rowPositioned(
                                              child: GeneralTextDisplay(
                                                  "Customer", petiteOrchid, 1, 10, FontWeight.w500, "name"),
                                              top: 155,right:90),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ),
                        top: sS(context).cH(height: 1060),
                        bottom: 0,
                        left: 0,
                        right: 0),

                  ],
                ),
                ),
                S(h:20)
              ],
            ),
          ),
          top: sS(context).cH(height: 60),
          bottom: 0,
          left: 0,
          right: 0),

      // page tab
      pageTab(context,tabEnum: TabEnum.home)
      // tab
    ], allowBackButton: false);
  }
}