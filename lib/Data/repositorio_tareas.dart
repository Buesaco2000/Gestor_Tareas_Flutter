import 'package:gestion_tareas/Domain/tarea.dart';

class RepositorioTareas {
  final List<Tarea> _tarea = [];

  Future<List<Tarea>> getTareas() async {
    await Future.delayed(const Duration(seconds: 2));
    return List.from(_tarea);
  }

  Future<void> addTareas(Tarea tarea) async {
    await Future.delayed(const Duration(seconds: 1));
    _tarea.add(tarea);
  }

  Future<void> updateTareas(int index, Tarea tarea) async {
    await Future.delayed(const Duration(seconds: 1));
    _tarea[index] = tarea;
  }

  Future<void> deleteTareas(int index) async {
    await Future.delayed(const Duration(seconds: 1));
    _tarea.removeAt(index);
  }
}
