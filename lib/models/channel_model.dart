class ChannelModel {
  String id;
  String userID;
  String adminID;
  String service;
  int adminMessages;
  int userMessages;

  String content;
  String type;
  DateTime lastMessage;

  ChannelModel({
    required this.id,
    required this.userID,
    required this.adminID,
    required this.service,
    required this.adminMessages,
    required this.userMessages,
    required this.content,
    required this.type,
    required this.lastMessage,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userID': userID,
      'adminID': adminID,
      'service': service,
      'adminMessages': adminMessages,
      'userMessages': userMessages,
      'content': content,
      'type': type,
      'lastMessage': lastMessage,
    };
  }

  factory ChannelModel.fromJson(Map<String, dynamic> map) {
    return ChannelModel(
      id: map['id'] ?? "",
      userID: map['userID'] ?? "",
      adminID: map['adminID'] ?? "",
      service: map['service'] ?? "",
      adminMessages: map['adminMessages'] ?? 0,
      userMessages: map['userMessages'] ?? 0,
      content: map['content'] ?? "",
      type: map['type'] ?? "",
      lastMessage: (map['lastMessage'] == null)
          ? DateTime.now()
          : DateTime.parse(map['lastMessage'].toDate().toString()),
    );
  }
}
