import 'package:ecommerce/model/imports/generalImport.dart';


class CategoryList extends StatelessWidget {
  final List<int> selectedCategory;
  const CategoryList({Key? key, required this.selectedCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoryHomePageViewModel>.reactive(
        onModelReady: (model) {
          model.initializeCheck();
        },
        disposeViewModel: false,
        viewModelBuilder: () => CategoryHomePageViewModel(),
        builder: (context, model, child) => baseUi(children: [
          // backButton
          backButton(context,top: 17),
              //1. if there is list selected, display selected category

              //2. hence all category will be displayed
              rowPositioned(
                child: GeneralTextDisplay(
                    selectedCategory.isEmpty? "All Categories":"Selected Category", black, 1, 20, FontWeight.w600, "title"),
                top: 20,
              ),
              Positioned(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if(selectedCategory.isNotEmpty)
                        for(int index in selectedCategory)...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: sS(context).cW(width: model.name[index].length.toDouble()*13),
                                  height: sS(context).cH(height: 30),
                                  padding:EdgeInsets.symmetric(vertical: sS(context).cH(height: 5),
                                      horizontal:sS(context).cW(width:5) ),
                                  decoration: BoxDecoration(

                                    color: fountainBlue.withOpacity(0.1),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(sS(context).cH(height: 15)),

                                    ),
                                  ),
                                  alignment: Alignment.center,child: GeneralTextDisplay(model.name[index], black, 1, 15, FontWeight.w600, "name")),
                              S(h:10),
                              S(
                                w: 160 * 5,
                                h: 220,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap:(){
                                              Navigator.pushNamed(context, '/productPage');
                                            },
                                            child: Container(
                                              width: sS(context).cW(width: 150),
                                              height: sS(context).cH(height: 180),
                                              decoration: BoxDecoration(
                                                image: const DecorationImage(
                                                    image:
                                                    AssetImage("assets/image.jpeg"),
                                                    fit: BoxFit.fill),
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset: const Offset(0, 4),
                                                      blurRadius: 12,
                                                      color: black.withOpacity(0.25))
                                                ],
                                                color: white,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      sS(context).cH(height: 15)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // category name
                                          S(h: 10),
                                          GeneralTextDisplay("item Name", black, 1,
                                              13, FontWeight.w400, "item name"),
                                        ],
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return S(w: 15);
                                    },
                                    itemCount: 5),
                              ),
                              if(index==model.itemCount.length-1)S(h:40),
                            ],
                          ),
                          S(h:10)
                        ],
                        if(selectedCategory.isEmpty)
                          for(int index in model.itemCount)...[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: sS(context).cW(width: model.name[index].length.toDouble()*13),
                                    height: sS(context).cH(height: 30),
                                    padding:EdgeInsets.symmetric(vertical: sS(context).cH(height: 5),
                                        horizontal:sS(context).cW(width:5) ),
                                    decoration: BoxDecoration(

                                      color: fountainBlue.withOpacity(0.1),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(sS(context).cH(height: 15)),

                                      ),
                                    ),
                                    alignment: Alignment.center,child: GeneralTextDisplay(model.name[index], black, 1, 15, FontWeight.w600, "name")),
                                S(h:10),
                                S(
                                  w: 160 * 5,
                                  h: 220,
                                  child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: sS(context).cW(width: 150),
                                              height: sS(context).cH(height: 180),
                                              decoration: BoxDecoration(
                                                image: const DecorationImage(
                                                    image:
                                                    AssetImage("assets/image.jpeg"),
                                                    fit: BoxFit.fill),
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset: const Offset(0, 4),
                                                      blurRadius: 12,
                                                      color: black.withOpacity(0.25))
                                                ],
                                                color: white,
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(
                                                      sS(context).cH(height: 15)),
                                                ),
                                              ),
                                            ),
                                            // category name
                                            S(h: 10),
                                            GeneralTextDisplay("item Name", black, 1,
                                                13, FontWeight.w400, "item name"),
                                          ],
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return S(w: 15);
                                      },
                                      itemCount: 5),
                                ),
                                if(index==model.itemCount.length-1)S(h:40),
                              ],
                            ),
                            S(h:10)
                          ]
                      ],
                    ),
                  ),

                  top: sS(context).cH(height: 100),
                  bottom: 0,
                  left: 20,
                  right: 0),
              // page tab
              pageTab(context, tabEnum: TabEnum.categories)
            ], allowBackButton: false));
  }
}

// all category