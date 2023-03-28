import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/shopLogin_cubit/shoplogin_cubit.dart';
import 'package:shop/cubit/shopLogin_cubit/states.dart';
import 'package:shop/shop_screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var key1 = GlobalKey<FormState>();
    var email = TextEditingController();
    var password = TextEditingController();
    return BlocProvider(
        create: (BuildContext context) => ShopCubit(),
        child: BlocConsumer<ShopCubit, ShopLoginStates>(
            listener: ((context, state) {}),
            builder: (context, state) {
              var cubit = ShopCubit.get(context);
              return Scaffold(
                  appBar: AppBar(
                    title: const Text('Login'),
                  ),
                  body: SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Form(
                          key: key1,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  'Login here to start your trip at shop application!!',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey),
                                ),
                                const SizedBox(
                                  height: 20,
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
                                  validator: (String? value) {
                                    if (value == null) {
                                      return 'email isnot true';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 30,
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
                                    validator: (value) {
                                      if (value == null) {
                                        return 'password isnot true';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ConditionalBuilder(
                                  condition: state is! ShopLoginLoadingState,
                                  fallback: (context) => const Center(
                                      child: CircularProgressIndicator()),
                                  builder: (context) => TextButton(
                                      onPressed: () {
                                        cubit.userLogin(
                                            email: email.text,
                                            password: password.text);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius:
                                                BorderRadius.circular(12.0)),
                                        height: 70,
                                        child: const Center(
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                      )),
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'donot have an account?',
                                      textAlign: TextAlign.start,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const RegisterScreen()));
                                        },
                                        child: const Text(
                                          'Register',
                                          style: TextStyle(color: Colors.blue),
                                        ))
                                  ],
                                )
                              ]),
                        ),
                      ),
                    ),
                  ));
            }));
  }
}
