import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:homeservice/core/localdisk.repo.dart/disk.repo.dart';
import 'package:homeservice/logic/counter/counter_cubit.dart';
import 'package:homeservice/onboarding/register.dart';
import 'package:homeservice/pages/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homeservice/router/router.gr.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

TextEditingController _passwordlogin = TextEditingController();
TextEditingController _emaillogin = TextEditingController();

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formkey = GlobalKey<FormState>();
  checkkey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('statuscode')) {
      prefs.remove('statuscode');
    }
    if (prefs.containsKey('jwt')) {
      context.router.push(HomeRoute());
    }
  }

  void clear() {
    _emaillogin.clear();
    _passwordlogin.clear();
  }

  @override
  void initState() {
    super.initState;
    checkkey();
  }

  void _onLoading() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.all(8),
            child: const LinearProgressIndicator(
              backgroundColor: Colors.orangeAccent,
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ));
      },
    );
    await context
        .read<CounterCubit>()
        .LoginData(_emaillogin.text, _passwordlogin.text);
    getdata();
    Future.delayed(Duration(seconds: 5));
    Navigator.pop(context);
  }

  getdata() async {
    int status = await DiskRepo().retrieve2();
    if (status == 200) {
      context.read<CounterCubit>().showToast2();
      context.router.push(const HomeRoute());
    } else {
      context.read<CounterCubit>().showToast1();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                color: Colors.blue[200],
                alignment: Alignment.center,
                child: Column(
                  children: const [
                    SizedBox(
                      height: 30,
                    ),
                    CircleAvatar(
                      maxRadius: 50,
                      child: Icon(
                        Icons.home_work_outlined,
                        size: 40,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("HOME SERVICES PROVIDER"),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                )),
            Container(
              decoration: const BoxDecoration(
                  // color: Colors.orange,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(70),
                      topRight: Radius.circular(70),
                      bottomLeft: Radius.circular(70),
                      bottomRight: Radius.circular(70))),
              child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 70, right: 70),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email is required';
                            }
                            if (!RegExp(
                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                                .hasMatch(value)) {
                              return "Please Enter a Valid Email Address";
                            }
                          },
                          controller: _emaillogin,
                          decoration: const InputDecoration(
                              labelText: "Email",
                              icon: Icon(Icons.mobile_friendly)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 70, right: 70),
                        child: TextFormField(
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                          },
                          controller: _passwordlogin,
                          decoration: const InputDecoration(
                              labelText: "Password", icon: Icon(Icons.lock)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
                onPressed: (() async {
                  if (_formkey.currentState!.validate()) {
                    _onLoading();
                    log(_emaillogin.text);
                    log(_passwordlogin.text);
                  } else {
                    print('INVALID USERNAME OR PASSWORD');
                  }
                }),
                child: Text("Login")),
            SizedBox(
              height: 60,
            ),
            ElevatedButton(
                onPressed: () {
                  context.router.push(RegisterRoute());
                },
                child: Text("Register")),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text("Forgot Password?"),
              TextButton(onPressed: () {}, child: Text("Click here"))
            ]),
          ],
        ),
      ),
    );
  }
}
