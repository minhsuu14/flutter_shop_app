import 'package:flutter/material.dart';
import '../models/product.dart';

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

  @override
  void initState() {
    _imgUrlFocusNode.addListener((imgUrlListener));
    super.initState();
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imgUrlFocusNode.dispose();
    _imgUrlController.dispose();
    super.dispose();
  }

  void imgUrlListener() {
    if (_imgUrlController.text.isNotEmpty) {
      setState(() {});
    }
  }

  void _saveForm() {
    _formkey.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Editing'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(label: Text('Title')),
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) =>
                        FocusScope.of(context).requestFocus(_priceFocusNode),
                    onSaved: (value) {
                      _product = Product(
                          id: _product.id,
                          description: _product.description,
                          title: value!,
                          imageUrl: _product.imageUrl,
                          price: _product.price);
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(label: Text('Price')),
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
                          price: double.parse(value!));
                    },
                  ),
                  TextFormField(
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
                          price: _product.price);
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
                          decoration:
                              const InputDecoration(label: Text('Image URL')),
                          textInputAction: TextInputAction.done,
                          focusNode: _imgUrlFocusNode,
                          controller: _imgUrlController,
                          onSaved: (value) {
                            _product = Product(
                                id: _product.id,
                                description: _product.description,
                                title: _product.title,
                                imageUrl: value!,
                                price: _product.price);
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
