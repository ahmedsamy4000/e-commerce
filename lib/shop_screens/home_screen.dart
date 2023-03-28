import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop/cubit/shop_cubit/states.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => ShopCubit()
          ..getHomeData()
          ..getCategoriesData()
          ..getFavData()
          ..getUserData(),
        child: BlocConsumer<ShopCubit, ShopStates>(
            listener: ((context, state) {}),
            builder: (context, state) {
              var cubit = ShopCubit.get(context);
              return Scaffold(
                backgroundColor: const Color.fromRGBO(237, 198, 167, 1.0),
                appBar: AppBar(
                  backgroundColor: const Color.fromRGBO(237, 198, 167, 1.0),
                  actions: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    )
                  ],
                  centerTitle: true,
                  title: Text(
                    cubit.titles[cubit.currentIndex],
                    style:
                        GoogleFonts.akshar(color: Colors.black, fontSize: 25),
                  ),
                ),
                body: cubit.screens[cubit.currentIndex],
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: const Color.fromRGBO(237, 198, 167, 1.0),
                  selectedIconTheme: const IconThemeData(color: Colors.white),
                  fixedColor: Colors.black,
                  unselectedItemColor: Colors.black,
                  items: cubit.items,
                  currentIndex: cubit.currentIndex,
                  onTap: (index) => cubit.changeItem(index),
                ),
              );
            }));
  }
}
