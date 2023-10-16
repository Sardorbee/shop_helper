import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:shop_helper/ui/sell/sell_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? scannedQrCode;

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      scannedQrCode = barcodeScanRes;
      _processBarcode(scannedQrCode);
    });
  }

  Future<void> _processBarcode(String? qrCode) async {
    QuerySnapshot productSnapshot = await FirebaseFirestore.instance
        .collection("products")
        .where("qrCode", isEqualTo: qrCode)
        .get();

    if (productSnapshot.docs.isNotEmpty) {
      final productData =
          productSnapshot.docs.first.data() as Map<String, dynamic>;
      final count = productData['count'] as String;
      final productCount = int.parse(count);

      if (productCount == 0) {
        showCountIs0Dialog();
      } else {
        int newCount = productCount - 1;
        await updateProductCount(productData['productId'], newCount);
      }
    } else {
      showQRCodeNotFoundDialog();
    }
  }

  Future<void> updateProductCount(String docId, int newCount) async {
    {
      try {
        await FirebaseFirestore.instance
            .collection("products")
            .doc(docId)
            .update({
          "count": newCount.toString(),
        });

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sold successfully!.'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to update'),
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    }
  }

  void showCountIs0Dialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('You don\'t have enough Products'),
          content: const Text('A product with this barcode already exists.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showQRCodeNotFoundDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('QR code not found'),
          content: const Text('QR code does not exist in the collection.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
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
        backgroundColor: Colors.white,
        title: const Text(
          "Shop Helper",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    scanBarcodeNormal();
                  },
                  child: const Text('Buy', style: TextStyle(fontSize: 30)),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Center(
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SellScreen(),
                        ));
                  },
                  child: const Text('Sell', style: TextStyle(fontSize: 30)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
