class EventModel {
  int? idEvents;
  String? dscEvents;
  String? dateEvents;
  int? finished;

  EventModel({this.idEvents, this.dscEvents, this.dateEvents, this.finished});

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      idEvents: map['idEvents'],
      dscEvents: map['dscEvents'],
      dateEvents: map['dateEvents'],
      finished: map['finished'] == 1 ? 1 : 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idEvents': idEvents,
      'dscEvents': dscEvents,
      'dateEvents': dateEvents,
      'finished': finished == 1 ? 1 : 0,
    };
  }
}
