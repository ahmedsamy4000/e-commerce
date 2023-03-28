import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/cubit/shop_cubit/shop_cubit.dart';
import 'package:shop/models/my_favourites_model.dart';

import '../cubit/shop_cubit/states.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return ConditionalBuilder(
              condition: state is! ShopLoadingGetFavouritesState,
              builder: (context) => ListView.separated(
                    itemBuilder: (context, index) => buildFavItem(
                        cubit.favouritesModel!.data!.data![index], context),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                    itemCount: cubit.favouritesModel!.data!.data!.length,
                  ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()));
        });
  }
}

Widget buildFavItem(FavouritesData model, context) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    13.0,
                  ),
                  border: Border.all(),
                ),
                clipBehavior: Clip.antiAlias,
                child: Image(
                  image: NetworkImage('${model.product!.image}'),
                ),
              ),
              if (model.product!.discount != 0)
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
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        model.product!.name.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                        style: const TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Text(
                          model.product!.price.toString(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        if (model.product!.discount != 0)
                          Text(
                            model.product!.oldPrice.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        const Spacer(),
                        CircleAvatar(
                          backgroundColor: ShopCubit.get(context)
                                  .favourites[model.product?.id]!
                              ? Colors.blue
                              : Colors.grey,
                          radius: 15,
                          child: IconButton(
                              onPressed: () {
                                ShopCubit.get(context)
                                    .changeFavourites(model.product?.id);
                              },
                              icon: const Icon(
                                Icons.favorite_outline_outlined,
                                size: 10,
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
