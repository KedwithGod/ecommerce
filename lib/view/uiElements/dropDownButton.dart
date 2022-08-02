



import '../../model/imports/generalImport.dart';

class DropDown extends StatelessWidget {
  final List<String> itemList;
  final String? validatorText;
  final String? dropDownValue;
  final FocusNode? focusNode;

  DropDown(this.itemList,
      {this.validatorText,  this.dropDownValue, this.focusNode});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BaseModel>.reactive(
    onModelReady: (model){
    },
    disposeViewModel: false,
    viewModelBuilder:()=>BaseModel(),
    builder: (context, model, child)=>

        FormField(
          key:UniqueKey(),
      builder: (FormFieldState<dynamic> field) {
        return Container(
          padding: const EdgeInsets.only(left: 20, right: 20.0,top: 2.0,bottom: 2.0222),
          decoration: BoxDecoration(
              borderRadius:BorderRadius.all(
                Radius.circular(sS(context).cH(height: 10),)
              ),color: white),

          child:  DropdownButtonHideUnderline(
            child: DropdownButton(
              icon:Padding(
                padding:  EdgeInsets.only(right: sS(context).cW(width: 16.41)),
                child: GeneralIconDisplay(LineIcons.angleDown,secondaryColor,UniqueKey(),15),
              ),
              focusNode: focusNode,
              dropdownColor: white,
              focusColor:const Color.fromRGBO(231, 231, 231, 1),
              isExpanded: true,
              style: const TextStyle(color:textFieldText, fontSize: 20,fontWeight: FontWeight.w400),
              value: model.dropDown,
              items: itemList
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                    value: value,
                    child: GeneralTextDisplay(value, textFieldText, 1, 14, FontWeight.w500, '')
                );
              })
                  .toList(),
              onChanged: (value) {
                //model.updateDropDownValue(value, dropDownValue);
              },

            ),
          ),
        );
      },
        validator: (val) {
          return val != '' ? null : validatorText;
        }  )
    );
  }
}
