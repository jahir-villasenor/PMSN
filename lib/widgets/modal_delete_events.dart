import 'package:flutter/material.dart';
import 'package:practica1/database/database_helper.dart';
import 'package:provider/provider.dart';
import '../models/event_model.dart';
import '../provider/flags_provider.dart';

class ModalDeleteEvents extends StatefulWidget {
  ModalDeleteEvents({Key? key, this.eventModel}) : super(key: key);
  EventModel? eventModel;

  @override
  State<ModalDeleteEvents> createState() => _ModalDeleteEventsState();
}

class _ModalDeleteEventsState extends State<ModalDeleteEvents> {
  final database = DatabaseHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final flags = Provider.of<FlagsProvider>(context);
    final eventModel = widget.eventModel;

    return AlertDialog(
      title: const Text('¿Deseas borrar la publicación?'),
      content: SizedBox(
        height: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () async {
                await database.ELIMINAR(
                    'tblEvents', eventModel!.idEvents!, 'idEvents');
                Navigator.pop(context);
                flags.setflagListPost();
              },
              child: const Text('Aceptar'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
          ],
        ),
      ),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
