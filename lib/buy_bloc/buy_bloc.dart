import 'dart:async';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';
import 'package:shop_helper/service/firebase/products_service.dart';
import 'package:shop_helper/service/model/productsModel.dart';
import 'package:shop_helper/service/model/universal_data.dart';

part 'buy_event.dart';
part 'buy_state.dart';

class BuyBloc extends Bloc<BuyEvent, BuyState> {
  final DisplayedService _service = DisplayedService();

  BuyBloc() : super(BuyState.initial()) {
    on<AddItemEvent>(_handleAddEvent);
    on<UpdateItemEvent>(_handleUpdateEvent);
    on<DeleteItemEvent>(_handleDeleteEvent);
    on<FetchProducts>(fetchProducts);
    add(FetchProducts());
  }

  Future<void> _handleAddEvent(
      AddItemEvent event, Emitter<BuyState> emit) async {
    emit(BuyState.loading());

    try {
      final result =
          await _service.addService(productModel: event.productModel);
      emit(BuyState.success());
    } catch (error) {
      emit(BuyState.error(error.toString()));
    }
  }

  Future<void> _handleUpdateEvent(
      UpdateItemEvent event, Emitter<BuyState> emit) async {
    emit(BuyState.loading());

    try {
      final result =
          await _service.updateService(serviceModel: event.productModel);
      emit(BuyState.success());
    } catch (error) {
      emit(BuyState.error(error.toString()));
    }
  }

  Future<void> _handleDeleteEvent(
      DeleteItemEvent event, Emitter<BuyState> emit) async {
    emit(BuyState.loading());

    try {
      final result = await _service.deleteService(serviceId: event.productId);
      emit(BuyState.success());
    } catch (error) {
      emit(BuyState.error(error.toString()));
    }
  }

  Future<void> fetchProducts(
      FetchProducts event, Emitter<BuyState> emit) async {
    try {
      emit(BuyState.loading());

      final productsSnapshot =
          await FirebaseFirestore.instance.collection('products').get();
      final products = productsSnapshot.docs
          .map((doc) =>
              ProductModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      emit(BuyState.loaded(products));
    } catch (e) {
      emit(BuyState.error('Failed to fetch products: $e'));
    }
  }
}
