import 'package:flutter/material.dart';

class LoadingModalWidget extends StatelessWidget {
  const LoadingModalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(200, 100, 100, 100),
      child: Center(
        child: Image.asset('assets/loading.gif'),
      )
    );
  }
}

Future<Object?> showLoadingModal(BuildContext context){
  return showGeneralDialog(
          barrierColor: const Color.fromARGB(200, 100, 100, 100),
          transitionDuration: const Duration(milliseconds: 3000),
          context: context, 
          pageBuilder: (context, animation, secondaryAnimation) {
            return Center(
              child: Image.asset('assets/loading.gif'),
            );
          }
        );
}