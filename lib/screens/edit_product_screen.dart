import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Editing'),
      ),
      body: Form(
          child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(label: Text('Title')),
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_priceFocusNode),
            ),
            TextFormField(
              decoration: const InputDecoration(label: Text('Price')),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.number,
              focusNode: _descriptionFocusNode,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_descriptionFocusNode),
            ),
            TextFormField(
              decoration: const InputDecoration(label: Text('Description')),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.multiline,
              focusNode: _descriptionFocusNode,
            ),
            Row(
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
                    decoration: const InputDecoration(label: Text('Image URL')),
                    textInputAction: TextInputAction.done,
                    focusNode: _imgUrlFocusNode,
                    controller: _imgUrlController,
                  ),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
