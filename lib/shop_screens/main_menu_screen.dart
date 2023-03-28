import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop/cubit/shop_cubit/states.dart';
import 'package:shop/models/catageories_model.dart';
import 'package:shop/models/home_model.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return ConditionalBuilder(
              condition: cubit.homeModel != null && cubit.categoryModel != null,
              builder: (context) =>
                  builderWidget(cubit.homeModel, cubit.categoryModel, context),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()));
        });
  }
}

Widget builderWidget(HomeModel? model, CategoriesModel? catModel, context) {
  return SingleChildScrollView(
    physics: const BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1.0),
                borderRadius: BorderRadius.circular(12.0)),
            child: CarouselSlider(
                items: model?.data?.banners
                    .map((e) => Image(
                          image: NetworkImage('${e['image']}'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ))
                    .toList(),
                options: CarouselOptions(
                    enlargeCenterPage: true,
                    height: 250,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: const Duration(
                      seconds: 3,
                    ),
                    autoPlayAnimationDuration: const Duration(seconds: 1),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    scrollDirection: Axis.horizontal)),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Categories',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 90,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    categoryBuilder(catModel?.data?.categories[index]),
                itemCount: catModel!.data!.categories.length,
                separatorBuilder: (context, index) => const SizedBox(
                      width: 3,
                    )),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Recent Products',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            mainAxisSpacing: 5,
            crossAxisSpacing: 2,
            childAspectRatio: 1 / 1.40,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(
                model!.data!.products.length,
                (index) =>
                    buildProductGrid(model.data?.products[index], context)),
          ),
        )
      ],
    ),
  );
}

Widget categoryBuilder(var catModel) {
  return Container(
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(width: 1)),
    child: Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage('${catModel['image']}'),
          width: 90,
          height: 99,
          fit: BoxFit.cover,
        ),
        Container(
          alignment: Alignment.center,
          width: 90,
          height: 25,
          color: Colors.black.withOpacity(0.8),
          child: Text(
            catModel['name'],
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(color: Colors.white, fontSize: 10),
          ),
        )
      ],
    ),
  );
}

Widget buildProductGrid(var model, context) {
  return Padding(
    padding: const EdgeInsets.all(3.0),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: const Color.fromRGBO(6, 41, 135, 0.7)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    13.0,
                  ),
                  border: Border.all(),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image(
                  image: NetworkImage('${model['image']}'),
                  width: double.infinity,
                  height: 150,
                  fit: BoxFit.fill,
                ),
              ),
              if (model['discount'] != 0)
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.red),
                    child: const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text(
                        'Discount',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                )
            ],
          ),
          Container(
            alignment: Alignment.center,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  model['name'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text(
                  model['price'].toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  width: 10,
                ),
                if (model['discount'] != 0)
                  Text(
                    model['old_price'].toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white54),
                  ),
                const Spacer(),
                CircleAvatar(
                  backgroundColor:
                      ShopCubit.get(context).favourites[model['id']]!
                          ? Colors.white
                          : Colors.black,
                  radius: 15,
                  child: IconButton(
                      onPressed: () {
                        ShopCubit.get(context).changeFavourites(model['id']);
                      },
                      icon: const Icon(
                        Icons.favorite_outline_outlined,
                        size: 10,
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
