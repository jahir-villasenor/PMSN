import 'package:flutter/material.dart';
import 'package:practica1/database/database_helper.dart';
import 'package:practica1/models/event_model.dart';
import 'package:practica1/provider/flags_provider.dart';
import 'package:practica1/widgets/future_events_modal%20.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen>
    with TickerProviderStateMixin {
  String? _subjectText = '',
      _startTimeText = '',
      _endTimeText = '',
      _dateText = '',
      _timeDetails = '';
  CalendarView _calendarView = CalendarView.month;
  Key _calendarKey = UniqueKey();

  DatabaseHelper? databaseHelper;

  DatabaseHelper _database = DatabaseHelper();

  EventModel? eventModel;

  List<EventModel> _eventModel = [];

  DateTime? _seletedDate;

  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
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
        monthViewSettings: const MonthViewSettings(
            showAgenda: true,
            showTrailingAndLeadingDates: false,
            monthCellStyle: MonthCellStyle(
              backgroundColor: Color.fromARGB(255, 54, 94, 121),
              todayBackgroundColor: Colors.green,
              textStyle: TextStyle(fontSize: 12, fontFamily: 'Arial'),
              todayTextStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Arial'),
            )),
        scheduleViewSettings: const ScheduleViewSettings(
            hideEmptyScheduleWeek: false,
            monthHeaderSettings: MonthHeaderSettings(
              height: 70,
              textAlign: TextAlign.center,
              backgroundColor: Colors.green,
            )),
        dataSource: _DataSource(_eventModel),
        onTap: (calendarTapDetails) {
          if (CalendarView.month == _calendarView) {
            if (calendarTapDetails.targetElement ==
                CalendarElement.calendarCell) {
              setState(() {
                _seletedDate = calendarTapDetails.date;
              });
            }
          } else if (CalendarView.schedule == _calendarView) {
            calendarTapped(calendarTapDetails);
          }
        },
        cellEndPadding: 40,
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
                                    dscEvents: _controller.text,
                                    dateEvents: _seletedDate!.toIso8601String(),
                                    finished: 0);
                                await databaseHelper!
                                    .INSERTAR('tblEvents', event.toMap());
                                _controller.clear();
                                Navigator.pop(context);
                                _recuperarEventos();
                                setState(() {});
                                flag.setflagListPost();
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
        backgroundColor: Colors.green,
      ),
    );
  }

  void calendarTapped(CalendarTapDetails details) {
    final spaceHorizontal = const SizedBox(
      height: 20,
    );

    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Appointment appointmentDetails = details.appointments![0];
      _subjectText = appointmentDetails.subject;
      _dateText = DateFormat('MMMM dd, yyyy')
          .format(appointmentDetails.startTime)
          .toString();
      _startTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.startTime).toString();
      _endTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.endTime).toString();
      _timeDetails = '$_startTimeText - $_endTimeText';
    } else if (details.targetElement == CalendarElement.calendarCell) {
      _subjectText = "You have tapped cell";
      _dateText = DateFormat('MMMM dd, yyyy').format(details.date!).toString();
      _timeDetails = '';
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Container(
              alignment: Alignment.topRight,
              child: PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    const PopupMenuItem<int>(child: Text('Editar'), value: 0),
                    const PopupMenuItem<int>(child: Text('Borrar'), value: 1),
                  ];
                },
                onSelected: (value) {
                  switch (value) {
                    case 0:
                      openUpdateEventDialog(context, eventModel);
                      break;

                    case 1:
                      openDeleteEventDialog(context, eventModel);
                      break;
                  }
                },
              ),
            ),
            content: Container(
              height: 150,
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Descripción: $_subjectText',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Text('Fecha: $_dateText',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 10)),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    child: Row(
                      children: <Widget>[
                        Text(_timeDetails!,
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 10)),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            setState(() {
                              eventModel?.finished = 1;
                            });
                            Navigator.of(context).pop();
                          },
                          child: Text('Finalizar evento',
                              style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text('Close'))
            ],
          );
        });
  }
}

class _DataSource extends CalendarDataSource {
  _DataSource(List<EventModel> eventModel) {
    appointments = eventModel.map((event) {
      DateTime dateTime = DateTime.parse(event.dateEvents!);
      int difference = dateTime.difference(DateTime.now()).inDays;
      Color color = Colors.green;
      if (difference == 0) {
        color = Colors.green;
      } else if (difference < 0 && event.finished! == 0) {
        color = Colors.red;
      } else if (difference <= 2) {
        color = Colors.yellow;
      }

      return Appointment(
          startTime: dateTime,
          endTime: dateTime.add(Duration(hours: 1)),
          subject: event.dscEvents!,
          isAllDay: false,
          color: color);
    }).toList();
  }
}
