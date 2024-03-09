import 'package:flutter/material.dart';
import 'package:yolo/model/dataModel.dart';
import 'package:yolo/screens/displayroom.dart';
import 'package:yolo/widgets/roomcard.dart';

// class SearchScreen extends StatelessWidget {
//   const SearchScreen({super.key, required this.rooms});
//   final List<Room> rooms;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       children: [],
//     ));
//   }
// }

class MySearchDelegate extends SearchDelegate {
  MySearchDelegate({required this.roomList});
  final List<Room> roomList;

  void displayScreen(Room room, BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DisplayRoom(room: room)));
  }

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back),
      );

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
            }
          },
          icon: const Icon(Icons.clear),
        ),
      ];

  @override
  Widget buildSuggestions(BuildContext context) {
    final Set<String> uniqueLocations = Set<String>();
    final List<Room> suggestions = query.isEmpty
        ? []
        : roomList.where((room) {
            final input = query.toLowerCase();
            final containsInput = room.location
                .any((location) => location.toLowerCase().contains(input));
            if (containsInput) {
              uniqueLocations
                  .addAll(room.location); // Add all unique locations to the set
            }
            return containsInput;
          }).toList();

    return ListView.builder(
      itemCount: uniqueLocations.length,
      itemBuilder: (context, index) {
        final location = uniqueLocations.elementAt(index);
        return ListTile(
          title: Text(location),
          onTap: () {
            query = location; // Set the query to the selected location
            showResults(context);
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<Room> searchResults = roomList.where((room) {
      final input = query.toLowerCase();
      return room.location
          .any((location) => location.toLowerCase().contains(input));
    }).toList();

    if (searchResults.isEmpty) {
      return Center(
        child: Text('No results found for "$query"'),
      );
    } else {
      return ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final Room room = searchResults[index];
          return RoomCard(room: room, onTap: displayScreen);
        },
      );
    }
  }
}


// Card(
//             child: ListTile(
//               title: Text('Room Type: ${room.roomType}'),
//               subtitle: Text('Rent: ${room.rent}'),
//               onTap: () {
//                 // Handle tap on the room if needed
//               },
//             ),
//           );