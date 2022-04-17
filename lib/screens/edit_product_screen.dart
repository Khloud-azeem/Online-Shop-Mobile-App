import 'package:flutter/material.dart';
import 'package:online_shop/providers/product.dart';
import 'package:online_shop/providers/products_provider.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  const EditProductScreen({Key? key}) : super(key: key);
  static const routeName = '/edit-product';

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  Product _editedProduct = Product(
    id: '',
    title: '',
    price: 0,
    description: '',
    imgUrl: '',
  );
  var _isLoading = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() => _updateImgUrl);
    super.initState();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose(); //avo id memory leaks
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    _imageUrlFocusNode.removeListener(() => _updateImgUrl);
    super.dispose();
  }

  void _updateImgUrl() {
    //to show the photo on the img url box once we tap out if the url text field
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveForm() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) {
      return;
    } else {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      final productsData =
          Provider.of<ProductsProvider>(context, listen: false);
      try {
        await productsData.addProduct(_editedProduct);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("An error occured"),
                  content: Text("Something went wrong"),
                  actions: <Widget>[
                    TextButton(
                        child: Text('Okay'),
                        onPressed: () => Navigator.of(context).pop())
                  ],
                ));
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Product Title'),
                        ),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                            id: _editedProduct.id,
                            title: value as String,
                            price: _editedProduct.price,
                            description: _editedProduct.description,
                            imgUrl: _editedProduct.imgUrl,
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value.';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Product Price'),
                        ),
                        keyboardType: TextInputType.number,
                        //doesn't work correctly???
                        textInputAction: TextInputAction.next,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        onSaved: (value) {
                          _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            price: double.parse(value as String),
                            description: _editedProduct.description,
                            imgUrl: _editedProduct.imgUrl,
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value.';
                          } else if (double.tryParse(value) == null) {
                            return 'Please provide a valid price.';
                          } else if (double.parse(value) <= 0) {
                            return 'Please provide a number greater than zero.';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          label: Text('Product Description'),
                        ),
                        maxLines: 2,
                        keyboardType: TextInputType.multiline,
                        focusNode: _descriptionFocusNode,
                        onSaved: (value) {
                          _editedProduct = Product(
                            id: _editedProduct.id,
                            title: _editedProduct.title,
                            price: _editedProduct.price,
                            description: value as String,
                            imgUrl: _editedProduct.imgUrl,
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a value.';
                          } else if (value.length < 10) {
                            return 'Description should be at least 10 characters long.';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                                decoration: const InputDecoration(
                                  label: Text('Image URL'),
                                ),
                                keyboardType: TextInputType.url,
                                textInputAction: TextInputAction.done,
                                controller: _imageUrlController,
                                focusNode: _imageUrlFocusNode,
                                onFieldSubmitted: (_) {
                                  _saveForm();
                                },
                                onSaved: (value) {
                                  _editedProduct = Product(
                                    id: _editedProduct.id,
                                    title: _editedProduct.title,
                                    price: _editedProduct.price,
                                    description: _editedProduct.description,
                                    imgUrl: value as String,
                                  );
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please provide a value.';
                                  } else if (!value.startsWith('http')) {
                                    return 'Please provide a valid URL';
                                  }
                                  return null;
                                }),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            height: MediaQuery.of(context).size.height * 0.15,
                            width: MediaQuery.of(context).size.height * 0.15,
                            child: _imageUrlController.text.isEmpty
                                ? const Text('Enter URL')
                                : FittedBox(
                                    child: Image.network(
                                      _imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
