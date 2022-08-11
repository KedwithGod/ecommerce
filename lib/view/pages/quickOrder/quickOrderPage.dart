import 'package:ecommerce/model/imports/generalImport.dart';


class QuickOrderPage extends StatelessWidget {
  const QuickOrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<QuickOrderViewModel>.reactive(
        viewModelBuilder: () => QuickOrderViewModel(),
        onModelReady: (model) async {
          model.guestStatus();
          // fetch category list
          model.fetchCategoryList(isQuickOrder: true);
        },
        disposeViewModel: false,
        builder: (context, model, child) =>
            drawer(context,
                asGuest: model.asGuest,
                child: baseUi(children: [
                  // menu
                  rowPositioned(
                      child: GestureDetector(
                          onTap: () {
                            model.advancedDrawerController.showDrawer();
                          },
                          child: GeneralIconDisplay(
                              Icons.menu, secondaryColor, UniqueKey(), 20)),
                      top: 25,
                      left: 20),
                  // title
                  rowPositioned(
                    child: GeneralTextDisplay(
                        "Quick Order", secondaryColor, 1, 20,
                        FontWeight.w600, "title"),
                    top: 20,
                  ),

                  model.categoryDropDown.length == model.categoryList.length &&
                      model.categoryList.isNotEmpty
                      ? Stack(children: [
                    // language dropdown
                    rowPositioned(
                        child: S(
                          w: 343,
                          h: 54,
                          child: DropDown(UniqueKey(),
                            model.langList,
                            updateValue: DropDownEnum.lang,
                          ),
                        ),
                        top: 100),
                    // category dropdown
                    rowPositioned(
                        child: S(
                          w: 343,
                          h: 54,
                          child: DropDown(UniqueKey(),
                            model.categoryDropDown,
                            updateValue: DropDownEnum.category,
                          ),
                        ),
                        top: 169),
                  ])
                      : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        loading(width: 100, height: 100),
                        S(h: 20),
                        GeneralTextDisplay('Loading page context',
                            secondaryColor, 1, 15, FontWeight.w400, "")
                      ],
                    ),
                  ),

                  // product drop down- shows only when category is selected
                rowPositioned(
                      child:  S(
                              w: 343,
                              h: 54,
                              child: DropDown(UniqueKey(),
                                model.productDropDown,
                                updateValue: DropDownEnum.product,
                              ),
                            ),
                      top: 238),

                  // price text field field up, once product is selected

                  // quantity
                  // add to cart button
                  // page tab
                  pageTab(context, tabEnum: TabEnum.quickOrder)
                ], allowBackButton: false),
                controller: model.advancedDrawerController));
  }

}
