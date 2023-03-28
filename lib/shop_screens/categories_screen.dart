import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop/cubit/shop_cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return ConditionalBuilder(
              condition: cubit.categoryModel != null,
              builder: (context) => ListView.separated(
                  itemBuilder: (context, index) => categoryItem(
                      cubit.categoryModel?.data?.categories[index]),
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 5,
                      ),
                  itemCount: cubit.categoryModel!.data!.categories.length),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()));
        });
  }
}

Widget categoryItem(var model) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Card(
      elevation: 10,
      color: Colors.grey[200],
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.grey[200],
        ),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model['image']}'),
              height: 80,
              width: 80,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              model['name'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios)
          ],
        ),
      ),
    ),
  );
}
