part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductWishlistButtenClickEvent extends HomeEvent {}

class HomeProductCartButtenClickEvent extends HomeEvent {}

class HomeWishlistButtenNavigateEvent extends HomeEvent {}

class HomeCartButtenNavigateEvent extends HomeEvent {}
