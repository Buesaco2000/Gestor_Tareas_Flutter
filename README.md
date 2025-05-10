# Gestor de Tareas - Flutter App

Aplicación Flutter para gestionar tareas personales, con inicio de sesión simulado, sincronización con un backend falso, arquitectura limpia y estado manejado con Provider.

---

## Características

1. Inicio de sesión simulado
- El usuario ingresa su nombre de usuario (sin autenticación real).
- Se guarda la sesión localmente usando `SharedPreferences`.

2. Gestor de tareas
- CRUD completo:
  - Crear tareas con título, descripción, fecha de vencimiento y prioridad (alta, media, baja).
  - Editar y eliminar tareas.
  - Marcar tareas como completadas.
- Vista organizada por prioridad y estado.

3. Sincronización con backend simulado
- Simulación de llamadas a una API REST mediante un `FakeTaskRepository` con `Future.delayed`.

 Manejo de estado
- Utiliza `Provider` para manejar el estado de la sesión y de las tareas.
- Indicadores de carga (`CircularProgressIndicator`) durante operaciones asincrónicas.

5. Interfaz limpia y responsive
- Colores personalizados.
- Iconos contextuales (ej. check, editar, eliminar).
- Responsive para diferentes tamaños de pantalla.

---
lib/
├── domain/ # Modelos y entidades
├── data/ # Repositorios y fuente de datos falsa
├── presentation/ # Pantallas, widgets y lógica de UI
├── services/ # Manejo de sesión y almacenamiento local
└── main.dart # Punto de entrada

## Instrucciones de ejecución

## Tecnologías
- Flutter
- Provider
- SharedPreferences
- Clean Architecture

## Ejecución
1. Clona el repositorio.
2. Ejecuta `flutter pub get`.
3. Corre el proyecto: `flutter run`.



