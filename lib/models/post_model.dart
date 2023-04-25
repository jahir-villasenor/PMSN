class PostModel {
  String? idPost;
  String? dscPost;
  String? datePost;

  PostModel({this.idPost, this.dscPost, this.datePost});

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
        idPost: map['idPost'],
        dscPost: map['dscPost'],
        datePost: map['datePost']);
  }

  /*
  factory PostModel.toMap() {
    return PostModel ();
  }
  */
}
