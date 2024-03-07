import 'dart:async';
import 'package:provider/provider.dart';
import 'package:yolo/providers/user_provider.dart';

import '../widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:yolo/model/dataModel.dart';
import 'package:yolo/screens/displayroom.dart';
import 'package:http/http.dart' as http;

import 'package:yolo/screens/searchscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => __HomeScreenState();
}

class __HomeScreenState extends State<HomeScreen> {
  List<Room> rooms = [];
  bool visible = false;
  Duration duration = const Duration(seconds: 10);
  Timer? timer;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('https://sore-jade-jay-wig.cyclic.app/yolo/rooms'));
      if (response.statusCode == 200) {
        setState(() {
          rooms = parseRoomsFromJson(response.body);
          visible = true; // Set visible to true after data is loaded
        });
        timer?.cancel();
      } else {
        // Handle non-200 status codes gracefully
        throw Exception('Failed to load rooms: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network errors or parsing errors

      // You can show a snackbar or dialog to inform the user about the error
    }
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  void displayScreen(Room room, BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DisplayRoom(room: room)));
  }

  List<String> test = [
    'Dates',
    'Gustes',
    'Type Of Place',
    'Price',
    'Quality',
    'bello',
    'bello',
    'bello',
    'bello',
    'bello',
    'bello',
    'bello',
  ];
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    timer ??= Timer.periodic(duration, (timer) {
      // Call fetchData periodically
      fetchData();
    });
    return Scaffold(
      drawer: const NavigationScreenDrawer(),
      appBar: AppBar(
        title: Container(
          margin: const EdgeInsets.only(top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Yolo'),
              IconButton(onPressed: () {}, icon: const Icon(Icons.location_on))
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
              margin: const EdgeInsets.all(18),
              child: GestureDetector(
                onTap: () {
                  if (rooms.isNotEmpty) {
                    showSearch(
                        context: context,
                        delegate: MySearchDelegate(roomList: rooms));
                  } else {
                    showSearch(
                        context: context,
                        delegate: MySearchDelegate(roomList: Rooms));
                  }
                },
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              if (rooms.isNotEmpty) {
                                showSearch(
                                    context: context,
                                    delegate:
                                        MySearchDelegate(roomList: rooms));
                              }
                            },
                            icon: const Icon(Icons.search)),
                        const Text('Search By Location ...'),
                      ],
                    ),
                  ),
                ),
              )),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 28),
            height: 50,
            child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                      width: 10,
                    ),
                scrollDirection: Axis.horizontal,
                itemCount: test.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 3.0,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(child: Text(test[index])),
                    ),
                  );
                }),
          ),
          Visibility(
            visible: visible,
            replacement: Container(
              margin: const EdgeInsets.symmetric(vertical: 100),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            child: Column(
              children: rooms
                  .map((e) => RoomCard(room: e, onTap: displayScreen))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }
}

const kfontSizeDiscount = TextStyle(fontSize: 10);

class RoomCard extends StatelessWidget {
  const RoomCard({super.key, required this.room, required this.onTap});
  final Room room;
  final void Function(Room room, BuildContext context) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(room, context);
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 242, 240, 245)),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        height: 270,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                child: Image.network(
                  room.image[0],
                  height: 270,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        room.roomType.name.toUpperCase(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        room.location[0],
                        textAlign: TextAlign.center,
                      ),
                      Text(room.location[1]),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: const Divider(
                      thickness: 0.9,
                      color: Color.fromARGB(255, 24, 23, 23),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(room.sex.name.toUpperCase()),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Monthly Rent '),
                      Row(
                        children: [
                          Text(
                            room.rent.toString(),
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          const Text(' Onwards'),
                        ],
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 138, 227, 141),
                        borderRadius: BorderRadius.circular(5)),
                    child: const Row(
                      children: [
                        SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.discount,
                          size: 15,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          'Upto',
                          style: kfontSizeDiscount,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          '20%',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 12),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text(
                          'Off',
                          style: TextStyle(fontSize: 10),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


// Visibility(
//             visible: visible,
//             child: RoomCard(
//               room: rooms[0],
//               onTap: DisplayScreen,
//             ),
//             replacement: const Center(
//               child: CircularProgressIndicator(),
//             ),
//           ),
//           const SizedBox(
//             height: 50,
//           ),
//           RoomCard(
//             room: rooms[1],
//             onTap: DisplayScreen,
//           ),