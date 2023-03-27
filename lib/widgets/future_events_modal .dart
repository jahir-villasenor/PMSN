import 'package:flutter/material.dart';
import 'package:practica1/models/event_model.dart';
import 'package:practica1/widgets/modal_update_events.dart';
import 'package:practica1/widgets/modal_delete_events.dart';

import 'modal_add_post.dart';

openUpdateEventDialog(BuildContext context, EventModel? eventModel) {
  return showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(.5),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Transform.scale(
          scale: animation.value,
          child: Opacity(
            opacity: animation.value,
            child: ModalUpdateEvents(
              eventModel: eventModel,
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: ((context, animation, secondaryAnimation) {
        return Container();
      }));
}

openDeleteEventDialog(BuildContext context, EventModel? eventModel) {
  return showGeneralDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(.5),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return Transform.scale(
          scale: animation.value,
          child: Opacity(
            opacity: animation.value,
            child: ModalDeleteEvents(
              eventModel: eventModel,
            ),
          ),
        );
      },
      transitionDuration: Duration(milliseconds: 200),
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: ((context, animation, secondaryAnimation) {
        return Container();
      }));
}
