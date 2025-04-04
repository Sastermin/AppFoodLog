import 'package:fluter_ui/auth_page.dart';
import 'package:fluter_ui/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // Asegura que las inicializaciones de Flutter se completen antes de ejecutar cualquier cosa
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializa Supabase con la URL de tu proyecto y la clave anónima
  await Supabase.initialize(
    url: 'https://yxfkpcithwditmmmkqvu.supabase.co', // URL del proyecto Supabase
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inl4ZmtwY2l0aHdkaXRtbW1rcXZ1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDMxNzA3NTQsImV4cCI6MjA1ODc0Njc1NH0.u_sOyBln0gfiIS-KpoTu6c4DoIG8biBNGXFAEwkYdJg', // Clave anónima
  );
  
  // Corre la aplicación Flutter después de la inicialización de Supabase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth Demo', // Título de la aplicación
      theme: ThemeData(
        primarySwatch: Colors.blue, // Color principal de la aplicación
        useMaterial3: true, // Usa Material 3 para el diseño visual
      ),
      home: StreamBuilder<AuthState>( // Usa un StreamBuilder para escuchar los cambios de estado de autenticación
        stream: Supabase.instance.client.auth.onAuthStateChange, // Escucha los cambios en el estado de autenticación
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Muestra un indicador de carga mientras se espera el estado de autenticación
            return const Center(child: CircularProgressIndicator());
          }
          
          // Si ya hay una sesión activa, redirige al usuario a la página principal
          if (snapshot.hasData && snapshot.data!.session != null) {
            return HomePage(isGuest: false);
// Si el usuario está autenticado, muestra la página principal
          }
          
          // Si no hay sesión, muestra la página de autenticación
          return const AuthPage(); // Si no hay sesión activa, muestra la página de login
        },
      ),
    );
  }
}





