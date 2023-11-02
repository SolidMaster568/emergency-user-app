import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emg/chat/chat_page.dart';
import 'package:emg/models/admin_model.dart';
import 'package:emg/models/channel_model.dart';
import 'package:emg/utils/colors.dart';
import 'package:emg/utils/globals.dart';
import 'package:emg/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("chat")
            .where("userID", isEqualTo: Globals.currentUser!.uid)
            .orderBy("lastMessage", descending: true)
            .snapshots(includeMetadataChanges: true),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            DateFormat formatter = DateFormat("HH:mm");

            return ListView.separated(
                padding: const EdgeInsets.all(4.0),
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot document = snapshot.data!.docs[index];
                  Map<String, dynamic> channelInfo =
                      document.data() as Map<String, dynamic>;
                  ChannelModel channelModel =
                      ChannelModel.fromJson(channelInfo);

                  return FutureBuilder(
                      future: Util.getEmrByFirebase(channelModel.adminID),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          AdminModel admin = snapshot.data!;
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => ChatPage(
                                      channel: channelModel, admin: admin),
                                ),
                              );
                            },
                            leading: SizedBox(
                              width: 60,
                              height: 60,
                              child: CachedNetworkImage(
                                imageUrl: admin.categoryInfo.getPhotoUrl(),
                                imageBuilder: ((context, imageProvider) =>
                                    CircleAvatar(
                                      backgroundImage: imageProvider,
                                    )),
                                placeholder: (context, url) => const Center(
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    const CircleAvatar(),
                              ),
                            ),
                            title: Text(
                              admin.categoryInfo.name,
                              style: const TextStyle(
                                  color: colorBlack,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                            ),
                            subtitle: Text(
                              channelModel.content,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffA2A5AA)),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 12,
                                  height: 12,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: buttonColor),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  formatter.format(channelModel.lastMessage),
                                  style: const TextStyle(color: buttonColor),
                                )
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Container();
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }));
                },
                separatorBuilder: (_, __) => const Divider(thickness: 0.01),
                itemCount: snapshot.data!.docs.length);
          } else if (snapshot.hasError) {
            return const Center(child: Text("Connection Error"));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }
}
