import 'package:flutter/material.dart';
import 'package:gestion_tareas/Presentation/Pages/login_pages.dart';
import 'package:gestion_tareas/Presentation/Pages/tareas_page.dart';
import 'package:gestion_tareas/Presentation/Provider/tarea_provider.dart';
import 'package:gestion_tareas/Services/service_local.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String? usuario = await ServiceLocal.getUsuario();
  runApp(MyApp(initialUser: usuario));
}

class MyApp extends StatelessWidget {
  final String? initialUser;
  const MyApp({super.key, required this.initialUser});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TareaProvider()),
      ],
      child: MaterialApp(
        title: 'Gestor de Tareas',
        theme: ThemeData(primarySwatch: Colors.teal),
        home: initialUser == null ? const LoginPages() : const TareasPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
