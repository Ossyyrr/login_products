import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      width: double.infinity,
      height: 200,
      decoration: _buildBoxDecoration(),
      child: const ClipRRect(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
        child: FadeInImage(
          image: NetworkImage('https://via.placeholder.com/400x300/green'),
          placeholder: AssetImage('asset/jar-loading.gif'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() {
    return const BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24)),
      boxShadow: [BoxShadow(color: Colors.black12, offset: Offset(0, 5), blurRadius: 10)],
    );
  }
}
