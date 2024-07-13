import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblock/features/cart/ui/cart.dart';
import 'package:flutterblock/features/home/bloc/home_bloc.dart';
import 'package:flutterblock/features/home/ui/product_tile_widget.dart';
import 'package:flutterblock/features/wishlist/ui/wishlist.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeBloc homeBloc;

  @override
  void initState() {
    super.initState();
    homeBloc = HomeBloc();
    homeBloc.add(HomeInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToCartPageActionState) {
          debugPrint("Navigate to cart page action");
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeNavigateToWishlistPageActionState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Wishlist()));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Grocery App"),
                  actions: [
                    IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistButtenNavigateEvent());
                      },
                      icon: const Icon(Icons.favorite),
                      color: Colors.red,
                    ),
                    IconButton(
                        onPressed: () {
                          homeBloc.add(HomeCartButtenNavigateEvent());
                        },
                        icon: const Icon(Icons.shopping_cart)),
                  ],
                ),
                body: ListView.builder(
                  itemCount: successState.products.length,
                  itemBuilder: (context, index) {
                  return ProductTile(
                      productDataModel: successState.products[index]);
                }));
          case HomeErrorState:
            return const Scaffold(body: Center(child: Text("Error")));
          default:
            return const Scaffold(
              body: Center(
                child: Text("none"),
              ),
            );
        }
      },
    );
  }
}
