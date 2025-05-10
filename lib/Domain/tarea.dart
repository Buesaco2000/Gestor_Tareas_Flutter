enum Priority { alta, media, baja }

class Tarea {
  String titulo;
  String descripcion;
  DateTime fecha;
  Priority prioridad;
  bool completado;

  Tarea({
    required this.titulo,
    required this.fecha,
    required this.descripcion,
    required this.prioridad,
    this.completado = false
  });
}
