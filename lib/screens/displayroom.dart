import 'package:flutter/material.dart';
import 'package:yolo/model/dataModel.dart';
import 'package:carousel_slider/carousel_slider.dart';

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
      appBar: AppBar(),
      bottomNavigationBar: BottomAppBar(
        color: Colors.redAccent, // Red color for bottom app bar
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              'Token Amount: 1000',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Reserve Room',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
      ),
      body: ListView(children: [
        Column(
          children: [
            Carousel(
              imageUrls: widget.room.image,
            ),
            DisplayRoomText(widget: widget, roomObj: roomObj),
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
                          itemCount: 4,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 5,
                                  crossAxisSpacing: 40),
                          itemBuilder: (context, index) {
                            return Container(
                              height: 4,
                              child: AmenitiesIcons[roomObj.amenities[index]],
                            );
                          },
                        )),
                    Expanded(
                        child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isExpanded = !isExpanded;
                        });
                      },
                      child: CircleAvatar(
                          child: Center(
                              child: Text('+' +
                                  (roomObj.amenities.length - 4).toString()))),
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
                              child: AmenitiesIcons[roomObj.amenities[index]],
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
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            roomTypeExpanded = !roomTypeExpanded;
                          });
                        },
                        icon: const Icon(Icons.add))
                  ],
                ),
              ),
            if (roomTypeExpanded == true)
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
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
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                roomTypeExpanded = !roomTypeExpanded;
                              });
                            },
                            icon: const Icon(Icons.close))
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
                    Spacer(),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            locationExpanded = !locationExpanded;
                          });
                        },
                        icon: const Icon(Icons.add))
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
                              icon: const Icon(Icons.close))
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Expanded(child: Text(roomObj.address)),
                          const Icon(Icons.location_city)
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
}

class DisplayRoomTypes extends StatelessWidget {
  const DisplayRoomTypes(
      {super.key, required this.rent, required this.type, required this.icon});
  final int rent;
  final String type;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(child: Center(child: Icon(icon))),
        const SizedBox(
          width: 5,
        ),
        Column(
          children: [
            Text(type),
            const Text('Starting from'),
            Row(
              children: [
                Text(
                  '${rent.toString()} ',
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w800),
                ),
                const Text('/Month')
              ],
            )
          ],
        )
      ],
    );
  }
}

class DividerLine extends StatelessWidget {
  const DividerLine({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: const Divider(
        thickness: 0.9,
        color: Color.fromARGB(255, 24, 24, 23),
      ),
    );
  }
}

class DisplayRoomText extends StatelessWidget {
  const DisplayRoomText({
    super.key,
    required this.widget,
    required this.roomObj,
  });

  final DisplayRoom widget;
  final Room roomObj;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
      child: Card(
        color: Color.fromARGB(255, 82, 33, 161),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      widget.room.roomType.name.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.white),
                    ),
                    Text(
                      widget.room.location[1],
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    CircleAvatar(
                        backgroundColor: Colors.amber,
                        radius: 18,
                        child: Center(child: Icon(SexIcons[roomObj.sex]))),
                    Text(
                      roomObj.sex.name.toUpperCase(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Carousel extends StatelessWidget {
  const Carousel({super.key, required this.imageUrls});
  final List<String> imageUrls;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider.builder(
        itemCount: imageUrls.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage(imageUrls[index]),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        options: CarouselOptions(
          height: 280.0,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 16 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          viewportFraction: 0.8,
        ),
      ),
    ]);
  }
}
