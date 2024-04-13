import 'package:flutter/material.dart';
import 'package:food_ordering/components/colors.dart';
import 'package:food_ordering/components/constraints.dart';
import 'package:food_ordering/utils/toast_message.dart';
import 'package:food_ordering/views/home_views/aboutUs_page.dart';
import 'package:food_ordering/views/logIn_views/login_page.dart';
import 'package:food_ordering/views/logOut_function/logout_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String gmailId = "";
  late SharedPreferences loginData;

  @override
  void initState() {
    super.initState();
    fetchGmailIdFromSharedPreferences();
    initializeSharedPreferences();
  }

  Future<void> initializeSharedPreferences() async {
    loginData = await SharedPreferences.getInstance();
  }

  //Getting gmail Id from shared preference
  Future<void> fetchGmailIdFromSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      gmailId = prefs.getString("gmailId") ?? "Unknown";
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final logoutprovider = Provider.of<LogOutProvider>(context, listen: false);
    print("Drawer Rebuild....");
    return Drawer(
      child: ListView(
        children: [
          Card(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: size.width / 4,
                    height: size.width / 4,
                    child: CircleAvatar(
                      backgroundColor: appColor,
                      child: Icon(
                        Icons.person,
                        size: size.width / 6,
                      ),
                    ),
                  ),
                  Text(
                    "User: $gmailId",
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text("About Us"),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AboutUs()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text("Privacy Policy"),
            onTap: () async {
              if (await canLaunch(privacyPolicyLink)) {
                await launch(privacyPolicyLink, universalLinksOnly: true);
              } else {
                throw "";
              }
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: const Text("Contact Us"),
            onTap: () async {
              String mail = Uri.encodeComponent("dipeshjaiwal98@gmail.com");
              String subject = Uri.encodeComponent("Subject: ");
              String Body = Uri.encodeComponent("body part");
              Uri gmail =
                  Uri.parse("mailto:$mail?subject=$subject& body=$Body");
              if (await launchUrl(gmail)) {
              } else {}
            },
          ),
          const ListTile(
            leading: const Icon(Icons.share),
            title: const Text("Share this app"),
          ),
          Consumer<LogOutProvider>(builder: (context, value, child) {
            return ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Log Out"),
              onTap: () {
                logoutprovider.logOutFunction();

                //Navigate and close previous screens.....
                Navigator.pop(context);
                //Share preferences setup
                loginData.setBool("login", true);
                loginData.remove("gmailId");
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoginScreen()));
                Utils.toastMessage("Logout successfully", errorColor);
              },
            );
          })
        ],
      ),
    );
  }
}
