import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  ///TO GET USER ID ///
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///Adding Image to Firebase Storage/
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    Reference reference =
        firebaseStorage.ref().child(childName).child(_auth.currentUser!.uid);

    // TO COnsider whether its profile or post Omage
    if (isPost) {
      String id = const Uuid().v1();
      reference = reference.child(id);
    }
    UploadTask uploadTask = reference.putData(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  }
}
