import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxiwala/Constant/CustomButton/smallButton.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/assetsConstant.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/Route/RouteNames.dart';
import 'package:taxiwala/res/provider/profile_provider.dart';
import 'package:taxiwala/res/provider/userViewProvider.dart';


class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  //
  // ProfileProvider profileProvider=ProfileProvider();

 // Future<void>  getProfile() async {
 //   try{
 //     final profileData= await profileProvider.userProfile();
 //     if(profileData !=null){
 //       Provider.of<ProfileProvider>(context,listen: false).setProfileData(profileData);
 //     }
 //   } catch (e){
 //     // handle error
 //   }
 // }

  @override
  void initState() {
    super.initState();
    // getProfile();
    // profileProvider.userProfile(context);
  }
  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context).profileResponse;
    // print(profileProvider?.id.toString());
    // print("kkkkkkkkk");
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
              centerTitle: true,
              title: Text('My profile',style: robotoBlackProfile)),
          body:Column(
            children: [
              Container(
                height: height*0.18,
                width: MediaQuery.of(context).size.width,
                color: ColorConstant.Black_COLOR,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: width*0.03),
                      child: Container(
                        height: height*0.1,
                        width: width*0.2,
                        decoration: BoxDecoration(
                            border: Border.all(width: width*0.01,color: Colors.lightBlueAccent),
                            image: const DecorationImage(
                              image: AssetImage(Images.girl),
                            ),
                            shape: BoxShape.circle,
                            color: ColorConstant.WHITE_COL0R
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height*0.1,
                      width: width*0.5,
                      child: Column(

                            children: [
                              Text(
                                profileProvider?.firstname.toString()??'',
                                style:robotoWhite.copyWith(overflow: TextOverflow.ellipsis),
                              ),
                              Text(profileProvider?.phone.toString() ?? '',
                                style: robotoMediumExtraWhite,
                              ),
                            ],


                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, RoutesName.EditProfile);
                      },
                      child:  Padding(
                        padding: EdgeInsets.only(right: width*0.04,top: height*0.07),
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundColor: ColorConstant.WHITE_COL0R,
                          child: Icon(Icons.edit,color: ColorConstant.Black_COLOR,size:30 ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
               ListTile(
                leading: const CircleAvatar(
                  radius: 40,
                  backgroundColor: ColorConstant.Black_COLOR,
                  child: Icon(Icons.email,size: 25,color: ColorConstant.WHITE_COL0R),
                ),
                title: const Text('Email',style: robotoBold),
                subtitle: Text(profileProvider?.email.toString()??'',style: robotoMedium,),
              ),
              const Divider(),
               ListTile(
                leading: const CircleAvatar(
                  radius: 40,
                  backgroundColor: ColorConstant.Black_COLOR,
                  child: Icon(Icons.person,size: 25,color: ColorConstant.WHITE_COL0R),
                ),
                title: const Text('Gender',style: robotoBold),
                subtitle: Text(profileProvider?.gender==null?'Update gender':profileProvider?.gender.toString()??'',style: robotoMedium),
              ),
              const Divider(),
              ListTile(
                leading: const CircleAvatar(
                  radius: 40,
                  backgroundColor: ColorConstant.Black_COLOR,
                  child: Icon(Icons.calendar_month,size: 25,color: ColorConstant.WHITE_COL0R),
                ),
                title: const Text('Date of Birth',style: robotoBold),
                subtitle: Text(profileProvider?.dob==null?'Update Dob':profileProvider?.dob.toString()??'',style: robotoMedium),
              ),
              const Divider(),
             ListTile(
                leading: const CircleAvatar(
                  radius: 40,
                  backgroundColor: ColorConstant.Black_COLOR,
                  child: Icon(Icons.emoji_people,size: 25,color: ColorConstant.WHITE_COL0R),
                ),
                title: const Text('Member Since',style: robotoBold),
                subtitle: Text(profileProvider?.datetime==null?'Update ':profileProvider?.datetime.toString()??'',style: robotoMedium),
              ),
              const Divider(),
              const ListTile(
                leading: CircleAvatar(
                  radius: 40,
                  backgroundColor: ColorConstant.Black_COLOR,
                  child: Icon(Icons.warning,size: 25,color: ColorConstant.WHITE_COL0R,),
                ),
                title: Text('Emergency Contacts',style: robotoBold),
                subtitle: Text('Edrin12@gmail.com',style: robotoMedium),
              ),
              const Divider(),
              ColorButton(onTap: () async{
                final userPref = Provider.of<UserViewProvider>(context, listen: false);
                userPref.remove();
                Navigator.pushReplacementNamed(
                    context, RoutesName.LoginPage);
              }, text: 'Logout', btnColor: ColorConstant.Black_COLOR, textColor: null,),
              SizedBox(height: height*0.02,),
            ],
          ),
        )
    );
  }
}
