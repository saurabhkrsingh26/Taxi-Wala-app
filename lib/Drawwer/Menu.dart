import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiwala/Constant/CustomButton/smallButton.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/assetsConstant.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/Route/RouteNames.dart';
import 'package:taxiwala/res/provider/userViewProvider.dart';
import '../res/provider/profile_provider.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  ProfileProvider profileProvider=ProfileProvider();
  @override
  void initState() {
    profileProvider.userProfile(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context).profileResponse;
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    print(profileProvider?.id.toString());
    print("hhu");

    return SafeArea(child: Scaffold(
      body: Column(
        children: [
         InkWell(
           onTap: (){
             Navigator.pushNamed(context, RoutesName.drawerpage);
           },
           child:  Container(
             height: height*0.15,
             width: MediaQuery.of(context).size.width,
             color: ColorConstant.Black_COLOR,
             child: ListTile(
               leading: Container(
                 height: height*0.2,
                 width: width*0.2,
                 decoration: const BoxDecoration(
                     color: ColorConstant.WHITE_COL0R,
                     shape: BoxShape.circle,
                     image: DecorationImage(
                       image: AssetImage(Images.girl),
                     )
                 ),
               ),
               title:  Text(profileProvider?.firstname.toString()??'Edrin Rodger',style: robotoMediumExtraWhite.copyWith(overflow: TextOverflow.ellipsis)),
               subtitle:  Text(profileProvider?.phone.toString() ?? '',
                 style: robotoMediumExtraWhite,
               ),
               trailing: InkWell(
                 onTap: (){
                  Navigator.pop(context,RoutesName.Homepage);
                 },
                 child: SizedBox(
                   height: height*0.1,
                   width: width*0.15,
                   child: Icon(Icons.close,size: width*0.1,color: ColorConstant.WHITE_COL0R,),
                 ),
               ),
             ),
           ),
         ),
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, RoutesName.Myrides);
          },
          child:   SizedBox(
            height: height*0.1,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(right: width*0.6),
                child: Text('My rides',
                  style: robotoRegularBlack,
                ),
              ),
            ),
          ),
        ),
          InkWell(
            onTap: (){
              Navigator.pushNamed(context, RoutesName.Payment);
            },
            child: SizedBox(
              height: height*0.1,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(right: width*0.6),
                  child: Text('Payment',
                    style: robotoRegularBlack,
                  ),
                ),
              ),
            ),
          ),
         InkWell(
           onTap: (){
             Navigator.pushNamed(context, RoutesName.notificationDrwaer);
           },
           child:  SizedBox(
             height: height*0.1,
             child: Center(
               child: Padding(
                 padding: EdgeInsets.only(right: width*0.5),
                 child: Text('Notification',
                   style: robotoRegularBlack,
                 ),
               ),
             ),
           ),
         ),
         InkWell(
           onTap: (){
             Navigator.pushNamed(context, RoutesName.Settingpage);
           },
           child:  SizedBox(
             height: height*0.1,
             child: Center(
               child: Padding(
                 padding: EdgeInsets.only(right: width*0.6),
                 child: Text('Settings',
                   style: robotoRegularBlack,
                 ),
               ),
             ),
           ),
         ),
         InkWell(
           onTap: (){
             Navigator.pushNamed(context, RoutesName.sopporthome);
           },
           child:  SizedBox(
             height: height*0.1,
             child: Center(
               child: Padding(
                 padding: EdgeInsets.only(right: width*0.6),
                 child: Text('Support',
                   style: robotoRegularBlack,
                 ),
               ),
             ),
           ),
         ),
        InkWell(
          onTap: (){
            Navigator.pushNamed(context, RoutesName.Aboutpage);
          },
          child:   SizedBox(
            height: height*0.1,
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(right: width*0.6),
                child: Text('About',
                  style: robotoRegularBlack,
                ),
              ),
            ),
          ),
        ),
          ColorButton(onTap: () async {
            final userPref = Provider.of<UserViewProvider>(context, listen: false);
            userPref.remove();
            Navigator.pushReplacementNamed(context, RoutesName.LoginPage);
          }, text: 'Logout', btnColor: ColorConstant.Black_COLOR, textColor: null,),
          SizedBox(height: height*0.03,),
        ],
      ),
    ));
  }
}
