// import 'package:survey/controllers/change_password_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class ChangePassword extends StatelessWidget {
//   final ChangePasswordController controller = Get.put(
//       ChangePasswordController());
//
//   ChangePassword({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//             'change_password'.tr, style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.blue[800],
//         iconTheme: IconThemeData(color: Colors.white),
//         centerTitle: true,
//       ),
//       body: SafeArea(child:
//       Container(
//         margin: EdgeInsets.all(18.0),
//         child: Form(
//           key: controller.formField,
//           child: Column(
//             children: [
//               controller.error.isNotEmpty?
//               Container(
//                 padding: EdgeInsets.symmetric(vertical: 8,horizontal: 6),
//                 margin: EdgeInsets.only(bottom: 30,top: 10),
//                 decoration: BoxDecoration(
//                   color: Colors.red[800],
//                   borderRadius: BorderRadius.all(Radius.circular(6)),
//                 ),
//                 child: Align(
//                   alignment: Alignment.center,
//                   child: Text(controller.error.value, style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 14,
//                   ),),
//                 ),
//               )
//                   :SizedBox(height: 30),
//               TextFormField(
//                 controller: controller.oldPassword,
//                 keyboardType: TextInputType.text,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "${'old_password'.tr} ${'required'.tr}";
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                     labelText: 'old_password'.tr,
//                     floatingLabelStyle: TextStyle(color: Colors
//                         .blue[800]),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.blue[800]!,
//                           width: 2.0),
//                     ),
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.person, color: Colors
//                         .blue[800],)
//                 ),
//               ),
//               SizedBox(height: 35.0),
//               TextFormField(
//                 controller: controller.newPassword,
//                 keyboardType: TextInputType.text,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "${'new_password'.tr} ${'required'.tr}";
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                     labelText: 'new_password'.tr,
//                     floatingLabelStyle: TextStyle(color: Colors
//                         .blue[800]),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.blue[800]!,
//                           width: 2.0),
//                     ),
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.person, color: Colors
//                         .blue[800],)
//                 ),
//               ),
//               SizedBox(height: 35.0),
//               TextFormField(
//                 controller: controller.confirmPassword,
//                 keyboardType: TextInputType.text,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return "${'confirm_password'.tr} ${'required'.tr}";
//                   }
//                   if (value != controller.newPassword.text) {
//                     return "${'new_password'.tr} ${'not_match'.tr}";
//                   }
//                   return null;
//                 },
//                 decoration: InputDecoration(
//                     labelText: 'confirm_password'.tr,
//                     floatingLabelStyle: TextStyle(color: Colors
//                         .blue[800]),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide: BorderSide(color: Colors.blue[800]!,
//                           width: 2.0),
//                     ),
//                     border: OutlineInputBorder(),
//                     prefixIcon: Icon(Icons.person, color: Colors
//                         .blue[800],)
//                 ),
//               ),
//               SizedBox(height: 35.0),
//               SizedBox(
//                 width: double.infinity,
//                 child: Obx(() {
//                   return ElevatedButton(
//                     onPressed: controller.isLoading.value ? null : controller.change,
//                     style: ElevatedButton.styleFrom(
//                         padding: EdgeInsets.symmetric(
//                             horizontal: 12, vertical: 15),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(6),
//                         ),
//                         textStyle: TextStyle(fontSize: 18),
//                         backgroundColor: Colors.blue[800]
//                     ),
//                     child:
//                     // isLoading.value
//                     //     ? SpinKitWave(
//                     //   color: Colors.blue[800],
//                     //   size: 26.0,
//                     // ):
//                     Text('change_password'.tr, style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold
//                     ),),
//                   );
//                 }),
//               ),
//             ],
//           ),
//         ),
//       )),
//     );
//   }
// }
