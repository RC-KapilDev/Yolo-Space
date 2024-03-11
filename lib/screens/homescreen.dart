import 'dart:async';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:yolo/providers/user_provider.dart';
import 'package:yolo/screens/account.dart';
import 'package:yolo/screens/fav.dart';
import 'package:yolo/utils/utils.dart';
import 'package:yolo/widgets/roomcard.dart';
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
    timer = Timer.periodic(duration, (Timer timer) {
      fetchData();
    });
  }

  Future<void> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('https://sore-jade-jay-wig.cyclic.app/yolo/rooms'));
      if (response.statusCode == 200) {
        setState(() {
          rooms = parseRoomsFromJson(response.body);

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

  void displayScreen(Room room, BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DisplayRoom(room: room)));
  }

  Future<void> refreshData() async {
    await fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    timer ??= Timer.periodic(duration, (timer) {
      fetchData();
    });
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Container(
          color: const Color.fromARGB(255, 96, 104, 189),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: GNav(
              gap: 8,
              tabBackgroundColor: Colors.black,
              backgroundColor: const Color.fromARGB(255, 96, 104, 189),
              color: Colors.white,
              activeColor: Colors.white,
              onTabChange: (index) {
                if (index == 0 && Navigator.canPop(context)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                  );
                }
                if (index == 1) {
                  if (rooms.isNotEmpty) {
                    showSearch(
                        context: context,
                        delegate: MySearchDelegate(roomList: rooms));
                  }
                }
                if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Favorite(),
                    ),
                  );
                }

                if (index == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Account(),
                    ),
                  );
                }
              },
              padding: const EdgeInsets.all(15),
              tabs: const [
                GButton(
                  icon: Icons.home_outlined,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.search_outlined,
                  text: 'Search',
                ),
                GButton(
                  icon: Icons.favorite_outline,
                  text: 'Favorite',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Account',
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          toolbarHeight: 120,
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Yolo'),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.location_on))
                ],
              ),
              GestureDetector(
                onTap: () {
                  if (rooms.isNotEmpty) {
                    showSearch(
                        context: context,
                        delegate: MySearchDelegate(roomList: rooms));
                  } else {
                    showSearch(
                        context: context,
                        delegate: MySearchDelegate(roomList: rooms));
                  }
                },
                child: Card(
                  color: const Color.fromARGB(255, 0, 0, 0),
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
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            )),
                        const Text(
                          'Search By Location ...',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 255, 255, 255)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: refreshData,
          child: ListView(
            children: [
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
        ),
      ),
    );
  }
}




//  List<String> test = [
//     'Dates',
//     'Gustes',
//     'Type Of Place',
//     'Price',
//     'Quality',
//     'bello',
//     'bello',
//     'bello',
//     'bello',
//     'bello',
//     'bello',
//     'bello',
//   ];


//  Container(
//             margin: const EdgeInsets.symmetric(horizontal: 28),
//             height: 50,
//             child: ListView.separated(
//                 separatorBuilder: (context, index) => const SizedBox(
//                       width: 10,
//                     ),
//                 scrollDirection: Axis.horizontal,
//                 itemCount: test.length,
//                 itemBuilder: (context, index) {
//                   return Card(
//                     elevation: 3.0,
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: Center(child: Text(test[index])),
//                     ),
//                   );
//                 }),
//           ),



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