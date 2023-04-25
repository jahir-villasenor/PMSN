import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:practica1/models/post_model.dart';

class PostCollection {
  FirebaseFirestore? _firestore;
  CollectionReference? _postCollection;

  PostCollection() {
    _firestore = FirebaseFirestore.instance;
    _postCollection = _firestore!.collection('posts');
  }

  Future<void> insertPost(PostModel postModel) async {
    return _postCollection!
        .doc()
        .set({'dscPost': postModel.dscPost, 'datePost': postModel.datePost});
  }

  Future<void> updatePost(PostModel postModel, String id) async {
    return _postCollection!
        .doc(id)
        .update({'dscPost': postModel.dscPost, 'datePost': postModel.datePost});
  }

  Future<void> deletePost(String id) async {
    return _postCollection!.doc(id).delete();
  }

  Stream<QuerySnapshot> getAllPosts() {
    return _postCollection!.snapshots();
  }
}
