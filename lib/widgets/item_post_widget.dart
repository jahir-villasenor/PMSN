import 'package:flutter/material.dart';

import '../models/post_model.dart';

class ItemPostWidget extends StatelessWidget {
  ItemPostWidget({super.key, this.postModel});

  PostModel? postModel;

  @override
  Widget build(BuildContext context) {
    final iconMore = Icon(
      Icons.more_horiz,
      size: 35,
    );

    final cardDesc = Container(
      height: 150,
      color: Colors.green,
    );

    final rowFooter = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text(
          'Fecha: ',
          style: TextStyle(fontSize: 18),
        ),
        Icon(Icons.thumb_up)
      ],
    );

    final ribbonTop = ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        child: Container(
          padding: EdgeInsets.only(right: 10),
          alignment: Alignment.centerRight,
          height: 50,
          width: double.infinity,
          child: iconMore,
          color: Colors.green[200],
        ));

    final ribbonBottom = ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.centerRight,
          height: 50,
          width: double.infinity,
          child: rowFooter,
          color: Colors.green[200],
        ));

    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        //padding: EdgeInsets.all(10),
        height: 250,
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(color: Colors.grey, blurRadius: 7, offset: Offset(0, 8)),
        ], color: Colors.green, borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [ribbonTop, cardDesc, ribbonBottom],
        ),
      ),
    );
  }
}
