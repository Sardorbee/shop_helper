part of 'buy_bloc.dart';

@immutable
abstract class BuyEvent {}

class AddItemEvent extends BuyEvent {
  final ProductModel productModel;

  AddItemEvent(this.productModel);
}

class FetchProducts extends BuyEvent {}

class UpdateItemEvent extends BuyEvent {
  final ProductModel productModel;

  UpdateItemEvent(this.productModel);
}

class DeleteItemEvent extends BuyEvent {
  final String productId;

  DeleteItemEvent(this.productId);
}
