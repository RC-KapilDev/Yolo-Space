import 'package:flutter/material.dart';
import 'package:yolo/model/dataModel.dart';
import 'package:yolo/services/reservation_services.dart';
import 'package:yolo/utils/utils.dart';
import 'package:yolo/widgets/displayroomtypes.dart';
import 'package:yolo/widgets/divideline.dart';
import 'package:yolo/widgets/displayroomTile.dart';
import 'package:yolo/widgets/carousel.dart';

const kcolortextdisplayroom = TextStyle(
  color: Colors.white,
);

class DisplayRoom extends StatefulWidget {
  const DisplayRoom({super.key, required this.room});
  final Room room;

  @override
  State<DisplayRoom> createState() => _DisplayRoomState();
}

class _DisplayRoomState extends State<DisplayRoom> {
  bool isExpanded = false;
  bool roomTypeExpanded = false;
  bool locationExpanded = false;
  @override
  Widget build(BuildContext context) {
    final roomObj = widget.room;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50,
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: bottomAppBar(),
      body: ListView(children: [
        Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            Carousel(
              imageUrls: widget.room.image,
            ),
            DisplayRoomTile(widget: widget, roomObj: roomObj),
            const DividerLine(),
            if (isExpanded == false)
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount: roomObj.amenities.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 40),
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 4,
                              child: amenitiesIcons[roomObj.amenities[index]],
                            );
                          },
                        )),
                    if ((roomObj.amenities.length - 4) > 4)
                      Expanded(
                          child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isExpanded = !isExpanded;
                          });
                        },
                        child: CircleAvatar(
                            backgroundColor:
                                const Color.fromARGB(255, 96, 104, 189),
                            foregroundColor: Colors.white,
                            child: Center(
                                child:
                                    Text('+${roomObj.amenities.length - 4}'))),
                      ))
                  ],
                ),
              ),
            if (isExpanded == true)
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                        flex: 5,
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: roomObj.amenities.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 60),
                          itemBuilder: (context, index) {
                            return SizedBox(
                              height: 5,
                              child: amenitiesIcons[roomObj.amenities[index]],
                            );
                          },
                        )),
                  ],
                ),
              ),
            const DividerLine(),
            if (roomTypeExpanded == false)
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Room Types',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            roomTypeExpanded = !roomTypeExpanded;
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Color.fromARGB(255, 96, 104, 189),
                        ))
                  ],
                ),
              ),
            if (roomTypeExpanded == true)
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          'Room Types',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                roomTypeExpanded = !roomTypeExpanded;
                              });
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Color.fromARGB(255, 96, 104, 189),
                            ))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'This Property has Two types of Sharing basis.',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DisplayRoomTypes(
                          type: 'Private Room',
                          rent: roomObj.rent,
                          icon: Icons.person,
                        ),
                        DisplayRoomTypes(
                          type: 'Two Sharing',
                          rent: roomObj.rent ~/ 2,
                          icon: Icons.person_add,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            const DividerLine(),
            if (locationExpanded == false)
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Location And Maps',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            locationExpanded = !locationExpanded;
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Color.fromARGB(255, 96, 104, 189),
                        ))
                  ],
                ),
              ),
            if (locationExpanded == true)
              Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Location And Maps',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          const Spacer(),
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  locationExpanded = !locationExpanded;
                                });
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Color.fromARGB(255, 96, 104, 189),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(child: Text(roomObj.address)),
                          const Icon(
                            Icons.location_city,
                            color: Color.fromARGB(255, 96, 104, 189),
                          )
                        ],
                      )
                    ],
                  )),
            const DividerLine()
          ],
        ),
      ]),
    );
  }

  BottomAppBar bottomAppBar() {
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
