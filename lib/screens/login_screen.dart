import 'package:flutter/material.dart';
import 'package:productos_app/ui/input_decorations.dart';
import 'package:productos_app/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
            child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 230),
          CardContainer(
            child: Column(
              children: [
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headline4,
                ),
                const SizedBox(height: 30),
                const _LoginForm(),
              ],
            ),
          ),
          const Text(
            'Crear una nueva cuenta',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    )));
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
        // TODO Mantener la referencia al key
        child: Column(
      children: [
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecorations.authInputDecoration(
            hintText: 'john.doe@gmail.com',
            labelText: 'Correo electrónico',
            prefixIcon: Icons.alternate_email_rounded,
          ),
        ),
        const SizedBox(height: 25),
        TextFormField(
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          obscureText: true,
          decoration: InputDecorations.authInputDecoration(
            hintText: '**********',
            labelText: 'Contraaseña',
            prefixIcon: Icons.lock_outline,
          ),
        ),
        const SizedBox(height: 25),
        MaterialButton(
          onPressed: () {
            // TODO
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          disabledColor: Colors.grey,
          elevation: 0,
          color: Colors.deepPurple,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
            child: const Text(
              'Ingresar',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    ));
  }
}
