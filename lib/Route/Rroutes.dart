import 'package:flutter/material.dart';
import 'package:taxiwala/Drawwer/AboutPage.dart';
import 'package:taxiwala/Drawwer/AboutPrivecy.dart';
import 'package:taxiwala/Drawwer/AboutSowftware.dart';
import 'package:taxiwala/Drawwer/AboutTerm.dart';
import 'package:taxiwala/Drawwer/drawer_page.dart';
import 'package:taxiwala/Drawwer/DriverRelated.dart';
import 'package:taxiwala/Drawwer/EditDrawerPage.dart';
import 'package:taxiwala/Drawwer/Menu.dart';
import 'package:taxiwala/Drawwer/Myrides.dart';
import 'package:taxiwala/Drawwer/Myridesinfo.dart';
import 'package:taxiwala/Drawwer/Notification.dart';
import 'package:taxiwala/Drawwer/Payment.dart';
import 'package:taxiwala/Drawwer/SettingFavoutrites.dart';
import 'package:taxiwala/Drawwer/SettingLanguage.dart';
import 'package:taxiwala/Drawwer/SettingPage.dart';
import 'package:taxiwala/Drawwer/SetttingPreference.dart';
import 'package:taxiwala/Drawwer/Support%20home.dart';
import 'package:taxiwala/Drawwer/Supportguide.dart';
import 'package:taxiwala/Drawwer/Supportmypickup.dart';
import 'package:taxiwala/Drawwer/Supportpayment.dart';
import 'package:taxiwala/HomeDirectory/homepage.dart';
import 'package:taxiwala/InCity/Booking.dart';
import 'package:taxiwala/InCity/Canccellation.dart';
import 'package:taxiwala/InCity/save_location.dart';
import 'package:taxiwala/InCity/DriverChat.dart';
import 'package:taxiwala/InCity/Paymentincity.dart';
import 'package:taxiwala/InCity/PickupLocation.dart';
import 'package:taxiwala/InCity/Ride%20review.dart';
import 'package:taxiwala/InCity/Ride%20searching.dart';
import 'package:taxiwala/InCity/RideConfirmation.dart';
import 'package:taxiwala/InCity/Support.dart';
import 'package:taxiwala/InCity/confiurm_location.dart';
import 'package:taxiwala/LoginDirectory/Location.dart';
import 'package:taxiwala/LoginDirectory/Login.dart';
import 'package:taxiwala/LoginDirectory/SignupPage.dart';
import 'package:taxiwala/LoginDirectory/Verification.dart';
import 'package:taxiwala/LoginDirectory/Welcome%20screen.dart';
import 'package:taxiwala/OnBordingDirectory/OnbordingScreen.dart';
import 'package:taxiwala/Route/RouteNames.dart';
import 'package:taxiwala/SelfDriving/Billingpage.dart';
import 'package:taxiwala/SelfDriving/DocumentUploadingPage.dart';
import 'package:taxiwala/SelfDriving/Driverlocation.dart';
import 'package:taxiwala/SelfDriving/OTPpage.dart';
import 'package:taxiwala/SelfDriving/RideSummary.dart';
import 'package:taxiwala/SelfDriving/selfdriving.dart';
import 'package:taxiwala/SelfDriving/test.dart';


class Routers {
  static final Map<String, WidgetBuilder> routes = {
    RoutesName.splash: (context) => const Welcome_screen(),
    RoutesName.Onbording: (context) => OnBoardingScreen(),
    RoutesName.LoginPage: (context) => const Login(),
    RoutesName.Verification: (context) => const Verification_page(),
    RoutesName.SignupPage: (context) => const SignupPage(),
    RoutesName.TurnOnLoccation: (context) => const TurnOnLoccation(),
    RoutesName.Homepage: (context) => const HomeScreen(),
    RoutesName.drawerpage: (context) => const DrawerPage(),
    RoutesName.EditProfile: (context) => const EditProfile(),
    RoutesName.Menu: (context) => const Menu(),
    RoutesName.Myrides: (context) => const Myrides(),
    RoutesName.myridesinfo: (context) => const myridesinfo(),
    RoutesName.Payment: (context) => const Payment(),
    RoutesName.notificationDrwaer: (context) => const notificationDrwaer(),
    RoutesName.Settingpage: (context) => const Settingpage(),
    RoutesName.sopporthome: (context) => const sopporthome(),
    RoutesName.Aboutpage: (context) => const Aboutpage(),
    RoutesName.SettingFavoutrites: (context) => const SettingFavoutrites(),
    // RoutesName.SettingCustomer: (context) => SettingCustomer(),
    RoutesName.SettingLanguage: (context) => const SettingLanguage(),
    RoutesName.SettingPrefference: (context) => const SettingPrefference(),
    RoutesName.selfdriving: (context) => const selfdriving(),
    RoutesName.Billingpage: (context) => const Billingpage(),
    RoutesName.DocumentPage: (context) => const DocumentPage(),
    RoutesName.driverLocation: (context) => const driverLocation(),
    RoutesName.OTPpages: (context) => const OTPpages(),
    RoutesName.RideSummary: (context) => const RideSummary(),
    RoutesName.PickupLocation: (context) => const PickupLocation(),
    RoutesName.Bokking: (context) => const Bokking(),
    RoutesName.PaymentIncity: (context) => const PaymentIncity(),
    RoutesName.RideSearching: (context) => const RideSearching(),
    RoutesName.RideConfirmation: (context) => const RideConfirmation(),
    RoutesName.Cancellation: (context) => const Cancellation(),
    RoutesName.Driverchat: (context) => Driverchat(),
    RoutesName.SupportIncity: (context) => const SupportIncity(),
    RoutesName.Ridereview: (context) => const Ridereview(),
    RoutesName.PaymentRelated: (context) => const PaymentRelated(),
    RoutesName.DriverRelated: (context) => const DriverRelated(),
    RoutesName.SupportGuide: (context) => const SupportGuide(),
    RoutesName.Supportmypickup: (context) => const Supportmypickup(),
    RoutesName.AboutPrivecy: (context) => const AboutPrivecy(),
    RoutesName.AboutTerm: (context) => const AboutTerm(),
    RoutesName.AboutSoftware: (context) => const AboutSoftware(),
    RoutesName.ConfiurmLocation: (context) => const ConfiurmLocation(),
    RoutesName.test: (context) => test(),
    RoutesName.SaveLocation: (context) => const SaveLocation(),
  };
}