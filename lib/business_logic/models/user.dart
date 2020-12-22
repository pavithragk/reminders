class UserModel {
  String email;
  String photoUrl;
  String displayName;
  String uid;
  String tag;

  UserModel({this.email, this.photoUrl, this.displayName, this.uid, this.tag});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    photoUrl = json['photoUrl'];
    displayName = json['displayName'];
    uid = json['uid'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['photoUrl'] = this.photoUrl;
    data['displayName'] = this.displayName;
    data['uid'] = this.uid;
    data['tag'] = this.tag;
    return data;
  }
}
