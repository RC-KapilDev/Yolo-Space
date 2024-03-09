import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yolo/providers/user_provider.dart';
import 'package:yolo/services/auth_services.dart';
import 'package:yolo/widgets/divideline.dart';

class Account extends StatelessWidget {
  const Account({super.key});
  void signOutUser(BuildContext context) {
    AuthService().signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text('Account'),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
        height: media.width * 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: media.width / 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 96, 104, 189),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        backgroundColor: Colors.amber,
                        maxRadius: 50,
                        backgroundImage: ExactAssetImage('lib/icons/user.png'),
                      ),
                      Text(
                        Provider.of<UserProvider>(context).user.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Column(
              children: [
                AccountTile(
                  text: Provider.of<UserProvider>(context).user.email,
                  icon: Icons.email_outlined,
                  ontap: () {},
                ),
                const DividerLine(),
                AccountTile(
                  text: "Privacy Policy",
                  icon: Icons.privacy_tip_outlined,
                  ontap: () {},
                ),
                const DividerLine(),
                GestureDetector(
                  onTap: () {
                    signOutUser(context);
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        'Log out',
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class AccountTile extends StatelessWidget {
  const AccountTile(
      {super.key, required this.icon, required this.text, required this.ontap});
  final String text;
  final IconData icon;
  final void Function() ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward,
            color: Color.fromARGB(255, 205, 74, 74),
          )
        ],
      ),
    );
  }
}
