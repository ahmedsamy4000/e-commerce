import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop/cubit/register_cubit/register_cubit.dart';
import 'package:shop/cubit/register_cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var key1 = GlobalKey<FormState>();
    var userName = TextEditingController();
    var phone = TextEditingController();
    var email = TextEditingController();
    var password = TextEditingController();
    return BlocProvider(
        create: (BuildContext context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
            listener: ((context, state) {}),
            builder: (context, state) {
              var cubit = RegisterCubit.get(context);
              return Scaffold(
                  appBar: AppBar(
                    title: const Text('Register'),
                  ),
                  body: Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Form(
                          key: key1,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Register',
                                  style: GoogleFonts.acme(
                                      textStyle: const TextStyle(fontSize: 40),
                                      color: Colors.green),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Register here to start your trip at shop application!!',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: userName,
                                  decoration: InputDecoration(
                                      hintText: 'UserName',
                                      suffix: const Icon(Icons.person),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0))),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: email,
                                  decoration: InputDecoration(
                                      hintText: 'Email',
                                      suffix: const Icon(
                                        Icons.email,
                                      ),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0))),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  height: 65,
                                  child: TextFormField(
                                    controller: password,
                                    obscureText: cubit.isPassword,
                                    decoration: InputDecoration(
                                        hintText: 'Password',
                                        suffix: IconButton(
                                            icon: Icon(
                                              cubit.suffix,
                                            ),
                                            onPressed: (() =>
                                                cubit.changeVisibility())),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(20.0))),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextFormField(
                                  controller: phone,
                                  decoration: InputDecoration(
                                      hintText: 'Phone',
                                      suffix: const Icon(Icons.phone),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0))),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                ConditionalBuilder(
                                  condition: state is! RegisterLoadingState,
                                  fallback: (context) => const Center(
                                      child: CircularProgressIndicator()),
                                  builder: (context) => TextButton(
                                      onPressed: () {
                                        cubit.userRegister(
                                            userName: userName.text,
                                            email: email.text,
                                            password: password.text,
                                            phone: phone.text);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        height: 70,
                                        child: const Center(
                                          child: Text(
                                            'Register',
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      )),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ));
            }));
  }
}
