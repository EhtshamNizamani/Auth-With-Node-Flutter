import 'package:auth_with_nodejs/home/controller/home.dart';
import 'package:auth_with_nodejs/model/product.dart';
import 'package:auth_with_nodejs/product/view/product_add_or_edit_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeProvider>().getAllProducts(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<HomeProvider>(builder: (context, provider, _) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.products.length,
                    itemBuilder: (context, index) {
                      final ProductModel product = provider.products[index];

                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 4.0, bottom: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.grey.shade400),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .start, // Align content to the left
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Card(
                                  child: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (_) =>
                                                    ProductAddOrEditScreen(
                                                      product: product,
                                                    )));
                                      },
                                      icon: const Icon(Icons.edit)),
                                ),
                                Card(
                                  child: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        provider.deleteProduct(
                                            context, product.id);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      )),
                                ),
                              ],
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(product.image,
                                  height: 150.0,
                                  width: double.infinity,
                                  fit: BoxFit.cover),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              product.title,
                              style: const TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              product.description,
                              maxLines: 2, // Wrap long descriptions
                              overflow: TextOverflow
                                  .ellipsis, // Add "..." for overflow
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment
                                  .spaceBetween, // Align price and rating
                              children: [
                                Text(
                                  '\$${product.price.toString()}',
                                  style: const TextStyle(
                                      fontSize: 16.0, color: Colors.green),
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow[600],
                                      size: 22.0,
                                    ),
                                    Text(4.4.toString(),
                                        style: const TextStyle(fontSize: 14.0)),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 4.0),
                            Text(
                              product.brand,
                              style: const TextStyle(
                                  fontSize: 12.0, color: Colors.grey),
                            ),
                          ],
                        ),
                      );
                    }),
              )
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const ProductAddOrEditScreen()));
        }, // Customize the icon
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add), // Set blue background color
      ),
    );
  }
}
