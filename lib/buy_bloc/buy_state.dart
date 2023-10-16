part of 'buy_bloc.dart';

@immutable
class BuyState {
  final bool isLoading;
  final bool isSuccess;
  final String? error;
  final List<ProductModel> products;

  BuyState({
    required this.isLoading,
    required this.isSuccess,
    this.error,
    required this.products,
  });

  factory BuyState.initial() {
    return BuyState(
        isLoading: false, isSuccess: false, error: null, products: []);
  }

  factory BuyState.loading() {
    return BuyState(
        isLoading: true, isSuccess: false, error: null, products: []);
  }

  factory BuyState.success() {
    return BuyState(
        isLoading: false, isSuccess: true, error: null, products: []);
  }

  factory BuyState.error(String errorMessage) {
    return BuyState(
        isLoading: false, isSuccess: false, error: errorMessage, products: []);
  }
  factory BuyState.loaded(List<ProductModel> products) {
    return BuyState(
        isLoading: false, isSuccess: false, error: '', products: products);
  }

  BuyState copyWith(
      {bool? isLoading,
      bool? isSuccess,
      String? error,
      List<ProductModel>? products}) {
    return BuyState(
      products: products ?? this.products,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      error: error ?? this.error,
    );
  }
}
