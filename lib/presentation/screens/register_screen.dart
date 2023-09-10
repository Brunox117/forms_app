import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forms_app/presentation/blocs/register_cubit/register_cubit.dart';
import 'package:forms_app/presentation/widgets/widgets.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo usuario'),
      ),
      body: BlocProvider(
          create: (context) => RegisterCubit(), child: const _RegisterView()),
    );
  }
}

class _RegisterView extends StatelessWidget {
  const _RegisterView();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(children: [
          const FlutterLogo(
            size: 100,
          ),
          const SizedBox(
            height: 20,
          ),
          _RegisterForm(),
        ]),
      ),
    ));
  }
}

class _RegisterForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final registerCubit = context.watch<RegisterCubit>();
    final username = registerCubit.state.username;
    final password = registerCubit.state.password;
    return Form(
        child: Column(
      children: [
        CustomTextFormField(
          label: 'Nombre de usuario',
          onChanged: registerCubit.usernameChanged,
          errorMessage: username.errorMessage,
          prefixIcon: const Icon(Icons.person_2_outlined),
          validator: (value) {
            if (value == null || value.isEmpty) return 'Campo requerido';
            if (value.trim().isEmpty) return 'Campo requerido';
            if (value.trim().length < 6) return 'El usuario debe tener más de 5 letras';
            return null;
          },
        ),
        const SizedBox(
          height: 15,
        ),
        CustomTextFormField(
          label: 'Correo electrónico',
          prefixIcon: const Icon(Icons.email_outlined),
          onChanged: (value) {
            registerCubit.emailChanged(value);
          },
          validator: (value) {
            if (value == null || value.isEmpty) return 'Campo requerido';
            if (value.trim().isEmpty) return 'Campo requerido';
            final emailRegExp = RegExp(
              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
            );
            if (!emailRegExp.hasMatch(value)) return 'Correo inválido';
            return null;
          },
        ),
        const SizedBox(
          height: 15,
        ),
        CustomTextFormField(
          label: 'Contraseña',
          prefixIcon: const Icon(Icons.password_outlined),
          onChanged: (value) {
            registerCubit.passwordChanged(value);
          },
          obscureText: true,
          validator: (value) {
            if (value == null || value.isEmpty) return 'Campo requerido';
            if (value.trim().isEmpty) return 'Campo requerido';
            if (value.trim().length < 6) return 'La contraseña debe tener más de 5 letras';
            return null;
          },
        ),
        const SizedBox(
          height: 40,
        ),
        FilledButton.tonalIcon(
            onPressed: () {
              registerCubit.onSubmit();
            },
            icon: const Icon(Icons.save),
            label: const Text('Crear usuario')),
        const SizedBox(
          height: 20,
        ),
      ],
    ));
  }
}
