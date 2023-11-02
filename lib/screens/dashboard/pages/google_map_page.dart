import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emg/chat/chat_page.dart';
import 'package:emg/models/admin_model.dart';
import 'package:emg/models/channel_model.dart';
import 'package:emg/screens/dashboard/pages/history_page.dart';
import 'package:emg/screens/dashboard/pages/home_page.dart';
import 'package:emg/screens/dashboard/pages/message_page.dart';
import 'package:emg/screens/dashboard/pages/setting_page.dart';
import 'package:emg/screens/dashboard/pages/map_page.dart';
import 'package:emg/utils/colors.dart';
import 'package:emg/utils/globals.dart';
import 'package:emg/view/widgets/emergency_help_dialog.dart';
import 'package:flutter/material.dart';

class GoogleMapPage extends StatefulWidget {
  const GoogleMapPage({super.key});

  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  int _currentIndex = 0;
  int _isMap = 0;
  final List<Widget> _screens = [
    const HomePage(), // Replace with your screen widgets
    const HistoryPage(),
    const MessagePage(),
    const SettingPage()
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: _currentIndex == 2
            ? AppBar(
                elevation: 0,
                actions: [
                  IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            scrollable: true,
                            backgroundColor: colorWhite,
                            content: Container(
                              // color: colorWhite,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 16),
                              width: size.width * 0.85,
                              height: size.height * 0.48,
                              child: EmergencyHelpDialog(
                                callback: onSelectEmr,
                              ),
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.contact_emergency))
                ],
              )
            : null,
        body: _isMap == 0 ? const MapPage() : _screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: buttonColor,
          unselectedItemColor: colorGrey,
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            _isMap = 1;
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home_outlined,
                // color: _currentIndex == 0 ? buttonColor : colorGrey,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.history,
                // color: _currentIndex == 1 ? buttonColor : colorGrey,
              ),
              label: 'History',
            ),
            BottomNavigationBarItem(
              label: "Chat",
              icon: Icon(
                Icons.chat_bubble_outline,
                // color: _currentIndex == 2 ? buttonColor : colorGrey,
              ),
            ),
            BottomNavigationBarItem(
              label: "Settings",
              icon: Icon(
                Icons.settings_outlined,
                // color: _currentIndex == 3 ? buttonColor : colorGrey,
              ),
            )
          ],
          backgroundColor: colorWhite, // Set your desired background color here
          // selectedItemColor: buttonColor, // Set the color for selected item
          // unselectedItemColor: colorGrey, // Set the color for unselected items
        ),
      ),
    );
  }

  void onSelectEmr(AdminModel admin, String category) async {
    String channelId = "${Globals.currentUser!.uid}_${admin.uid}";
    Map<String, dynamic> channelInfo = {
      "id": channelId,
      "userID": Globals.currentUser!.uid,
      "adminID": admin.uid,
      "service": category,
    };
    ChannelModel channel = ChannelModel.fromJson(channelInfo);

    DocumentReference<Map<String, dynamic>> channelDocumentRef =
        FirebaseFirestore.instance.collection("chat").doc(channel.id);
    var batch = FirebaseFirestore.instance.batch();
    batch.set(channelDocumentRef, channelInfo, SetOptions(merge: true));

    batch.commit().then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatPage(channel: channel, admin: admin),
        ),
      );
    }, onError: (e) {
      print(e);
    });
  }
}
