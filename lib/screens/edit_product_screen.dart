import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/product_provider.dart';
import 'package:provider/provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product-screen';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imgUrlFocusNode = FocusNode();
  final _imgUrlController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  var _product = Product(
      id: DateTime.now().toString(),
      description: '',
      imageUrl: '',
      price: 0,
      title: '');
  bool isInit =
      true; //used in didChangeDepedencies to initialize product parameters if it's available
  bool isLoading = false;
  bool isNew = true; //check whether add new product or update
  var _initProduct = {
    'title': '',
    'price': '',
    'description': '',
    'imgUrl': '',
  };
// add listener for imgURL focusnode, when lose focus then trigger the function to preview the image.
  @override
  void initState() {
    _imgUrlFocusNode.addListener((imgUrlListener));
    super.initState();
  }

// Check whether create a new product or update
  @override
  void didChangeDependencies() {
    if (isInit) {
      final String? productId =
          ModalRoute.of(context)?.settings.arguments as String?;
      if (productId != null) {
        _product = Provider.of<ProductProvider>(context).getById(productId);
        _initProduct = {
          'title': _product.title,
          'price': _product.price.toString(),
          'description': _product.description,
        };
        _imgUrlController.text = _product.imageUrl;
        isNew = false;
      }
      isInit = false;
    }
    super.didChangeDependencies();
  }

// Show preview image
  void imgUrlListener() {
    if (!_imgUrlFocusNode.hasFocus) {
      if ((!_imgUrlController.text.startsWith('http') &&
              !_imgUrlController.text.startsWith('https')) ||
          (!_imgUrlController.text.endsWith('.jpg') &&
              !_imgUrlController.text.endsWith('.png') &&
              !_imgUrlController.text.endsWith('.jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

// Save form state to collect user input
  Future<void> _saveForm() async {
    if (!_formkey.currentState!.validate()) return;
    _formkey.currentState?.save();
    setState(() {
      isLoading = true;
    });
    if (isNew) {
      try {
        await Provider.of<ProductProvider>(context, listen: false)
            .addProduct(_product);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text('Error'),
                  content: const Text('Something goes wrong!'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('OK')),
                  ],
                ));
      }
      //finally {
      //   setState(() {
      //     isLoading = false;
      //     Navigator.of(context).pop();
      //   });
      // }
    } else {
      try {
        await Provider.of<ProductProvider>(context, listen: false)
            .updateProduct(_product.id, _product);
      } catch (error) {
        rethrow;
      }
    }
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imgUrlFocusNode.dispose();
    _imgUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Editing'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Form(
                  key: _formkey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: _initProduct['title'],
                          decoration:
                              const InputDecoration(label: Text('Title')),
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_priceFocusNode),
                          onSaved: (value) {
                            _product = Product(
                                id: _product.id,
                                description: _product.description,
                                title: value!,
                                imageUrl: _product.imageUrl,
                                price: _product.price,
                                isFavorite: _product.isFavorite);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill out the form.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          initialValue: _initProduct['price'],
                          decoration:
                              const InputDecoration(label: Text('Price')),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          focusNode: _priceFocusNode,
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode),
                          onSaved: (value) {
                            _product = Product(
                                id: _product.id,
                                description: _product.description,
                                title: _product.title,
                                imageUrl: _product.imageUrl,
                                price: double.parse(value!),
                                isFavorite: _product.isFavorite);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill out the form.';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Please enter a valid number.';
                            }
                            if (double.parse(value) <= 0) {
                              return 'Please enter a number greater than zero.';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          initialValue: _initProduct['description'],
                          decoration:
                              const InputDecoration(label: Text('Description')),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.multiline,
                          focusNode: _descriptionFocusNode,
                          onSaved: (value) {
                            _product = Product(
                                id: _product.id,
                                description: value!,
                                title: _product.title,
                                imageUrl: _product.imageUrl,
                                price: _product.price,
                                isFavorite: _product.isFavorite);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please fill out the form.';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Colors.grey,
                              )),
                              margin: const EdgeInsets.all(5),
                              child: _imgUrlController.text.isEmpty
                                  ? const Text('Enter the image URL')
                                  : Image.network(_imgUrlController.text),
                            ),
                            Expanded(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    label: Text('Image URL')),
                                textInputAction: TextInputAction.done,
                                focusNode: _imgUrlFocusNode,
                                controller: _imgUrlController,
                                onSaved: (value) {
                                  _product = Product(
                                      id: _product.id,
                                      description: _product.description,
                                      title: _product.title,
                                      imageUrl: value!,
                                      price: _product.price,
                                      isFavorite: _product.isFavorite);
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter image URL.';
                                  }
                                  if (!value.startsWith('http') &&
                                          !value.startsWith('https') ||
                                      !value.endsWith('.jpg') &&
                                          !value.endsWith('.png') &&
                                          !value.endsWith('.jpeg')) {
                                    return 'Please enter valid URL.';
                                  }
                                },
                                onFieldSubmitted: (_) => _saveForm(),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton(
                          onPressed: _saveForm,
                          child: const Text('Save'),
                          style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).colorScheme.primary),
                        ),
                      ],
                    ),
                  )),
            ),
    );
  }
}
