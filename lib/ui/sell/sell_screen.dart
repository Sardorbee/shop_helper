import 'package:flutter/material.dart';
import 'package:shop_helper/service/firebase/products_service.dart';
import 'package:shop_helper/service/model/productsModel.dart';
import 'package:shop_helper/ui/sell/add_products/add_products.dart';

class SellScreen extends StatelessWidget {
  const SellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        title: const Text(
          "Sell Screen",
          style: TextStyle(color: Colors.black),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Addproducts(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: DisplayedService().getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }

          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            // If you have a list of ProductModel objects
            final productList = snapshot.data;

            return ListView.builder(
              itemCount: productList!.length,
              itemBuilder: (context, index) {
                final product = productList[index];

                return ListTile(
                  title: Text(product.name),
                  subtitle: Text("QRCode: ${product.qrCode}"),
                  // Add more fields and styling as needed
                );
              },
            );
          } else {
            return const Center(child: Text("No products available"));
          }
        },
      ),
    );
  }
}
