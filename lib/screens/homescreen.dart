import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => __HomeScreenState();
}

class __HomeScreenState extends State<HomeScreen> {
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
    return Scaffold(
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
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(18),
            child: SearchBar(
              leading:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
              hintText: 'Search By Location..',
            ),
          ),
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
          const SizedBox(
            height: 20,
          ),
          const RoomCard(),
        ],
      ),
    );
  }
}

const kfontSizeDiscount = TextStyle(fontSize: 10);

class RoomCard extends StatelessWidget {
  const RoomCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 242, 240, 245)),
      margin: const EdgeInsets.symmetric(horizontal: 20),
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
                'https://www.thespruce.com/thmb/iMt63n8NGCojUETr6-T8oj-5-ns=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/PAinteriors-7-cafe9c2bd6be4823b9345e591e4f367f.jpg',
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
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Master Room ',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'Chennai,',
                      textAlign: TextAlign.center,
                    ),
                    Text('Adambakkam'),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: const Divider(
                    thickness: 0.9,
                    color: Color.fromARGB(255, 24, 23, 23),
                  ),
                ),
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('Men'),
                  ),
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Monthly Rent '),
                    Row(
                      children: [
                        Text(
                          '7600 ',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        Text('Onwards'),
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
    );
  }
}
