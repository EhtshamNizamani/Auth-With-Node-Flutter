import 'package:auth_with_nodejs/model/product.dart';
import 'package:auth_with_nodejs/product/controller/product_add_or_edit_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductAddOrEditScreen extends StatefulWidget {
  final ProductModel? product; // Optional parameter to pre-populate for editing

  const ProductAddOrEditScreen({Key? key, this.product}) : super(key: key);

  @override
  State<ProductAddOrEditScreen> createState() => _ProductAddOrEditScreenState();
}

class _ProductAddOrEditScreenState extends State<ProductAddOrEditScreen> {
  String _title = '';
  String _description = '';
  double _price = 0.0;
  double _rating = 0.0;
  String _brand = '';
  String _imageUrl = '';

  @override
  void initState() {
    super.initState();
    if (widget.product != null) {
      _title = widget.product!.title;
      _description = widget.product!.description;
      _price = widget.product!.price;
      _rating = widget.product!.rating;
      _brand = widget.product!.brand;
      _imageUrl = widget.product!.image;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductAddOrEditProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          title: Text(widget.product == null ? 'Add Product' : 'Edit Product'),
          actions: [
            provider.isLoading
                ? CircularProgressIndicator.adaptive()
                : IconButton(
                    icon: Icon(Icons.save),
                    onPressed: () {
                      widget.product != null
                          ? provider.updateProduct(
                              context,
                              ProductModel(
                                  id: widget.product!.id,
                                  title: _title,
                                  description: _description,
                                  price: _price,
                                  rating: _rating,
                                  brand: _brand,
                                  image: _imageUrl))
                          : provider.create(
                              context,
                              ProductModel(
                                  id: '',
                                  title: _title,
                                  description: _description,
                                  price: _price,
                                  rating: _rating,
                                  brand: _brand,
                                  image: _imageUrl));
                    },
                  ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: provider.formKey,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: _title,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a title';
                    }
                    return null;
                  },
                  onSaved: (value) => _title = value!,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  initialValue: _description,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 5, // Allow multiple lines for description
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) => _description = value!,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  initialValue: _price.toString(),
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number, // Allow only numbers
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a price';
                    }
                    try {
                      double.parse(value);
                    } catch (_) {
                      return 'Please enter a valid price';
                    }
                    return null;
                  },
                  onSaved: (value) => _price = double.parse(value!),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Text('Rating:'),
                    const Spacer(),
                    Slider(
                      value: _rating,
                      min: 0.0,
                      max: 5.0,
                      divisions: 10, // 10 divisions for finer control
                      onChanged: (value) => setState(() => _rating = value),
                    ),
                    Text(
                        '${_rating.toStringAsFixed(1)}'), // Display rating value
                  ],
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  initialValue: _brand,
                  decoration: const InputDecoration(labelText: 'Brand'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a brand';
                    }
                    return null;
                  },
                  onSaved: (value) => _brand = value!,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  initialValue: _imageUrl,
                  decoration: const InputDecoration(labelText: 'Image URL'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an image URL';
                    }
                    return null;
                  },
                  onSaved: (value) => _imageUrl = value!,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
