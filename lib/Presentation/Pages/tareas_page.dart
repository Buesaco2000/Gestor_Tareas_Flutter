import 'package:flutter/material.dart';
import 'package:gestion_tareas/Domain/tarea.dart';
import 'package:gestion_tareas/Presentation/Provider/tarea_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class TareasPage extends StatefulWidget {
  const TareasPage({super.key});

  @override
  State<TareasPage> createState() => _TareasPageState();
}

class _TareasPageState extends State<TareasPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<TareaProvider>(context, listen: false).cargarTareas();
  }

  void _addTareaDialog(BuildContext context) {
    final tituController = TextEditingController();
    final descController = TextEditingController();
    Priority prioridad = Priority.media;
    DateTime fecha = DateTime.now();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Nueva Tarea",
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: tituController,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<Priority>(
                  value: prioridad,
                  decoration: const InputDecoration(
                    labelText: "Prioridad",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    if (value != null) setState(() => prioridad = value);
                  },
                  items: Priority.values
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.name)))
                      .toList(),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: fecha,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() => fecha = picked);
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                  label: Text(
                      "Fecha Vencimiento: ${DateFormat('dd/MM/yyyy').format(fecha)}"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(40),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              final tarea = Tarea(
                titulo: tituController.text,
                descripcion: descController.text,
                fecha: fecha,
                prioridad: prioridad,
              );
              Provider.of<TareaProvider>(context, listen: false)
                  .addTarea(tarea);
              Navigator.pop(context);
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }

  void _editTareaDialog(BuildContext context, int index, Tarea tarea) {
    final tituController = TextEditingController(text: tarea.titulo);
    final descController = TextEditingController(text: tarea.descripcion);
    Priority prioridad = tarea.prioridad;
    DateTime fecha = tarea.fecha;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text("Editar Tarea",
            style: TextStyle(fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: tituController,
                  decoration: const InputDecoration(
                    labelText: 'Título',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: descController,
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<Priority>(
                  value: prioridad,
                  decoration: const InputDecoration(
                    labelText: "Prioridad",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    if (value != null) setState(() => prioridad = value);
                  },
                  items: Priority.values
                      .map((e) =>
                          DropdownMenuItem(value: e, child: Text(e.name)))
                      .toList(),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: fecha,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() => fecha = picked);
                    }
                  },
                  icon: const Icon(Icons.calendar_today),
                  label:
                      Text("Fecha: ${DateFormat('dd/MM/yyyy').format(fecha)}"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(40),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancelar"),
          ),
          ElevatedButton(
            onPressed: () {
              final updated = Tarea(
                titulo: tituController.text,
                descripcion: descController.text,
                fecha: fecha,
                prioridad: prioridad,
                completado: tarea.completado,
              );
              Provider.of<TareaProvider>(context, listen: false)
                  .updateTarea(index, updated);
              Navigator.pop(context);
            },
            child: const Text("Guardar"),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.alta:
        return Colors.redAccent;
      case Priority.media:
        return Colors.orangeAccent;
      case Priority.baja:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TareaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mis Tareas"),
        backgroundColor: Colors.blueAccent,
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: provider.tarea.length,
              itemBuilder: (_, index) {
                final tarea = provider.tarea[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(
                        tarea.completado
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: tarea.completado ? Colors.green : Colors.grey,
                      ),
                      onPressed: () {
                        tarea.completado = !tarea.completado;
                        provider.updateTarea(index, tarea);
                      },
                    ),
                    title: Text(tarea.titulo),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tarea.descripcion),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.date_range,
                                size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(DateFormat('dd/MM/yyyy').format(tarea.fecha)),
                            const SizedBox(width: 12),
                            Icon(Icons.flag,
                                size: 16,
                                color: _getPriorityColor(tarea.prioridad)),
                            const SizedBox(width: 4),
                            Text(tarea.prioridad.name),
                          ],
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.amber),
                          onPressed: () =>
                              _editTareaDialog(context, index, tarea),
                        ),
                        IconButton(
                          icon:
                              const Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => provider.deleteTarea(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addTareaDialog(context),
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
