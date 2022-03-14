import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:productos_app/providers/product_form_provider.dart';
import 'package:productos_app/services/services.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/product_image.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);

    return ChangeNotifierProvider(
      create: (_) => ProductFormProvider(productService.selectedProduct),
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            //! keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,-> esconde el teclado al hacer scroll
            child: Column(
          children: [
            Stack(
              children: [
                ProductImage(url: productService.selectedProduct.picture),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
                      color: Colors.indigo,
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.arrow_back_ios_new, size: 24, color: Colors.white),
                    ),
                  ),
                ),
                Positioned(
                  top: 16,
                  right: 16,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(24), bottomLeft: Radius.circular(24)),
                      color: Colors.indigo,
                    ),
                    child: IconButton(
                      onPressed: () {
                        // TODO Galeria
                      },
                      icon: const Icon(Icons.camera_alt_outlined, size: 28, color: Colors.white),
                    ),
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
      //  floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (!productForm.isValidForm()) return;
          await productService.saveOrCreateProduct(productForm.product);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  const _ProductForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;

    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: _buildBoxDecoration(),
      child: Form(
        key: productForm.formKey,
        //! AutovalidateMode
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextFormField(
              initialValue: product.name,
              onChanged: (v) => product.name = v,
              validator: (v) {
                if (v == null || v.isEmpty) return 'El nombre es obligatorio';
                return null;
              },
              decoration: InputDecorations.authInputDecoration(
                hintText: 'Nombre',
                labelText: 'label',
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              initialValue: product.price.toString(),
              //! INPUT FORMATERS - regExp que solo permite dos decimales
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
              ],
              onChanged: (v) => double.tryParse(v) == null ? product.price == 0 : product.price = double.parse(v),
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                hintText: '\$150',
                labelText: 'precio:',
              ),
            ),
            const SizedBox(height: 30),
            SwitchListTile.adaptive(
              value: product.available,
              title: const Text('disponible'),
              activeColor: Colors.indigo,
              onChanged: productForm.updateAvailability,
              // onChanged: (v) {
              //   productForm.updateAvailability(v);
              // },
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
      boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0, 5), blurRadius: 5)]);
}
