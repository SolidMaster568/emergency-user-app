class MessageModel {
  String id;
  String senderID;
  String content;
  String type;
  bool isUploaded;
  DateTime created;

  MessageModel({
    required this.id,
    required this.senderID,
    required this.content,
    required this.type,
    required this.isUploaded,
    required this.created,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderID': senderID,
      'content': content,
      'type': type,
      'isUploaded': isUploaded,
      'created': created,
    };
  }

  factory MessageModel.fromJson(Map<String, dynamic> map) {
    return MessageModel(
      id: map['id'] ?? "",
      senderID: map['senderID'] ?? "",
      content: map['content'] ?? "",
      type: map['type'] ?? "",
      isUploaded: map['isUploaded'] ?? false,
      created: (map['created'] == null)
          ? DateTime.now()
          : DateTime.parse(map['created'].toDate().toString()),
    );
  }

  static List<MessageModel> fromJsonList(jsonList) {
    if (jsonList == null) return [];
    return jsonList
        .map<MessageModel>((obj) => MessageModel.fromJson(obj))
        .toList();
  }
}
