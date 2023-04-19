import 'package:alpha_feedback/bloc/auth/auth_bloc.dart';
import 'package:alpha_feedback/bloc/auth/auth_event.dart';
import 'package:alpha_feedback/bloc/auth/auth_state.dart';
import 'package:alpha_feedback/bloc/auth/form_submition_state.dart';
import 'package:alpha_feedback/util/color.dart';
import 'package:alpha_feedback/view/login_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'landing_page.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  // const LoginScreen({Key? key}) : super(key: key);
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  bool loginSelected = false;
  bool showPassword = false;
  bool showConfirmPassword = true;
  String? selectedValue;
  final _userIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AuthBloc _signUpBloc;
  @override
  void initState() {

    super.initState();
    _signUpBloc = AuthBloc();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [secondaryColor, primaryColor])),
          child: Stack(
            children: [
              Positioned(top: 50, left: 100, child: customContainer(100, 100)),
              Positioned(top: 50, right: 70, child: customContainer(150, 150)),
              Positioned(
                top: 130,
                right: 150,
                child: customContainer(100, 100),
              ),
              Positioned(
                bottom: 150,
                right: 150,
                child: customContainer(50, 50),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.only(top: 250),
                child:BlocProvider(
                  create: (context) => _signUpBloc,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      _signInContent(),
                    ],
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
// Beautiful flutter login and registration template screen ui design
  Widget customContainer(height, width) {
    return Container(
      height: double.parse(height.toString()),
      width: double.parse(width.toString()),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: [primaryColor, secondaryColor])),
    );
  }
  Widget confirmPasswordField() {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60).copyWith(top: 12),
            child: TextField(
              obscureText: showConfirmPassword ? false : true,
              style: TextStyle(color: Colors.white70, fontSize: 14),
              decoration: InputDecoration(
                  prefixIconConstraints: BoxConstraints(minWidth: 24),
                  suffixIconConstraints: BoxConstraints(minWidth: 24),
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.lock,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showConfirmPassword = !showConfirmPassword;
                        });
                      },
                      child: Icon(
                        showConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.white70,
                        size: 20,
                      ),
                    ),
                  ),
                  hintText: 'Confirm password',
                  hintStyle: TextStyle(color: Colors.white60, fontSize: 14),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white60, width: .4)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white70, width: .4))),
            ));
      }
    );
  }
  Widget emailField() {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: TextFormField(
            validator: (value) {

              if(value!.isEmpty){
                return  "Email  is required";
              }
              else {
                String email=value.trim();
                return EmailValidator.validate(email)?null:'email Format is not correct';
              }
            },
            controller:_userIdController,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
            decoration: const InputDecoration(
                prefixIconConstraints: BoxConstraints(minWidth: 24),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.email,
                    color: Colors.white70,
                    size: 20,
                  ),
                ),
                hintText: 'Enter email',
                hintStyle: TextStyle(color: Colors.white60, fontSize: 14),
                enabledBorder: UnderlineInputBorder(
                    borderSide:BorderSide(color: Colors.white60, width: .4)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70, width: .4))),
          ));
    }
    );
  }
  Widget passwordField() {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60).copyWith(top: 12),
          child: TextFormField(
            validator: (value) =>  value!.isNotEmpty ? null : 'Field is required',
            controller:_passwordController,
            obscureText: showPassword ? false : true,
            style: const TextStyle(color: Colors.white70, fontSize: 14),
            decoration: InputDecoration(
                prefixIconConstraints: const BoxConstraints(minWidth: 24),
                suffixIconConstraints: BoxConstraints(minWidth: 24),
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.lock,
                    color: Colors.white70,
                    size: 20,
                  ),
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    child: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white70,
                      size: 20,
                    ),
                  ),
                ),
                hintText: 'Enter password',
                hintStyle: TextStyle(color: Colors.white60, fontSize: 14),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white60, width: .4)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white70, width: .4))),
          ));
    }
    );
  }

  Widget button() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: 60).copyWith(bottom: 15),
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                offset: Offset(3, 3),
                blurRadius: 4,
                spreadRadius: 1,
                color: Colors.black12.withOpacity(.08))
          ],
          borderRadius: BorderRadius.circular(50)
              .copyWith(topRight: Radius.circular(0)),
          gradient: LinearGradient(colors: [
            primaryColor,
            secondaryColor,
          ])),
      child: const Text(
        'Register',
        style: TextStyle(
            color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w700),
      ),
    );
  }

  Widget _signupButton() {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      return state.authState is FormSubmitting
          ?Column(
        children:[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:   const <Widget>[
              CircularProgressIndicator(),
              Text( "On progress please wait"),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              width: double.infinity,
              child:button()
          ),

        ],
      )
          :  SizedBox(
          width: double.infinity,
          child:GestureDetector(
            onTap: () {
              print("register clicked");
              if ( _formKey.currentState!.validate()) {
                context.read<AuthBloc>().add(RegisterEvent(
                    userId: _userIdController.text,
                    password: _passwordController.text, confirmPassword: ''));
              }
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: 60).copyWith(bottom: 15),
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(3, 3),
                        blurRadius: 4,
                        spreadRadius: 1,
                        color: Colors.black12.withOpacity(.08))
                  ],
                  borderRadius: BorderRadius.circular(50)
                      .copyWith(topRight: Radius.circular(0)),
                  gradient: LinearGradient(colors: [
                    primaryColor,
                    secondaryColor,
                  ])
              ),
              child: const Text(
                'Register',
                style: TextStyle(
                    color: Colors.white70, fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ),
          )
      );
    });
  }

  Widget _signInContent( ) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          final formStatus = state.authState;
          if (formStatus is SubmissionFailed) {
            _showSnackBar(context, formStatus.exception.toString());
          }
          if (formStatus is SubmissionSuccess) {
            // Navigator.of(context).pushNamed(AppRoute.confirmationCode);
            // _showSnackBarSucc(context, "Customer Successfully Registered you get verification code in short");

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) =>  LoginScreen()),
            );
          }

        },
        child:Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              emailField(),
              passwordField(),
              confirmPasswordField(),
            SizedBox(height:10),
              _signupButton(),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      gradient: LinearGradient(
                          colors: [primaryColor, secondaryColor])),
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(100),
                                gradient: LinearGradient(colors: [
                                  primaryColor,
                                  secondaryColor
                                ])),
                            // child: Text(
                            //   'Login',
                            //   style: TextStyle(
                            //       color: Colors.white,
                            //       fontSize: 12,
                            //       fontWeight: FontWeight.w500),
                            // ),
                          )),
                      Expanded(
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) =>  LoginScreen()),
                                );
                                // setState(() {
                                //
                                // });
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          )
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        )

    );
  }

  void _showSnackBar(BuildContext context, String message) {
    String error = message.replaceAll('Exception:', '');
    final snackBar = SnackBar(
      content: Text(error),
      backgroundColor: Colors.deepOrange,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  void _showSnackBarSucc(BuildContext context, String message) {
    String error = message.replaceAll('Exception:', '');
    final snackBar = SnackBar(
      content: Text(error),
      backgroundColor: Colors.green,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}