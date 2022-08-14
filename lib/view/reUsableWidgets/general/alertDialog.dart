import 'package:ecommerce/model/imports/generalImport.dart';

class DialogBox extends StatelessWidget {
  final String? message;
  final String?title;
  final String? dismissText;
  final DialogType dialogType;
  final String? optionalButtonText;
  final Function? optionButtonFunction,function;
  final Color? dismissTextColor;
  final bool? optionButtonToggle;
  final int? messageLineNo;


  DialogBox(this.message, this.title,this.dialogType,{this.messageLineNo,this.dismissText,this.function,
    this.dismissTextColor,this.optionalButtonText,this.optionButtonFunction,this.optionButtonToggle
  }) ;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BaseModel>.reactive(
        viewModelBuilder: () => BaseModel(),
        disposeViewModel: false,
        builder: (context, model, child) =>Container(
          child: AlertDialog(
            title: Center(
              child: GeneralTextDisplay(title!, Colors.black,
                  1, 24, FontWeight.w400,title!),
            ),
            content:  GeneralTextDisplay(message!, secondaryColor,
                messageLineNo??5, 18, FontWeight.w300,message!),
            actions: [
              dialogType==DialogType.notification?Image.asset('assets/notification.png',height: sS(context).cH(height: 120),
                width: sS(context).cW(width: 120),):
              dialogType==DialogType.error?Image.asset('assets/error.png',height: sS(context).cH(height: 120),
                width:  sS(context).cW(width: 120),):loading(width: 120,height: 120)
              ,
              GestureDetector(
                onTap:function!() ?? (){Navigator.pop(context);},
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GeneralTextDisplay(dismissText??'close',
                      dismissTextColor??Colors.red,
                      1, 15, FontWeight.w400,''),
                ),
              ),
              if(optionButtonToggle==true)GestureDetector(
                onTap:optionButtonFunction!(),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GeneralTextDisplay(optionalButtonText!, Colors.green,
                      1, 15, FontWeight.w400,''),
                ),
              ),
            ],
          ),
        ));
  }
}
