import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yolo/model/reservation.dart';
import 'package:yolo/providers/user_provider.dart';
import 'package:yolo/screens/displayroom.dart';
import 'package:yolo/utils/constants.dart';
import 'package:yolo/utils/utils.dart';
import 'package:yolo/widgets/bottomAppBar.dart';
import 'package:yolo/widgets/displayroomreservation.dart';
import 'package:http/http.dart' as http;
import 'package:yolo/widgets/roomcardreservation.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  bool visible = false;
  Duration duration = const Duration(seconds: 10);
  Timer? timer;
  List<RoomReservation> reservedRoom = [];
  @override
  void initState() {
    super.initState();
    fetch();
  }

  Future<void> fetch() async {
    try {
      final user = Provider.of<UserProvider>(context, listen: false).user.email;

      final response = await http.get(Uri.parse('${Constants.uri}/res/$user'));
      if (response.statusCode == 200) {
        setState(() {
          reservedRoom = parseReservationFromJson(response.body);

          visible = true;
        });
        timer?.cancel();
      } else {
        throw Exception('Failed to load rooms: ${response.statusCode}');
      }
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  void displayScreen(RoomReservation room, BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DisplayRoomReservation(room: room)));
  }

  void checkEmptyList() {
    if (reservedRoom.isEmpty) {
      setState(() {});
    }
  }

  void removeFav(String id) async {
    try {
      final response = await http.delete(Uri.parse('${Constants.uri}/res/$id'));
      if (response.statusCode == 200) {
        setState(() {
          reservedRoom.removeWhere((room) => room.id == id); // Remove from list
        });
        showSnackBar(context, 'Deleted');
      } else {
        throw Exception('Failed to load rooms: ${response.statusCode}');
      }
    } catch (error) {
      showSnackBar(context, error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    timer ??= Timer.periodic(duration, (timer) {
      fetch();
    });

    return Scaffold(
        appBar: AppBar(
          title: const Text('Favorites'),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: Scaffold(
          body: Visibility(
              visible: visible,
              replacement: Container(
                margin: const EdgeInsets.symmetric(vertical: 100),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              child: reservedRoom.isEmpty
                  ? const Center(
                      child: Text(
                        'Oh Nothing Found Here!!',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: reservedRoom.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Dismissible(
                          key: ValueKey(reservedRoom[index].id),
                          onDismissed: (direction) =>
                              removeFav(reservedRoom[index].id),
                          background: Container(
                            color: Colors.red,
                          ),
                          child: RoomCardResrvation(
                              room: reservedRoom[index], onTap: displayScreen),
                        ),
                      ),
                    )),
        ));
  }
}
