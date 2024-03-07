import 'package:flutter/material.dart';
import '../services/auth_services.dart';

class NavigationScreenDrawer extends StatelessWidget {
  const NavigationScreenDrawer({super.key});

  void signOutUser(BuildContext context) {
    AuthService().signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserProvider>(context).user; to access the user data
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () => signOutUser(context),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              textStyle: MaterialStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
              minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width / 2.5, 50),
              ),
            ),
            child: const Text(
              "Sign Out",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
