import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vinno_foods/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:vinno_foods/features/auth/presentation/blocs/auth_event.dart';
import 'package:vinno_foods/features/auth/presentation/blocs/auth_state.dart';
import 'package:vinno_foods/features/auth/presentation/pages/welcome_screen.dart';
import 'package:vinno_foods/features/auth/presentation/widgets/custom_text_field.dart';

class TemplateLogin extends StatefulWidget {
  const TemplateLogin({super.key});

  @override
  State<TemplateLogin> createState() => _TemplateLoginState();
}

class _TemplateLoginState extends State<TemplateLogin> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;
  final _nameController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (_isLogin) {
      context.read<AuthBloc>().add(
            AuthLoginRequested(email, password),
          );
    } else {
      final name = _nameController.text.trim();
      context.read<AuthBloc>().add(
            AuthSignUpRequested(
              email: email,
              password: password,
              name: name,
            ),
          );
    }
  }

  void _switchAuthMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const WelcomeScreen(),
            ),
          );
        } else if (state.status == AuthStatus.failure &&
            state.errorMessage != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: size.height * 0.05),
                      // Logo o imagen
                      Icon(
                        Icons.restaurant_menu,
                        size: 100,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        _isLogin ? 'Bienvenido' : 'Crear cuenta',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      if (state.status == AuthStatus.loading)
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          child: CircularProgressIndicator(),
                        )
                      else
                        const SizedBox.shrink(),
                      const SizedBox(height: 8),
                      Text(
                        _isLogin
                            ? 'Inicia sesión para continuar'
                            : 'Completa el formulario para registrarte',
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      if (!_isLogin) ..._buildNameField(),
                      CustomTextField(
                        controller: _emailController,
                        label: 'Correo electrónico',
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: const Icon(Icons.email_outlined),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu correo';
                          }
                          if (!value.contains('@')) {
                            return 'Ingresa un correo válido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _passwordController,
                        label: 'Contraseña',
                        obscureText: _obscurePassword,
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingresa tu contraseña';
                          }
                          if (value.length < 6) {
                            return 'La contraseña debe tener al menos 6 caracteres';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          return FilledButton(
                            onPressed: state.status == AuthStatus.loading
                                ? null
                                : _submit,
                            child: state.status == AuthStatus.loading
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : Text(
                                    _isLogin ? 'Iniciar sesión' : 'Registrarse',
                                  ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: _switchAuthMode,
                        child: Text(
                          _isLogin
                              ? '¿No tienes cuenta? Regístrate'
                              : '¿Ya tienes cuenta? Inicia sesión',
                        ),
                      ),
                      if (_isLogin) ..._buildForgotPassword(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildNameField() {
    return [
      CustomTextField(
        controller: _nameController,
        label: 'Nombre completo',
        prefixIcon: const Icon(Icons.person_outline),
        validator: (value) {
          if (!_isLogin && (value == null || value.isEmpty)) {
            return 'Por favor ingresa tu nombre';
          }
          return null;
        },
      ),
      const SizedBox(height: 16),
    ];
  }

  List<Widget> _buildForgotPassword() {
    return [
      TextButton(
        onPressed: _showResetPasswordDialog,
        child: const Text('¿Olvidaste tu contraseña?'),
      ),
    ];
  }

  void _showResetPasswordDialog() {
    final emailController = TextEditingController(text: _emailController.text);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restablecer contraseña'),
        content: TextField(
          controller: emailController,
          decoration: const InputDecoration(
            labelText: 'Correo electrónico',
            hintText: 'Ingresa tu correo para restablecer la contraseña',
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return TextButton(
                onPressed: state.status == AuthStatus.loading
                    ? null
                    : () {
                        final email = emailController.text.trim();
                        if (email.isNotEmpty && email.contains('@')) {
                          context
                              .read<AuthBloc>()
                              .add(AuthPasswordResetRequested(email));
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Se ha enviado un correo para restablecer tu contraseña',
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Por favor ingresa un correo electrónico válido',
                              ),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                child: state.status == AuthStatus.loading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Enviar'),
              );
            },
          ),
        ],
      ),
    );
  }
}
