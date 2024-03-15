import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:skylightDemo/core/colors.dart';
import 'package:skylightDemo/core/utils/hive_service.dart';
import 'package:skylightDemo/features/auth/bloc/auth_bloc.dart';
import 'package:skylightDemo/routes.dart';

import '../../core/custom_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _userIDController = TextEditingController();
  //final TextEditingController _emailController = TextEditingController();
 // final TextEditingController _passwordController = TextEditingController();
AuthBloc? authBloc ;
  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    loginUserSaved();
    super.initState();
  }
GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          EasyLoading.show(
            status: 'Loading...',
            dismissOnTap: false,
            maskType: EasyLoadingMaskType.clear,
          );
        }
        if (state is LoginError) {
          EasyLoading.dismiss();
          EasyLoading.showError(state.errorMessage);
        } else if (state is LoginSuccess) {
          HiveService.saveUser((state.userData.clientUserLink!.id!).toString(), state.userData.clientUserLink!.role!);
          EasyLoading.dismiss();
           Navigator.pushReplacementNamed(
    context,Paths.navigation
  ); 
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: true,

          appBar: AppBar(
            automaticallyImplyLeading: false,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(200))),
            backgroundColor: AppColors.secondaryAppColor,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(size.height * 0.3),
              child: Container(
                //'assets/images/logo.png',
               height: size.height * 0.26,
                
              ),
            ),
          ),
          body: SingleChildScrollView(
           physics:const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.only(top: 60.0, left: 20, right: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Wellcome again!',
                      style: TextStyle(
                          color: AppColors.primaryAppColor,
                          fontWeight: FontWeight.w800,
                          fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      validator: (value) {
                        if(value?.isEmpty?? true ){
                          return 'please insert user or admin ID';
                        }
                      },
                      controller: _userIDController,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'ID',
                       ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(160, 50),
                              backgroundColor: AppColors.primaryAppColor
                            ),
                            onPressed: () {
                              String role = 'staff';
                          if (_formKey.currentState!.validate())   {
                             authBloc!.add(LoginEvent(
                             role: role,
                                userID: _userIDController.text.trim()
                                  ));}
                            },
                            child: Text('Login as User')),
                        
                            ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(160, 50),
                              backgroundColor: AppColors.primaryAppColor
                            ),
                            onPressed: () {
                               String role = 'admin';
                             if (_formKey.currentState!.validate())
                             { 
                             authBloc!.add(LoginEvent(
                                role: role,
                                userID: _userIDController.text.trim()
                                  ));
                             }
                            },
                            child: Text('Login as Admin')),
                        
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }


Future<void> loginUserSaved() async {
 String? userId = await HiveService.getUserIdExist();
 String? role =await HiveService.getUserRole();
if(userId!=null) {
  authBloc!.add(LoginEvent(userID: userId, role: role!));
 }
}

}
