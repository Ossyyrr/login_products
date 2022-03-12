import 'package:flutter/material.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/product_image.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Stack(
              children: [
                const ProductImage(),
                Positioned(
                  top: 20,
                  left: 20,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new, size: 32, color: Colors.white),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: IconButton(
                    onPressed: () {
                      // TODO Galeria
                    },
                    icon: const Icon(Icons.camera_alt_outlined, size: 32, color: Colors.white),
                  ),
                ),
              ],
            ),
            const _ProductForm(),
            const SizedBox(
              height: 100,
            )
          ],
        )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // TODO Guardar producto
          },
          child: const Icon(Icons.save)),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: _buildBoxDecoration(),
      child: Form(
          child: Column(
        children: [
          const SizedBox(height: 10),
          TextFormField(
            decoration: InputDecorations.authInputDecoration(
              hintText: 'Nombre',
              labelText: 'label',
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecorations.authInputDecoration(
              hintText: '\$150',
              labelText: 'precio:',
            ),
          ),
          const SizedBox(height: 30),
          SwitchListTile.adaptive(
            value: true,
            title: const Text('disponible'),
            activeColor: Colors.indigo,
            onChanged: (v) {},
          )
        ],
      )),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25)),
      boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0, 5), blurRadius: 5)]);
}
