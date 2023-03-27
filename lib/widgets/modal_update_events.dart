import 'package:flutter/material.dart';
import 'package:practica1/database/database_helper.dart';
import 'package:provider/provider.dart';
import '../models/event_model.dart';
import '../provider/flags_provider.dart';

class ModalUpdateEvents extends StatefulWidget {
  ModalUpdateEvents({super.key, this.eventModel});

  EventModel? eventModel;

  @override
  State<ModalUpdateEvents> createState() => _ModalUpdateEventsState();
}

class _ModalUpdateEventsState extends State<ModalUpdateEvents> {
  EventModel? eventModel;

  database_helper database = database_helper();
  TextEditingController txtDescEvent = TextEditingController();

  @override
  void initState() {
    super.initState();
    final txtdscEvent = TextEditingController();
    if (ModalRoute.of(context)!.settings.arguments != null) {
      eventModel = ModalRoute.of(context)!.settings.arguments as EventModel;
      txtdscEvent.text = eventModel!.dscEvents.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flags = Provider.of<FlagsProvider>(context);

    return AlertDialog(
      title: Text('Editing Event'),
      content: SizedBox(
        height: 180,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextFormField(
              controller: txtDescEvent,
              maxLines: 5,
            ),
            IconButton(
                onPressed: () {
                  database!
                      .ACTUALIZAR(
                          'tblEvents',
                          {
                            'idEvents': eventModel!.idEvents,
                            'dscEvents': txtDescEvent.text.toString(),
                            'dateEvents': eventModel!.dateEvents,
                            'finished': eventModel!.finished,
                          },
                          'idEvents')
                      .then((value) {
                    var msg = value > 0
                        ? 'Registro Actualizado!'
                        : 'Ocurrio un error!';
                    final snackBar = SnackBar(content: Text(msg));
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    flags.setupdatePosts();
                  });
                },
                icon: Icon(Icons.add))
          ],
        ),
      ),
      shape: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
