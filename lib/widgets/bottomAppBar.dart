// ignore: file_names
import 'package:flutter/material.dart';
import 'package:yolo/screens/displayroom.dart';
import 'package:yolo/services/reservation_services.dart';
import 'package:yolo/utils/utils.dart';

class BottomAppBarNav extends StatelessWidget {
  const BottomAppBarNav({
    super.key,
    required this.widget,
    required this.context,
  });

  final DisplayRoom widget;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color.fromARGB(255, 96, 104, 189),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text(
            'Token Amount: 1000',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              ReservationServices reservation = ReservationServices();
              reservation.addReservation(widget.room, context);
              showSnackBar(context, 'Add to Favorites');
            },
            child: const Text(
              'Reserve Room',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
