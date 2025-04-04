// Importaciones necesarias
import 'dart:async'; // Para manejar suscripciones y streams
import 'package:fluter_ui/pages/home_page.dart'; // Página principal del usuario
import 'package:fluter_ui/pages/register_page.dart'; // Página de registro
import 'package:flutter/material.dart'; // Widgets y componentes de Flutter
import 'package:supabase_flutter/supabase_flutter.dart'; // Supabase para autenticación

// Clase LoginPage, un StatefulWidget para manejar estado
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

// Estado interno de LoginPage
class _LoginPageState extends State<LoginPage> {
  // Controladores para capturar los valores de los campos de texto (email y contraseña)
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Indicadores de estado de carga y redirección
  bool _isLoading = false;
  bool _redirecting = false;

  // Suscripción al stream de cambios de autenticación de Supabase
  late final StreamSubscription<AuthState> _authStateSubscription;

  // Instancia del cliente de Supabase
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    // Escuchamos cambios en el estado de autenticación (por ejemplo, si el usuario inicia sesión)
    _authStateSubscription = supabase.auth.onAuthStateChange.listen((data) {
      // Si ya se está redirigiendo, no hacer nada
      if (_redirecting) return;

      final session = data.session;
      // Si hay una sesión activa, redirigir a la página principal
      if (session != null) {
        _redirecting = true;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomePage(isGuest: false),
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    // Liberamos recursos cuando se destruye el widget
    _emailController.dispose();
    _passwordController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

  // Método para iniciar sesión usando email y contraseña
  Future<void> _signIn() async {
    // Verificamos si los campos están vacíos
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    try {
      // Indicamos que estamos cargando
      setState(() {
        _isLoading = true;
      });

      // Intentamos iniciar sesión con Supabase
      await supabase.auth.signInWithPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

    } on AuthException catch (error) {
      // En caso de error de autenticación, mostramos el mensaje
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message)),
        );
      }
    } catch (error) {
      // En caso de error desconocido, mostramos mensaje genérico
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unexpected error occurred')),
        );
      }
    } finally {
      // Dejamos de mostrar el indicador de carga
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Método para continuar como invitado
  Future<void> _signInAnonymously() async {
    try {
      setState(() {
        _isLoading = true;
      });

      // Redirigimos a la página principal como invitado
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const HomePage(isGuest: true),
        ),
      );
    } catch (error) {
      // Mostramos mensaje en caso de error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Unexpected error occurred')),
        );
      }
    } finally {
      // Finalizamos el estado de carga
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  // Método para ir a la página de registro
  void _goToRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Construimos la interfaz de usuario
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Icono representativo
                const Icon(
                  Icons.shopping_bag_outlined,
                  size: 80,
                  color: Colors.blue,
                ),
                const SizedBox(height: 30),
                // Mensaje de bienvenida
                const Text(
                  'Welcome Back',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                // Campo de texto para email
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                // Campo de texto para contraseña
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true, // Oculta el texto
                ),
                const SizedBox(height: 24),
                // Botón para iniciar sesión
                ElevatedButton(
                  onPressed: _isLoading ? null : _signIn,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator() // Indicador de carga
                      : const Text('Sign In', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 16),
                // Botón para crear cuenta
                OutlinedButton(
                  onPressed: _isLoading ? null : _goToRegister,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text('Create Account', style: TextStyle(fontSize: 16)),
                ),
                const SizedBox(height: 16),
                // Botón para continuar como invitado
                TextButton(
                  onPressed: _isLoading ? null : _signInAnonymously,
                  child: const Text('Continue as Guest', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

