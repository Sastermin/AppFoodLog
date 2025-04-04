import 'package:fluter_ui/pages/home_page.dart'; // Importa la página principal 
import 'package:flutter/material.dart'; // Importa los widgets de Flutter // Proporciona herramientas de depuración y utilidades para la plataforma
import 'package:supabase_flutter/supabase_flutter.dart'; // Manejo de autenticación con Supabase
import 'package:supabase_auth_ui/supabase_auth_ui.dart'; // Widgets preconstruidos para autenticación con Supabase

// Widget de estado para la página de autenticación
class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final supabase = Supabase.instance.client; // Instancia del cliente de Supabase
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'), // Título de la barra de navegación
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icono representativo de la app
                const Icon(
                  Icons.shopping_bag_outlined,
                  size: 80,
                  color: Colors.blue,
                ),
                const SizedBox(height: 30),
                // Texto de bienvenida
                const Text(
                  'Welcome to Our Store',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Widget de autenticación con email y contraseña de Supabase
                SupaEmailAuth(
                  redirectTo: 'https://yxfkpcithwditmmmkqvu.supabase.co/auth/v1/callback', // URL corregida
                  onSignInComplete: (response) {
                    // Navegar a la página principal después de iniciar sesión
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage(isGuest: false),
),
                    );
                  },
                  onSignUpComplete: (response) {
                    // Navegar a la página principal después de registrarse
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage(isGuest: false),
),
                    );
                  },
                  metadataFields: [
                    MetaDataField(
                      prefixIcon: const Icon(Icons.person),
                      label: 'Username', // Campo de nombre de usuario
                      key: 'username',
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'Please enter a username';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                
                const SizedBox(height: 20),
                // Separador visual entre autenticación con email y redes sociales
                const Text(
                  'OR',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Widget de autenticación con redes sociales (Google y Apple)
                SupaSocialsAuth(
                  socialProviders: [
                    OAuthProvider.google,
                    OAuthProvider.apple,
                  ],
                  colored: true, // Botones de colores según la red social
                  redirectUrl: 'https://yxfkpcithwditmmmkqvu.supabase.co/auth/v1/callback', // URL corregida
                  onSuccess: (Session response) {
                    // Navegar a la página principal tras autenticación exitosa
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage(isGuest: false),
                      ),
                    );
                  },
                  onError: (error) {
                    // Mostrar error en caso de fallo en autenticación
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(error.toString())),
                    );
                  },
                ),
                
                const SizedBox(height: 20),
                
                // Botón para continuar como invitado sin iniciar sesión
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const HomePage(isGuest: true),
                      ),
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                  ),
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


