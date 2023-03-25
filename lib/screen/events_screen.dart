import 'package:flutter/material.dart';
import 'package:practica1/database/database_helper.dart';
import 'package:practica1/models/event_model.dart';
import 'package:practica1/provider/flags_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class EventsScreen extends StatefulWidget {
  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>
    with TickerProviderStateMixin {
  CalendarView _calendarView = CalendarView.month;
  Key _calendarKey = UniqueKey();

  database_helper? databaseHelper;

  List<EventModel> _eventModel = [];

  DateTime? _seletedDate;

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    databaseHelper = database_helper();
    _recuperarEventos();
  }

  void _recuperarEventos() async {
    List<EventModel> eventModel = await databaseHelper!.getAllEventos();
    setState(() {
      _eventModel = eventModel;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FlagsProvider flag = Provider.of<FlagsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mis eventos',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        actions: [
          ToggleButtons(
            children: [
              Icon(Icons.calendar_month),
              Icon(Icons.list),
            ],
            isSelected: [
              _calendarView == CalendarView.month,
              _calendarView == CalendarView.schedule,
            ],
            onPressed: (index) {
              setState(() {
                if (index == 0) {
                  _calendarView = CalendarView.month;
                  _calendarKey = UniqueKey();
                } else if (index == 1) {
                  _calendarView = CalendarView.schedule;
                  _calendarKey = UniqueKey();
                }
              });
            },
          ),
        ],
      ),
      body: SfCalendar(
        key: _calendarKey,
        view: _calendarView,
        dataSource: _DataSource(_eventModel),
        onTap: (calendarTapDetails) {
          if (calendarTapDetails.targetElement ==
              CalendarElement.calendarCell) {
            setState(() {
              _seletedDate = calendarTapDetails.date;
            });
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Agregar evento',
                    style: Theme.of(context).textTheme.bodyLarge),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Fecha para el evento: ${DateFormat('dd/MM/yyyy').format(_seletedDate!)}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    TextFormField(
                      style: Theme.of(context).textTheme.bodyLarge,
                      decoration:
                          InputDecoration(labelText: 'Descripcion del evento'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ingrese la descripcion del evento';
                        }
                        return null;
                      },
                      controller: _controller,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () async {
                              if (_controller.text.isNotEmpty) {
                                final event = EventModel(
                                    descEvento: _controller.text,
                                    fechaEvento:
                                        _seletedDate!.toIso8601String(),
                                    completado: 0);
                                await databaseHelper!
                                    .INSERTAR('tblEvents', event.toMap());
                                _controller.clear();
                                Navigator.pop(context);
                                _recuperarEventos();
                                setState(() {});
                                flag.setupdatePosts();
                              }
                            },
                            child: Text(
                              'Agregar',
                              style: Theme.of(context).textTheme.bodyLarge,
                            )),
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancelar',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ))
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        label: const Text('Add event'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<EventModel> eventModel) {
    appointments = eventModel.map((event) {
      DateTime dateTime = DateTime.parse(event.fechaEvento!);
      return Appointment(
          startTime: dateTime,
          endTime: dateTime.add(Duration(hours: 1)),
          subject: event.descEvento!,
          isAllDay: false,
          color: event.completado! == 1 ? Colors.grey : Colors.blue);
    }).toList();
  }
}
