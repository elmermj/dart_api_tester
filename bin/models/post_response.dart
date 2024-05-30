class PostResponse {
  int? id;
  String? fileUrl;
  String? fileName;
  String? caption;
  String? createdAt;
  int? userId;

  PostResponse(
      {this.id,
      this.fileUrl,
      this.fileName,
      this.caption,
      this.createdAt,
      this.userId,});

  PostResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fileUrl = json['fileUrl'];
    fileName = json['fileName'];
    caption = json['caption'];
    createdAt = json['createdAt'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fileUrl'] = fileUrl;
    data['fileName'] = fileName;
    data['caption'] = caption;
    data['createdAt'] = createdAt;
    data['userId'] = userId;
    return data;
  }
}