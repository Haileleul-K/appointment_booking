import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:ticket_with_bloc/core/colors.dart';
import 'package:ticket_with_bloc/features/auth/bloc/auth_bloc.dart';
import 'package:ticket_with_bloc/routes.dart';

import '../../core/custom_dialog.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  AuthBloc? authBloc;
  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    super.initState();
  }

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
          customDialog(() {
            Navigator.pop(context);
          }, 'Sorry', '${state.errorMessage.error}  ${state.errorMessage.message}' , 'try Again', context);
        } else if (state is LoginSuccess) {
          EasyLoading.dismiss();
          Navigator.pushNamed(context, Paths.navigation);
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(200))),
            backgroundColor: AppColors.secondaryAppColor,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(size.height * 0.3),
              child: Image.asset(
                'assets/images/logo.png',
                height: size.height * 0.3,
                fit: BoxFit.cover,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 20, right: 20),
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
                SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: _emailController,
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'E-mail',
                    // prefixIcon: Icon(Icons.visibility_off)
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Password',
                    // prefixIcon: Icon(Icons.visibility_off)
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(185, 20),
                    ),
                    onPressed: () {
                      authBloc!.add(LoginEvent(
                          email: _emailController.text,
                          password: _passwordController.text));
                    },
                    child: Text('Login')),
              ],
            ),
          )),
    );
  }
}
