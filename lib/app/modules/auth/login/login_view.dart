import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:patroleum_dashboard/core/app_colors.dart';
import 'package:patroleum_dashboard/core/singleton/responsive_singleton.dart';
import 'package:patroleum_dashboard/data/local/session_cubit/session_cubit.dart';
import 'package:patroleum_dashboard/widgets/button_widget.dart';
import 'package:patroleum_dashboard/widgets/textfield.dart';


class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isLoading = false;
  bool _obscurePassword = true;

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
      });
      final sessionCubit = context.read<SessionCubit>();
      await sessionCubit.logIn(_emailController.text, _passwordController.text);
      setState(() {
        isLoading = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                    'assets/images/patroleum.png',
                    width: ResponsiveSingleton.heightCustom( 0.5 ),
                    // height: ResponsiveSingleton.heightCustom( 0.7 ),
                  ),
                ),
        
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: ResponsiveSingleton.widthCustom( 0.5 ),
                        child: TextFormFieldBuilder(
                          fieldType: FieldType.email,
                          controller: _emailController,
                          label: 'Email',
                          labelFontWeight: FontWeight.w400,
                          hintText: 'Enter email here',
                          validator: (val) {
                            String p =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regExp = RegExp(p);
                            if ((val ?? '').isEmpty) {
                              return "Email field is required";
                            } else if (!regExp.hasMatch(val!)) {
                              return "Invalid Email";
                            } else {
                              return null;
                            }
                          },
                          enabled: !isLoading,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: ResponsiveSingleton.widthCustom( 0.5 ),
                        child: TextFormFieldBuilder(
                          fieldType: FieldType.password,
                          controller: _passwordController,
                          label: 'Password',
                          labelFontWeight: FontWeight.w400,
                          hintText: 'Enter password here',
                          obscureText: _obscurePassword,
                          validator: (val) {
                            String p =
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                            RegExp regExp = RegExp(p);
                            if ((val ?? '').isEmpty) {
                              return "Email field is required";
                            } else if (!regExp.hasMatch(val!)) {
                              return "Invalid Email";
                            } else {
                              return null;
                            }
                          },
                          enabled: !isLoading,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: ResponsiveSingleton.heightCustom( 0.1 ),
                      ),
                      SizedBox(
                        width: ResponsiveSingleton.widthCustom(0.5),
                        height: 54,
                        child: ButtonBuilder(
                          buttonType: ButtonType.flat,
                          onPressed: isLoading ? null : _login,
                          label: 'Login',
                          fontSize: 16,
                          backgroundColor: AppColors.loginAccountColor,
                        ),
                      ),
        
                    ],
                  ),
                ),
            ],
          ),
        ),

        if (isLoading)
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(),
          ),

      ],
    );
  }
}