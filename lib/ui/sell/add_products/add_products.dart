import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shop_helper/buy_bloc/buy_bloc.dart';
import 'package:shop_helper/service/model/productsModel.dart';
import 'package:shop_helper/ui/utils/global_textf.dart';
import 'package:shop_helper/ui/utils/upload_img.dart';

class Addproducts extends StatefulWidget {
  const Addproducts({super.key});

  @override
  State<Addproducts> createState() => _AddproductsState();
}

class _AddproductsState extends State<Addproducts> {
  XFile? _imageFile;
  String? _imageUrl;
  String? catID;
  String? catName;
  String? _scanBarcode;

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController countController = TextEditingController();
  TextEditingController barcodeController = TextEditingController();

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    context.read<BuyBloc>().add(FetchProducts());
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;
    final state = context.read<BuyBloc>().state;

    final products = state.products;
    if (products.any((product) => product.qrCode == barcodeScanRes)) {
      showBarcodeExistsDialog();
    } else {
      setState(() {
        barcodeController.text = barcodeScanRes;
        _scanBarcode = barcodeScanRes;
      });
    }
  }

  @override
  void initState() {
    scanBarcodeNormal();
    super.initState();
  }

  void showBarcodeExistsDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Barcode Exists'),
          content: Text('A product with this barcode already exists.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F2F2),
        title: const Text(
          "Add Product",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(10.h),
              children: [
                GlobalTextField(
                  hintText: "Add Product name",
                  textAlign: TextAlign.start,
                  label: 'Name',
                  controller: nameController,
                ),
                GlobalTextField(
                  hintText: "Add Product count",
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.number,
                  label: 'Count',
                  controller: countController,
                ),
                GlobalTextField(
                  hintText: "Add Product price",
                  textAlign: TextAlign.start,
                  keyboardType: TextInputType.number,
                  label: 'Price',
                  controller: priceController,
                ),
                TextField(
                  readOnly: true,
                  controller: barcodeController,
                  decoration: InputDecoration(
                    hintText: _scanBarcode ?? "Scan Barcode",
                    suffixIcon: IconButton(
                      onPressed: () {
                        scanBarcodeNormal();
                      },
                      icon: const Icon(
                        Icons.document_scanner_outlined,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.w, right: 10.w, bottom: 5.h),
            child: SizedBox(
                width: double.infinity,
                height: 52.h,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () async {
                    print(_imageUrl);

                    if (_scanBarcode!.isNotEmpty &&
                        nameController.text.isNotEmpty) {
                      context.read<BuyBloc>().add(
                            AddItemEvent(
                              ProductModel(
                                productId: '',
                                qrCode: _scanBarcode!,
                                name: nameController.text,
                                price: priceController.text.isEmpty
                                    ? "1"
                                    : priceController.text,
                                count: countController.text,
                                imageUrl: "_imageUrl!",
                              ),
                            ),
                          );
                      Navigator.pop(context);
                    } else {
                      showEmptyFieldBottomSheet(context, "Name");
                    }
                  },
                  child: const Text(
                    "Add Product",
                  ),
                )),
          ),
        ],
      ),
    );
  }

  void showEmptyFieldBottomSheet(BuildContext context, String emptyField) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Error: $emptyField is empty.',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Please provide a value for $emptyField.',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        );
      },
    );
  }
}
