import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterauthentication/model/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //firestore instance
  final CollectionReference userCollection =
      Firestore.instance.collection('user');

//add data in cloud firestore
  Future updateData(user) async {
    return await userCollection.document(uid).setData({
      'uid': uid,
      'FullName': user.fullName ?? '',
      'UserName': user.userName,
      'Email': user.email,
      'PhoneNumber': user.phoneNumber,
      'PhotoUrl': user.photoUrl
    });
  }

  //check if user already exist with given PhoneNumber
  Future<bool> checkUserWithPhoneNumber(String phoneNumber) async {
    final QuerySnapshot snapshot = await userCollection.getDocuments();
    final List<DocumentSnapshot> documents = snapshot.documents;

    documents.forEach((doc) {
      print(doc.data);
      if (doc.data['PhoneNumber'] == phoneNumber) {
        return true;
      }
    });
    return false;
  }

  Future<void> checkFacebookUser(profile) async {
    final QuerySnapshot snapshot = await userCollection.getDocuments();
    final List<DocumentSnapshot> documents = snapshot.documents;
    var flag = 0;
    documents.forEach((doc) {
      print(doc.data);
      if (doc.data['uid'] == uid) {
        flag = 1;
      }
    });

    if (flag == 0) {
      User user = User(
          uid: profile['id'],
          fullName: profile['first_name'] + " " + profile['last_name'],
          phoneNumber: "",
          email: profile['email'],
          userName: profile['name'],
          photoUrl: profile['picture']['data']['url']);

      updateData(user);
    }
  }
}
