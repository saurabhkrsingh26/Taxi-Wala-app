import 'package:flutter/material.dart';
import 'package:taxiwala/res/provider/whatsapp_view_provider.dart';
import 'package:url_launcher/url_launcher.dart';
// class Launcher {
//   static void openwhatsapp(context) async {
//     final String  whatsapp ="7458946942" ;
//     print(whatsapp);
//     print("aman");
//     var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=hello";
//     var whatappURL_ios = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
//
//     if (await canLaunch(whatsappURl_android)) {
//       await launch(whatsappURl_android);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: new Text("whatsapp not installed")));
//     }
//   }
//
//   static void linkurl() async {
//     const url = 'https://www.geeksforgeeks.org/';
//     if (await canLaunch(url)) {
//       await launch(url, forceWebView: true, enableJavaScript: true);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   static void linkurlnew() async {
//     const url = 'https://www.whatsapp.com/';
//     if (await canLaunch(url)) {
//       await launch(url, forceWebView: true, enableJavaScript: true);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
// }


class Launcher{
  // static launchWhatsApp(BuildContext context, String phone) async {
  //   var whatsAppUrlAndroid =
  //       "whatsapp://send?phone=" + '91$phone' + "&text=hello";
  //   if (await canLaunch(whatsAppUrlAndroid)) {
  //     await launch(whatsAppUrlAndroid);
  //   } else {
  //     // Utils.flushBarErrorMessage("whatsapp not installed",context);
  //   }
  // }
  static void openwhatsapp(context) async{
    final String  whatsapp =Whatsapp.toString();
    print(Whatsapp);
    var whatsappURl_android = "whatsapp://send?phone="+whatsapp+"&text=hello";
    print(whatsappURl_android);
    var whatappURL_ios ="https://wa.me/$whatsapp?text=${Uri.parse("hello")}";

    if( await canLaunch(whatsappURl_android)){
      await launch(whatsappURl_android);
    }else{
      ScaffoldMessenger.of(context ).showSnackBar(
          SnackBar(content: new Text("whatsapp not installed")));

    }


  }
  static void  openteligram() async {
    final String groupLink = "https://t.me/ColorWinzo"; // Replace with your Telegram group link

    if (await canLaunch(groupLink)) {
      await launch(groupLink);
    } else {
      throw "Could not launch $groupLink";
    }
  }


  static void  linkurl() async {
    const url = 'https://www.geeksforgeeks.org/';
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true, enableJavaScript: true);
    } else {
      throw 'Could not launch $url';
    }
  }
}