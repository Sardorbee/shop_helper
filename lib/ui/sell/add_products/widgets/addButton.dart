import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddProductButton extends StatelessWidget {
  const AddProductButton({
    super.key,
    required String? imageUrl,
    required String? catId,
  })  : _imageUrl = imageUrl,
        _catID = catId;

  final String? _imageUrl;
  final String? _catID;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Color(0xFFF83758)),
      ),
      onPressed: () {
        print(_imageUrl);
        // if (context
        //         .read<ProductsProvider>()
        //         .productsNameController
        //         .text
        //         .isNotEmpty &&
        //     context
        //         .read<ProductsProvider>()
        //         .productsDescController
        //         .text
        //         .isNotEmpty &&
        //     context
        //         .read<ProductsProvider>()
        //         .productsCountController
        //         .text
        //         .isNotEmpty &&
        //     context
        //         .read<ProductsProvider>()
        //         .productsPriceController
        //         .text
        //         .isNotEmpty &&
        //     _imageUrl != null) {
        //   context.read<ProductsProvider>().addProducts(
        //         context: context,
        //         drinksModel: DrinksModel(
        //           count: int.parse(context
        //               .read<ProductsProvider>()
        //               .productsCountController
        //               .text),
        //           price: int.parse(context
        //               .read<ProductsProvider>()
        //               .productsPriceController
        //               .text),
        //           isCarted: 0,
        //           drinkImage: _imageUrl!,
        //           drinkId: '',
        //           productName: context
        //               .read<ProductsProvider>()
        //               .productsNameController
        //               .text,
        //           description: context
        //               .read<ProductsProvider>()
        //               .productsDescController
        //               .text,
        //           createdAt: DateTime.now().toString(),
        //           currency: "So'm",
        //         ),
        //       );
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //       content: Text('Drink added'),
        //     ),
        //   );
        //   Navigator.pop(context);
        // } else {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //       content: Text('Maydonlar to\'ldirilmadi'),
        //     ),
        //   );
        // },
      },
      child: const Text(
        "Add Product",
      ),
    );
  }
}
