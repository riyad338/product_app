import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:product_app/models/categorymodel.dart';
import 'package:product_app/models/productmodel.dart';
import 'package:product_app/provider/product_provider.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
  static const String routeName = '/product_page';
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  late ProductProvider productProvider;
  late List<bool> _isSelected;
  @override
  void didChangeDependencies() {
    productProvider = Provider.of<ProductProvider>(context);
    setState(() {
      productProvider.getData();
      _isSelected = _isSelected =
          List.filled(productProvider.categoryModel?.data?.length ?? 0, false);
    });
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();
    _isSelected = [];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xff5E1675),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xffFFD23F),
        title: Text("Products"),
      ),
      body: productProvider.hasDataLoaded
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: productProvider.productModel!.data!.length,
              itemBuilder: (context, index) {
                final product = productProvider.productModel!.data![index];
                final category =
                    productProvider.categoryModel!.data!.firstWhere(
                  (cat) => cat.id == product.id,
                  orElse: () => Data(id: 0, categoryName: 'Unknown Category'),
                );
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: ListTile(
                      tileColor: Color(0xffFFD23F),
                      title: Text("${product.productName}"),
                      subtitle: Text("${category.categoryName}"),
                      trailing: GestureDetector(
                        onTap: () {
                          productProvider.toggleCart(product);
                        },
                        child: Icon(
                          productProvider.isProductInCart(product)
                              ? Icons.remove
                              : Icons.add,
                          color: Color(0xff5E1675),
                          size: 50,
                        ),
                      )),
                );
              },
            )
          : Center(
              child: SpinKitFadingCircle(
                color: Colors.greenAccent,
              ),
            ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffFFD23F),
          onPressed: () {
            _showDialog(context);
          },
          child: Image.asset("images/cat.jpg")),
    ));
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.all(0),
          backgroundColor: Color(0xff5E1675),
          title: Container(
            height: 60.h,
            color: Color(0xffFFD23F), // Yellow header color
            child: Center(
              child: Text(
                'Categories',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: List.generate(
                productProvider.categoryModel!.data!.length,
                (index) {
                  final category = productProvider.categoryModel!.data![index];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _isSelected = List.filled(
                            productProvider.categoryModel!.data!.length, false);
                        _isSelected[index] = true;
                      });
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffEE4266)),
                            color: _isSelected[index]
                                ? Color(0xffEE4266)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10)),
                        child: ListTile(
                          title: Text(
                            category.categoryName ?? '',
                            style: TextStyle(
                              color: _isSelected[index]
                                  ? Color(0xff5E1675)
                                  : Color(0xffEE4266),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
