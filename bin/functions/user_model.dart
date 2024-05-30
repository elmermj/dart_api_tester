class UserModel {
  int id;
  String token;
  String username;
  String realname;
  String email;
  String? profImageUrl;
  String? bio;
  String? fileName;
  DateTime createdAt;

  UserModel({
    required this.id,
    required this.token,
    required this.username,
    required this.realname,
    required this.email,
    this.profImageUrl,
    this.bio,
    this.fileName,
    required this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      token: json['token'],
      username: json['username'],
      realname: json['realname'],
      email: json['email'],
      profImageUrl: json['profImageUrl'],
      bio: json['bio'],
      fileName: json['fileName'],
      createdAt: DateTime.parse(json['createdAt'].replaceAll('T', ' ').substring(0, 19)),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'username': username,
      'realname': realname,
      'email': email,
      'profImageUrl': profImageUrl,
      'bio': bio,
      'fileName': fileName,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
