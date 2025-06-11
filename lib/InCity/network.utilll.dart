// import 'package:http/http.dart' as http;
//
// class NetworkUtility{
//   static Future<String?> fetchUrl(Uri uri, {Map<String ,String>? headers}) as
//   try {
//     final response = await http.get(uri,headers: header);
//     if(response.statusCode =200){
//       return response.body;
//   }
//   } catch(e) {
//     debugPrint(e.toString());
//   }
//   returun null;
// }