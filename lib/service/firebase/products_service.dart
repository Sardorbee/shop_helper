import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_helper/service/model/productsModel.dart';
import 'package:shop_helper/service/model/universal_data.dart';

class DisplayedService {
  Future<UniversalData> addService({required ProductModel productModel}) async {
    try {
      DocumentReference newService = await FirebaseFirestore.instance
          .collection("products")
          .add(productModel.toJson());

      await FirebaseFirestore.instance
          .collection("products")
          .doc(newService.id)
          .update({
        "productId": newService.id,
      });

      return UniversalData(data: "products added!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> updateService(
      {required ProductModel serviceModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("products")
          .doc(serviceModel.productId.toString())
          .update(serviceModel.toJson());

      return UniversalData(data: "products updated!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> deleteService({required String serviceId}) async {
    try {
      await FirebaseFirestore.instance
          .collection("products")
          .doc(serviceId)
          .delete();

      return UniversalData(data: "products deleted!");
    } on FirebaseException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Stream<List<ProductModel>> getProducts() async* {
    yield* FirebaseFirestore.instance.collection("products").snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => ProductModel.fromJson(doc.data()))
              .toList(),
        );
  }
}
