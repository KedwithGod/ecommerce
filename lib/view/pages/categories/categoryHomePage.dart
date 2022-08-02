import 'package:ecommerce/model/imports/generalImport.dart';
import 'package:ecommerce/view/reUsableWidgets/general/button.dart';

class CategoryHomePage extends StatelessWidget {
  const CategoryHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CategoryHomePageViewModel>.reactive(
        onModelReady: (model) {
          model.initializeCheck();
        },
        disposeViewModel: false,
        viewModelBuilder: () => CategoryHomePageViewModel(),
        builder: (context, model, child) => baseUi(children: [
              // title
              rowPositioned(
                  child: S(
                    h: 55,
                    w: 275,
                    child: GeneralTextDisplay(
                      "Choose your favorite fashion categories",
                      secondaryColor,
                      2,
                      18,
                      FontWeight.w600,
                      "title",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  top: 20),
              // subtitle
              rowPositioned(
                  child: GeneralTextDisplay("You can choose more than one",
                      regentGray, 1, 10, FontWeight.w500, "name"),
                  top: 80),
              // chips of category

              rowPositioned(
                child: S(
                  w: 200,
                  h: 400,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    runSpacing: 20,
                    children: [
                      for (int index in model.itemCount) ...[
                        S(
                          w: 90,
                          h: 45,
                          child: ChoiceChip(
                              label: GeneralTextDisplay(
                                model.name[index],
                                model.itemColor[index],
                                1,
                                12,
                                FontWeight.w400,
                                "item",
                                textAlign: TextAlign.center,
                              ),
                              selectedColor: primary,
                              onSelected: (onSelected) {
                                model.onSelected(index);
                              },
                              backgroundColor: white,
                              selected: model.isSelected[index]),
                        ),
                      ]
                    ],
                  ),
                ),
                top: 130,
              ),

              // continue
              rowPositioned(
                  child: buttonWidget(
                      text: "Continue",
                      onPressed: () {
                        if (model.selectedIndex.isEmpty) {
                          SnackBar snackBar=SnackBar(
                            backgroundColor: petiteOrchid.withOpacity(0.3),
                            content: GeneralTextDisplay("You have not selected any category",
                                black51, 1, 13, FontWeight.w500, "",textAlign: TextAlign.center,),);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);

                        } else {
                          Navigator.pushNamed(context, '/categoryList',
                              arguments: model.selectedIndex);
                        }
                      },
                      radius: 20,
                      textColor: white),
                  top: 550),
              // skip for now
              rowPositioned(
                  child: ButtonWidget(
                    () {
                      Navigator.pushNamed(context, '/categoryList',
                          arguments: <int>[]);
                    },
                    white,
                    100,
                    20,
                    GeneralTextDisplay("Skip for now", regentGray, 1, 10,
                        FontWeight.w400, "skip for now"),
                    Alignment.center,
                    0,
                    noElevation: true,
                  ),
                  top: 610),
              // page tab
              pageTab(context, tabEnum: TabEnum.categories)
            ], allowBackButton: false));
  }
}
