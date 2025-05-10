import 'package:flutter/foundation.dart';
import 'package:gestion_tareas/Data/repositorio_tareas.dart';
import 'package:gestion_tareas/Domain/tarea.dart';

class TareaProvider extends ChangeNotifier {
  final RepositorioTareas _repositorio = RepositorioTareas();
  List<Tarea> _tarea = [];
  bool _loading = false;

  List<Tarea> get tarea => _tarea;
  bool get isLoading => _loading;

  Future<void> cargarTareas() async {
    _loading = true;
    notifyListeners();
    _tarea = await _repositorio.getTareas();
    _loading = false;
    notifyListeners();
  }

  Future<void> addTarea(Tarea tarea) async {
    _loading = true;
    notifyListeners();
    await _repositorio.addTareas(tarea);
    await cargarTareas();
  }

  Future<void> updateTarea(int index, Tarea tarea) async {
    _loading = true;
    notifyListeners();
    await _repositorio.updateTareas(index, tarea);
    await cargarTareas();
  }

  Future<void> deleteTarea(int index) async {
    _loading = true;
    notifyListeners();
    await _repositorio.deleteTareas(index);
    await cargarTareas();
  }
}
