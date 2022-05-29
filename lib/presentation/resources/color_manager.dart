import 'package:flutter/cupertino.dart';

class ColorManager
{
  static Color primary=HexColor.fromHex("#ED972");
  static Color darkGrey=HexColor.fromHex("#ED5252");
  static Color grey=HexColor.fromHex("#737477");
  static Color lightGrey=HexColor.fromHex("#9E9E9E");
  static Color primaryOpcaity70=HexColor.fromHex("#B3ED9728");


  static Color darkPrimary=HexColor.fromHex("#d17d11");
  static Color grey1=HexColor.fromHex("#707070");
  static Color grey2=HexColor.fromHex("#797979");
  static Color white=HexColor.fromHex("#FFFFFF");
  static Color error=HexColor.fromHex("#E61f34");


}
extension HexColor on Color
{
  static Color  fromHex(String hexColorString)
  {
    hexColorString=hexColorString.replaceAll('#', '');
    if(hexColorString.length==6)
      {
        hexColorString="FF"+hexColorString;//8 CHARACTER WITH OPACITY 100
      }
    return Color(int.parse(hexColorString,radix: 16));
  }
}