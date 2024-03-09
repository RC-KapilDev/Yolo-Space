import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:provider/provider.dart';
import 'package:yolo/model/dataModel.dart';
import 'package:yolo/model/reservation.dart';
import 'package:yolo/providers/user_provider.dart';

class ReservationServices {
  List<RoomReservation> roomRes = [];
  void addReservation(Room room, BuildContext context) async {
    try {
      final List<String> amenities =
          room.amenities.map((amenity) => amenity.name).toList();

      Map<String, dynamic> resevation = {
        'email': Provider.of<UserProvider>(context, listen: false).user.email,
        'sex': room.sex.name,
        'amenities': amenities,
        'roomtype': room.roomType.name,
        'location': room.location,
        'rent': room.rent,
        'address': room.address,
        'image': room.image
      };

      http.Response response = await http.post(
        Uri.parse('https://sore-jade-jay-wig.cyclic.app/res/rooms'),
        body: json.encode(resevation),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        print('Reservation successful');
      } else {
        print('Reservation failed: ${response.body}');
      }
    } catch (e) {
      print('Error making reservation: $e');
    }
  }

  void getReservation() async {
    final response = await http
        .get(Uri.parse('http://192.168.56.1:3000/res/rckapildev8@gmail.com'));
    roomRes = parseReservationFromJson(response.body);
  }
}
