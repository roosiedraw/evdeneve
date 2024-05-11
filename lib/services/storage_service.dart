import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

//resim eklemek için
  Future<String> uploadMedia(File file) async {
    var uploadTask = _firebaseStorage
        .ref()
        .child(
            "${DateTime.now().millisecondsSinceEpoch}.${file.path.split('.').last}")
        .putFile(file);

    uploadTask.snapshotEvents.listen((event) {});

    var storageRef = await uploadTask;
    _firebaseStorage.setMaxOperationRetryTime(Duration(milliseconds: 1000));
    _firebaseStorage.maxUploadRetryTime.inMilliseconds;
    return await storageRef.ref.getDownloadURL();
  }
}
