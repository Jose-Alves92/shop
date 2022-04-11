import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product_model.dart';
import 'package:shop/models/products_list_model.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final TextEditingController _imageUrlController = TextEditingController();
  final urlImageFocus = FocusNode();
  final _keyForm = GlobalKey<FormState>();
  final Map<String, Object> _formData = {};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    urlImageFocus.addListener(updateImage);
  }

  @override
  void dispose() {
    super.dispose();
    urlImageFocus.removeListener(updateImage);
    urlImageFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValid = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');

    return isValid && endsWithFile;
  }

  void _submitForm() {
    final isValid = _keyForm.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _keyForm.currentState?.save();

    Provider.of<ProductsList>(context, listen: false).saveProduct(_formData);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Produto'),
        actions: [
          IconButton(onPressed: _submitForm, icon: const Icon(Icons.save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _keyForm,
          child: ListView(
            children: [
              TextFormField(
                initialValue: _formData['name']?.toString(),
                decoration: const InputDecoration(
                  labelText: 'Nome',
                ),
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                style: const TextStyle(color: Colors.black),
                onSaved: (newValue) => _formData['name'] = newValue as Object,
                validator: (_value) {
                  final value = _value ?? '';

                  if (value.trim().isEmpty) {
                    return 'O nome é obrigatório';
                  } else if (value.trim().length < 3) {
                    return 'O nome precisa no mínimo de 3 letras.';
                  }

                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['price']?.toString(),
                decoration: const InputDecoration(
                  labelText: 'Preço',
                ),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                style: const TextStyle(color: Colors.black),
                onSaved: (newValue) =>
                    _formData['price'] = double.parse(newValue ?? '0.0'),
                validator: (_value) {
                  final valueString = _value ?? '';
                  final value = double.tryParse(valueString) ?? -1;

                  if (value <= 0) {
                    return 'Informe um preço válido.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _formData['description']?.toString(),
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 2,
                textInputAction: TextInputAction.next,
                style: const TextStyle(color: Colors.black),
                onSaved: (newValue) =>
                    _formData['description'] = newValue as Object,
                validator: (_value) {
                  final value = _value ?? '';

                  if (value.trim().isEmpty) {
                    return 'A discrição é obrigatória';
                  } else if (value.trim().length < 8) {
                    return 'A discrição precisa no mínimo de 8 letras.';
                  }

                  return null;
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Url da Imagem',
                      ),
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.none,
                      style: const TextStyle(color: Colors.black),
                      focusNode: urlImageFocus,
                      controller: _imageUrlController,
                      onSaved: (newValue) =>
                          _formData['imageUrl'] = newValue as Object,
                      validator: (_value) {
                        final value = _value ?? '';

                        if (!isValidImageUrl(value)) {
                          return 'Informe uma url valida.';
                        }

                        return null;
                      },
                    ),
                  ),
                  Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.only(
                        top: 10,
                        left: 10,
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      )),
                      alignment: Alignment.center,
                      child: _imageUrlController.text.isEmpty
                          ? const Text('Sem Imagem',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 15))
                          : FittedBox(
                              child: Image.network(_imageUrlController.text),
                              fit: BoxFit.cover,
                            ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
