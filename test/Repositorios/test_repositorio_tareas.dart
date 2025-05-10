import 'package:flutter_test/flutter_test.dart';
import 'package:gestion_tareas/Domain/tarea.dart';
import 'package:gestion_tareas/Data/repositorio_tareas.dart';

void main() {
  group('RepositorioTareas', () {
    late RepositorioTareas repositorio;

    setUp(() {
      repositorio = RepositorioTareas();
    });

    test('Agregar tarea', () async {
      final tarea = Tarea(
        titulo: 'Comprar pan',
        descripcion: 'Ir a la panadería',
        fecha: DateTime.now(),
        prioridad: Priority.media,
      );

      await repositorio.addTareas(tarea);
      final tareas = await repositorio.getTareas();

      expect(tareas.length, 1);
      expect(tareas.first.titulo, 'Comprar pan');
    });

    test('Actualizar tarea', () async {
      final tareaOriginal = Tarea(
        titulo: 'Leer libro',
        descripcion: 'Terminar capítulo 4',
        fecha: DateTime.now(),
        prioridad: Priority.baja,
      );

      await repositorio.addTareas(tareaOriginal);

      final tareaActualizada = Tarea(
        titulo: 'Leer libro actualizado',
        descripcion: 'Capítulo 5 ahora',
        fecha: DateTime.now(),
        prioridad: Priority.alta,
      );

      await repositorio.updateTareas(0, tareaActualizada);
      final tareas = await repositorio.getTareas();

      expect(tareas[0].titulo, 'Leer libro actualizado');
      expect(tareas[0].prioridad, Priority.alta);
    });

    test('Eliminar tarea', () async {
      final tarea = Tarea(
        titulo: 'Hacer ejercicio',
        descripcion: '30 minutos de cardio',
        fecha: DateTime.now(),
        prioridad: Priority.alta,
      );

      await repositorio.addTareas(tarea);
      await repositorio.deleteTareas(0);
      final tareas = await repositorio.getTareas();

      expect(tareas.isEmpty, true);
    });

    test('Marcar tarea como completada', () async {
      final tarea = Tarea(
        titulo: 'Estudiar Flutter',
        descripcion: 'Widgets y estados',
        fecha: DateTime.now(),
        prioridad: Priority.media,
      );

      await repositorio.addTareas(tarea);

      final tareaCompletada = Tarea(
        titulo: tarea.titulo,
        descripcion: tarea.descripcion,
        fecha: tarea.fecha,
        prioridad: tarea.prioridad,
        completado: true,
      );

      await repositorio.updateTareas(0, tareaCompletada);
      final tareas = await repositorio.getTareas();

      expect(tareas[0].completado, true);
    });
  });
}
