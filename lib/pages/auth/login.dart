import 'package:attendance_tracking/data/enums.dart';
import 'package:attendance_tracking/pages/home_page.dart';
import 'package:attendance_tracking/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formField = GlobalKey<FormState>();
  bool _obscureText = true;
  RxBool isLoading = false.obs;
  final _error = "".obs;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _login() async {
    if (_formField.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      _error.value="";
      isLoading.value = true;
      var auth = AuthService();
      Map<String,dynamic> mRes = await auth.login(usernameController.text, passwordController.text);
      print(mRes);
      if(mRes['type'] == MessageType.success){
        _error.value="";
        Get.off(() => HomePage(), preventDuplicates: true);
      }else{
        _error.value=mRes['message']??"Authentication Failed";
      }
      // await Future.delayed(Duration(seconds: 3));
      isLoading.value = false;
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
        body: SafeArea(
            child: Padding(padding: EdgeInsets.symmetric(horizontal: 29),
              child: Obx(() {
                return Form(
                  key: _formField,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.center,
                          child: Image.asset('assets/icons/logo.png')
                      ),
                     _error.isNotEmpty?
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 2,horizontal: 6),
                        margin: EdgeInsets.symmetric(vertical: 1),
                        decoration: BoxDecoration(
                          color: Colors.red[800],
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                        ),
                        child: Align(
                          alignment: Alignment.center,
                          child: Text(_error.value, style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),),
                        ),
                      )
                          :SizedBox(height: 50),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: usernameController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email/Username cannot be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            labelText: "Email/Username",
                            floatingLabelStyle: TextStyle(color: Colors
                                .amber[900]),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber[900]!,
                                  width: 2.0),
                            ),
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person, color: Colors
                                .amber[900],)
                        ),
                      ),
                      SizedBox(height: 40),
                      TextFormField(
                        obscureText: _obscureText,
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password cannot be empty';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "Password",
                          floatingLabelStyle: TextStyle(color: Colors
                              .amber[900]),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.amber[900]!,
                                width: 2.0),
                          ),
                          prefixIcon: Icon(Icons.security, color: Colors
                              .amber[900]),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureText ? Icons.visibility_off : Icons
                                  .visibility,
                              color: Colors.amber[900],
                            ),
                            onPressed: _togglePasswordVisibility,
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading.value ? null : _login,
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 15),
                              textStyle: TextStyle(fontSize: 18),
                              backgroundColor: Colors.amber[900]
                          ),
                          child: isLoading.value
                              ? SpinKitWave(
                            color: Colors.amber[900],
                            size: 26.0,
                          )
                              : Text('LOGIN', style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),),
                        ),
                      ),
                    ],
                  ),
                );
              }),))
    );
  }
}
