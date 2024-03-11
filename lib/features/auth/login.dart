import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:logger/logger.dart';
import 'package:ticket_with_bloc/core/colors.dart';
import 'package:ticket_with_bloc/core/common.dart';
import 'package:ticket_with_bloc/features/auth/bloc/auth_bloc.dart';
import 'package:ticket_with_bloc/routes.dart';

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
  AuthBloc? authBloc;
  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
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
          EasyLoading.dismiss();
          Navigator.pushNamed(context, Paths.navigation);
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
                    // validator: (value) => Utils.validator(value: value ?? '', type: 'email'),
                      controller: _userIDController,
                      obscureText: false,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        hintText: 'ID',
                        // prefixIcon: Icon(Icons.visibility_off)
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // TextFormField(
                    //   validator: (value) => Utils.validator(value: value ?? '', type: 'password'),
                    //   controller: _passwordController,
                    //   obscureText: true,
                    //   decoration: InputDecoration(
                    //     border: OutlineInputBorder(
                    //         borderRadius: BorderRadius.circular(10)),
                    //     hintText: 'Password',
                    //     // prefixIcon: Icon(Icons.visibility_off)
                    //   ),
                    // ),
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
                          if (_formKey.currentState!.validate())   { authBloc!.add(LoginEvent(
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
}
