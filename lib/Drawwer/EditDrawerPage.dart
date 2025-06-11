import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:taxiwala/Constant/Constant_textfield/CustomTextField.dart';
import 'package:taxiwala/Constant/CustomButton/smallButton.dart';
import 'package:taxiwala/Constant/Theme/ConstantColor.dart';
import 'package:taxiwala/Constant/fontstyle.dart';
import 'package:taxiwala/res/provider/profile_provider.dart';
import 'package:taxiwala/res/provider/updateProfile_provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController name =TextEditingController();
  TextEditingController email =TextEditingController();
  TextEditingController phone =TextEditingController();
  TextEditingController dob =TextEditingController();
  String? selectedValue;
  List<Map<String, dynamic>> dropdownItems = [
    {'name': 'Male'},
    {'name': 'Female'},
    {'name': 'Other'},
  ];
  @override
  void initState() {
    super.initState();
    final profileProvider = Provider.of<ProfileProvider>(context,listen: false).profileResponse;
    name.text=profileProvider?.firstname.toString()??'';
    email.text=profileProvider?.email.toString()??'';
    phone.text = profileProvider?.phone.toString() ?? '';
    dob.text=profileProvider?.dob==null?'Select Dob':profileProvider?.dob.toString()??'Select DOb';
    final gender = profileProvider?.gender.toString() ?? '';
    if (dropdownItems.any((item) => item['name'] == gender)) {
      selectedValue = gender;
    } else {
      selectedValue = 'Male';
    }
  }
  @override
  Widget build(BuildContext context) {
    final updateProfile = Provider.of<UpdateProfile>(context);
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height*0.1),
        child: AppBar(
          centerTitle: true,
          title: Text('My Profile',
            style: robotoBlackProfile,
          ),
        ),
      ),
        body: ListView(
         children: [
          Container(
            height: height*01.035,
            width: MediaQuery.of(context).size.width,
            color: ColorConstant.WHITE_BACKGROUND,
            child:Column(
             children: [
               SizedBox(height: height*0.015,),
               Card(
                 color: ColorConstant.WHITE_COL0R,
                 child: SizedBox(
                   height: height*0.13,
                   width: width*0.95,
                   child: Column(
                     children: [
                       SizedBox(
                         height: height*0.05,
                         child: Padding(
                           padding:EdgeInsets.only(right:width*0.55),
                           child: Text(' Username',style: robotoRegularBlack),
                         ),
                       ),
                       Constant_text_field(
                         controller: name,
                         keyboardType: TextInputType.name,
                         hintText: 'Name',
                         filled: true,
                         validator: Validate_Name,
                         width: width*0.9,
                         height: height*0.07,
                         fillColor: Colors.grey[300],
                       ),
                     ],
                   ),
                 )
               ),
               Card(
                   color: ColorConstant.WHITE_COL0R,
                   child:SizedBox(
                     height: height*0.13,
                     width: width*0.95,
                     child: Column(
                       children: [
                         SizedBox(
                           height: 40,
                           child: Padding(
                             padding: const EdgeInsets.only(right: 240),
                             child: Text('  Gender',style:robotoRegularBlack,),
                           ),
                         ),
                         Container(
                           height: height*0.06,
                           width: width*0.9,
                           decoration: BoxDecoration(
                               color: ColorConstant.WHITE_BACKGROUND,
                               border: Border.all(
                                   color: ColorConstant.Black_COLOR, width: 1),
                               borderRadius: BorderRadius.circular(10)),
                           child: DropdownButtonHideUnderline(
                             child: DropdownButton(
                               dropdownColor: ColorConstant.WHITE_COL0R,
                               hint: const Text("  Gender", style: robotoGreybold),
                               value: selectedValue,
                               onChanged: (String? newValue) {
                                 setState(() {
                                   selectedValue = newValue;
                                 });
                                 if (kDebugMode) {
                                   print(selectedValue);
                                 }
                               },
                               items: dropdownItems
                                   .map<DropdownMenuItem<String>>((item) {
                                 return DropdownMenuItem<String>(
                                   value: item['name'],
                                   child: Center(
                                     child: Text("    " + item['name'],
                                         style: robotoRegular.copyWith(
                                             fontSize: width * 0.04,
                                             color: ColorConstant.Black_COLOR)),
                                   ),
                                 );
                               }).toList(),
                             ),
                           ),
                         ),
                       ],
                     ),
                   )
               ),
               Card(
                 color: ColorConstant.WHITE_COL0R,
                 child:SizedBox(
                   height: height*0.13,
                   width: width*0.95,
                   child: Column(
                     children: [
                       SizedBox(
                         height: 40,
                         child: Padding(
                           padding: const EdgeInsets.only(right: 250),
                           child: Text('  E-mail',style:robotoRegularBlack,),
                         ),
                       ),
                       Constant_text_field(
                         controller: email,
                         keyboardType: TextInputType.emailAddress,
                         hintText: 'email',
                         filled: true,
                         validator: Validate_email,
                         height: height*0.07,
                         width: width*0.9,
                         fillColor: Colors.grey[300],
                       ),
                     ],
                   ),
                 )
               ),
               Card(
                 color: ColorConstant.WHITE_COL0R,
                 child:SizedBox(
                   height: height*0.13,
                   width: width*0.95,
                   child: Column(
                     children: [
                       SizedBox(
                         height: 40,
                         child: Padding(
                           padding: const EdgeInsets.only(right: 210),
                           child: Text('  Phone no',style:robotoRegularBlack,),
                         ),
                       ),
                       Constant_text_field(
                         enabled: false,
                         controller: phone,
                         keyboardType: TextInputType.number,
                         hintText: '+91',
                         filled: true,
                         validator: Validate_Number,
                         height: height*0.07,
                         width:width*0.9,
                         fillColor: Colors.grey[300],
                       ),
                     ],
                   ),
                 ),
               ),
               Card(
                 color: ColorConstant.WHITE_COL0R,
                 child:SizedBox(
                   height: height*0.13,
                   width: width*0.95,
                   child: Column(
                     children: [
                       SizedBox(
                         height: 40,
                         child: Padding(
                           padding: const EdgeInsets.only(right: 265),
                           child: Text('  Dob',style:robotoRegularBlack,),
                         ),
                       ),
                       InkWell(
                         onTap: ()async {
                           final DateTime? pickedDate = await showDatePicker(
                             context: context,
                             initialDate: DateTime.now(),
                             firstDate: DateTime(1900),
                             lastDate: DateTime(2100),
                             initialDatePickerMode: DatePickerMode.day,
                             initialEntryMode: DatePickerEntryMode.calendar,
                           );
                           if (pickedDate != null) {
                             final DateTime dateOnly = DateTime(pickedDate.year, pickedDate.month, pickedDate.day);
                             final String formattedDate = DateFormat('dd-MM-yyyy').format(dateOnly);
                             dob.text = formattedDate;
                           }
                         },
                         child: Constant_text_field(
                           enabled: false,
                           controller: dob,
                           keyboardType: TextInputType.name,
                           hintText: 'Dob',
                           filled: true,
                           validator: Validate_Dob,
                           height: height*0.07,
                           width:width*0.9,
                           fillColor: Colors.grey[300],
                         ),
                       ),
                     ],
                   ),
                 ),
               ),
               SizedBox(height:height*0.02,),
               Container(
                 height: height*0.07,
                 width: width*0.95,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  color: Colors.amber[100],
                ),
                 child: Row(
                   children: [
                     SizedBox(
                       height: height*0.07,
                       width: width*0.08,
                       child: const Icon(Icons.warning,color: Colors.amber,),
                     ),
                     RichText(
                       text: const TextSpan(
                         text: "   Note: ",
                         style:   robotoBold,
                         children: <TextSpan>[
                           TextSpan(
                             text: 'Phone number\'s cant\t be edited. \n   Contact support',
                             style:robotoBlack,
                           ),

                         ],
                       ),

                     ),
                   ],
                 ),
               ),
               SizedBox(height: height*0.02),
               Container(
                 height: height*0.05,
                 width: width*0.95,
                 decoration: const BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(10)),
                   color: ColorConstant.Black_COLOR,
                 ),
                 child: const Center(child: Text('Contact Support',style: TextStyle(fontSize: 18,color: ColorConstant.WHITE_COL0R))),
               ),
               const Spacer(),
               ColorButton(onTap: () {
                 updateProfile.editProfile(context, name.text, email.text, phone.text, selectedValue.toString(), dob.text);
               }, text: 'Save', btnColor: ColorConstant.Black_COLOR, textColor: null, ),

           SizedBox(height: height*0.05,),
             ],
            ),
          ),
         ],
        ),
      ),
    );
  }
  String? Validate_Name(String? value) {
    if (value!.length < 3) {
      return 'Name must be more than 2 character';
    } else {
      return null;
    }
  }
  String? Validate_email(String? value) {
    if (value!.length < 3) {
      return 'Name must be more than 2 character';
    } else {
      return null;
    }
  }
  String? Validate_Dob(String? value) {
    if (value!.length < 3) {
      return 'Name must be more than 2 character';
    } else {
      return null;
    }
  }
  String? Validate_Number(String? value) {
    if (value!.length < 3) {
      return 'Name must be more than 2 character';
    } else {
      return null;
    }
  }
}
