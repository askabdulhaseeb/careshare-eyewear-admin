import 'package:careshareeyewear_admin/screens/auth/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../database/auth_methods.dart';
import '../../models/product.dart';
import '../../providers/product_provider.dart';
import '../../widgets/product/product_gridview.dart';
import 'add_product_screen.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);
  static const String routeName = '/ProductScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthMethods().signOut();

              // ignore: use_build_context_synchronously
              Navigator.of(context).pushNamedAndRemoveUntil(
                LoginScreen.routeName,
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Consumer<ProductProvider>(
            builder: (BuildContext context, ProductProvider prodPro, _) {
              return RefreshIndicator(
                onRefresh: () => prodPro.refesh(),
                child: Column(children: <Widget>[
                  CupertinoSearchTextField(
                    itemSize: 44,
                    prefixIcon: const Icon(CupertinoIcons.search, size: 24),
                    suffixIcon: const Icon(Icons.cancel, size: 24),
                    onChanged: (String? value) => print(value),
                  ),
                  ListTile(
                    leading: const Icon(Icons.add),
                    minLeadingWidth: 0,
                    title: const Text('Add Product'),
                    subtitle:
                        const Text('Click here to add new product in stock'),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute<AddProductScreen>(
                              builder: (BuildContext context) =>
                                  AddProductScreen(
                                      product: Product(
                                    pid: AuthMethods.uniqueID,
                                    name: '',
                                    urls: <String>[],
                                  ))));
                    },
                  ),
                  const SizedBox(height: 20),
                  ProductGridView(posts: prodPro.products),
                ]),
              );
            },
          ),
        ),
      ),
    );
  }
}
