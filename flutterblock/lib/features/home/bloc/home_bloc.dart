import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutterblock/data/grocery_data.dart';
import 'package:flutterblock/features/home/models/home_product_data.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeProductWishlistButtenClickEvent>(
        homeProductWishlistButtonClickedEvent);
    on<HomeProductCartButtenClickEvent>(homeProductCartButtonClickedEvent);
    on<HomeWishlistButtenNavigateEvent>(homeWishlistButtonNavigateEvent);
    on<HomeCartButtenNavigateEvent>(homeCartButtonNavigateEvent);
  }

  Future<FutureOr<void>> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(
      HomeLoadedSuccessState(
        GroceryData.groceryProducts
            .map((e) => ProductDataModel(
                  id: e['id'],
                  name: e["name"],
                  category: e["category"],
                  description: e["description"],
                  price: e["price"],
                  imageUrl: e["imageUrl"],
                ))
            .toList(),
      ),
    );
  }

  FutureOr<void> homeProductWishlistButtonClickedEvent(
      HomeProductWishlistButtenClickEvent event, Emitter<HomeState> emit) {
    print('Wishlist Product Clicked');
    emit(HomeProductItemWishlistedActionState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtenClickEvent event, Emitter<HomeState> emit) {
    print('Cart Product clicked');
    emit(HomeProductItemCartedActionState());
  }

  FutureOr<void> homeWishlistButtonNavigateEvent(
      HomeWishlistButtenNavigateEvent event, Emitter<HomeState> emit) {
    print('Wishlist Navigate clicked');
    emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtenNavigateEvent event, Emitter<HomeState> emit) {
    print('Cart Navigate clicked');
    emit(HomeNavigateToCartPageActionState());
  }
}
