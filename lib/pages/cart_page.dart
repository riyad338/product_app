import 'package:flutter/material.dart';
import 'package:product_app/models/categorymodel.dart';
import 'package:product_app/provider/product_provider.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  static const String routeName = '/cart_page';
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff5E1675),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xffFFD23F),
          title: Text('Carts'),
        ),
        body: ListView.builder(
          itemCount: productProvider.cartProducts.length,
          itemBuilder: (context, index) {
            final product = productProvider.cartProducts[index];
            final category = productProvider.categoryModel!.data!.firstWhere(
              (cat) => cat.id == product.id,
              orElse: () => Data(id: 0, categoryName: 'Unknown Category'),
            );
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                  tileColor: Color(0xffFFD23F),
                  title: Text(product.productName ?? ''),
                  subtitle: Text("${category.categoryName}"),
                  trailing: GestureDetector(
                    onTap: () {
                      productProvider.cartProducts.remove(product);
                      setState(() {});
                    },
                    child: Icon(
                      Icons.delete,
                      color: Color(0xff5E1675),
                      size: 50,
                    ),
                  )),
              // Add any other details you want to display
            );
          },
        ),
      ),
    );
  }
}
