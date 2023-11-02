import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emg/models/admin_model.dart';
import 'package:emg/models/channel_model.dart';
import 'package:emg/models/message_model.dart';
import 'package:emg/utils/colors.dart';
import 'package:emg/utils/controllers.dart';
import 'package:emg/utils/globals.dart';
import 'package:emg/utils/textformfield.dart';
import 'package:emg/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.channel, required this.admin});

  final ChannelModel channel;
  final AdminModel admin;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChannelModel channel;
  late AdminModel admin;
  late DocumentReference channelDocumentRef;
  late CollectionReference threadCollectionRef;
  List<MessageModel> messages = [];

  bool isFirst = true;

  // Channel listener
  late StreamSubscription<QuerySnapshot> channelListener;

  final listScrollController = ScrollController();
  final formatter = DateFormat("yyyy-MM-dd HH:mm:ss");

  @override
  void initState() {
    super.initState();

    channel = widget.channel;
    admin = widget.admin;
    channelDocumentRef =
        FirebaseFirestore.instance.collection("chat").doc(channel.id);
    threadCollectionRef = channelDocumentRef.collection("thread");

    markAsRead();

    channelListener = FirebaseFirestore.instance
        .collection("chat")
        .where("id", isEqualTo: channel.id)
        .snapshots(includeMetadataChanges: true)
        .listen((querySnapshot) {
      QueryDocumentSnapshot<Map<String, dynamic>> document =
          querySnapshot.docs.first;

      Map<String, dynamic> channelInfo = document.data();
      setState(() {
        channel = ChannelModel.fromJson(channelInfo);
      });
    });
  }

  @override
  void dispose() {
    channelListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        backgroundColor: colorWhite,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: colorWhite,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: SafeArea(
            child: Container(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: colorBlack,
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  CachedNetworkImage(
                    imageUrl: admin.categoryInfo.getPhotoUrl(),
                    imageBuilder: ((context, imageProvider) => CircleAvatar(
                          maxRadius: 20,
                          backgroundImage: imageProvider,
                        )),
                    placeholder: (context, url) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) =>
                        const CircleAvatar(maxRadius: 20),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          admin.categoryInfo.name,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: colorBlack),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Text(
                          "Online",
                          style: TextStyle(
                              color: Colors.grey.shade600, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Flexible(
              child: _buildListWidget(),
            ),
            _buildInputWidget(),
          ],
        ),
      ),
    );
  }

  Future<void> markAsRead() async {
    await channelDocumentRef.set({"userMessages": 0}, SetOptions(merge: true));
  }

  Future<bool> _onBackPress() async {
    await markAsRead();
    Navigator.of(context).pop();
    return Future.value(false);
  }

  Widget _buildListWidget() {
    return StreamBuilder<QuerySnapshot>(
        stream: threadCollectionRef
            .orderBy("created", descending: true)
            .limit(20)
            .snapshots(includeMetadataChanges: true),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            messages = snapshot.data!.docs.map<MessageModel>((e) {
              MessageModel messageModel =
                  MessageModel.fromJson(e.data() as Map<String, dynamic>);
              messageModel.id = e.id;
              return messageModel;
            }).toList();

            return ListView.separated(
              itemBuilder: (context, index) {
                MessageModel message = messages[index];
                return ListTile(
                    leading: message.senderID == Globals.currentUser!.uid
                        ? null
                        : SizedBox(
                            width: 40,
                            height: 40,
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
                    trailing: message.senderID == Globals.currentUser!.uid
                        ? SizedBox(
                            width: 40,
                            height: 40,
                            child: CachedNetworkImage(
                              imageUrl: Globals.currentUser!.photourl,
                              imageBuilder: ((context, imageProvider) =>
                                  CircleAvatar(
                                    backgroundImage: imageProvider,
                                  )),
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const CircleAvatar(),
                            ),
                          )
                        : null,
                    title: Container(
                      width: 248,
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(0),
                              topRight: Radius.circular(12))),
                      child: Center(
                        child: Text(
                          message.content,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    subtitle: message.senderID == Globals.currentUser!.uid
                        ? Text(
                            formatter.format(message.created),
                            textAlign: TextAlign.right,
                            style: const TextStyle(color: colorWhite),
                          )
                        : Text(
                            formatter.format(message.created),
                            style: const TextStyle(color: colorWhite),
                          )

                    //  styling here...
                    );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemCount: messages.length,
              reverse: true,
              controller: listScrollController,
            );
          } else if (snapshot.hasError) {
            return Container();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget _buildInputWidget() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextFormInputField(
              hintText: "Type Your Message",
              textInputType: TextInputType.text,
              controller: chatController,
            ),
          ),
          const SizedBox(width: 15),
          IconButton(
            icon: const Icon(
              Icons.send,
              color: buttonColor,
            ),
            onPressed: () => onSendMessage(chatController.text.trim()),
          ),
        ],
      ),
    );
  }

  Future<void> onSendMessage(String content) async {
    if (content.isEmpty) {
      showSnakBar("Nothing to send", context);
      return;
    }

    FocusScope.of(context).unfocus();
    chatController.clear();

    try {
      Map<String, dynamic> messageData = {
        "type": "text",
        "content": content,
        "created": FieldValue.serverTimestamp(),
        "senderID": Globals.currentUser!.uid,
      };

      Map<String, dynamic> data = {
        "type": "text",
        "content": content,
        "lastMessage": FieldValue.serverTimestamp(),
        "adminMessages": FieldValue.increment(1),
        "userMessages": 0,
      };

      var batch = FirebaseFirestore.instance.batch();
      String key = DateTime.now().millisecondsSinceEpoch.toString();
      batch.set(threadCollectionRef.doc(key), messageData);
      batch.set(channelDocumentRef, data, SetOptions(merge: true));

      batch.commit().then((value) {
        listScrollController.animateTo(0.0,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }, onError: (e) {
        print(e);
      });

      if (isFirst) {
        isFirst = false;
        // Need to send message for admin account
        // List<String> shows = [];
        // shows.addAll(channel.showInMessages);
        // shows.remove(Globals.currentUser!.uid);
        // Util.sendNotification(
        //     "chat",
        //     channel.id,
        //     shows,
        //     "EMG",
        //     "Received new message from " +
        //         (channel.isGroup
        //             ? channel.groupName
        //             : Globals.currentUser!.firstName +
        //                 " " +
        //                 Globals.currentUser!.lastName),
        //     true);
      }
    } catch (e) {
      print(e);
    }
  }
}
