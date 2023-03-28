import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop/cubit/shop_cubit/states.dart';
import 'package:shop/shop_screens/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var emailController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context).userModel;
          nameController.text = cubit!.data!.name.toString();
          emailController.text = cubit.data!.email.toString();
          phoneController.text = cubit.data!.phone.toString();
          return ConditionalBuilder(
            condition: ShopCubit.get(context).userModel != null,
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            builder: (context) => Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        label: Text('Name'), prefix: Icon(Icons.person)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        label: Text('Email'), prefix: Icon(Icons.email)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        label: Text('Phone'), prefix: Icon(Icons.phone)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12.0)),
                        height: 70,
                        child: const Center(
                          child: Text(
                            'SignOut',
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          );
        });
  }
}
