import 'dart:convert';
class PostModel {
   String PostTime;
   String PostUserId;
   String PostBreed;
   String PostTopic;
   String PostLike;
   String PostComment;
   String PostData;
   String PostTitle;
   String PostImageUrl;
   String PostID;
   String TokenUserPost;
  PostModel({
    required this.PostTime,
    required this.PostUserId,
    required this.PostBreed,
    required this.PostTopic,
    required this.PostLike,
    required this.PostComment,
    required this.PostData,
    required this.PostTitle,
    required this.PostImageUrl,
    required this.PostID,
    required this.TokenUserPost,
  });

  PostModel copyWith({
    String? PostTime,
    String? PostUserId,
    String? PostBreed,
    String? PostTopic,
    String? PostLike,
    String? PostComment,
    String? PostData,
    String? PostTitle,
    String? PostImageUrl,
    String? PostID,
    String? TokenUserPost,
  }) {
    return PostModel(
      PostTime: PostTime ?? this.PostTime,
      PostUserId: PostUserId ?? this.PostUserId,
      PostBreed: PostBreed ?? this.PostBreed,
      PostTopic: PostTopic ?? this.PostTopic,
      PostLike: PostLike ?? this.PostLike,
      PostComment: PostComment ?? this.PostComment,
      PostData: PostData ?? this.PostData,
      PostTitle: PostTitle ?? this.PostTitle,
      PostImageUrl: PostImageUrl ?? this.PostImageUrl,
      PostID: PostID ?? this.PostID,
      TokenUserPost: TokenUserPost ?? this.TokenUserPost,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'PostTime': PostTime,
      'PostUserId': PostUserId,
      'PostBreed': PostBreed,
      'PostTopic': PostTopic,
      'PostLike': PostLike,
      'PostComment': PostComment,
      'PostData': PostData,
      'PostTitle': PostTitle,
      'PostImageUrl': PostImageUrl,
      'PostID': PostID,
      'TokenUserPost': TokenUserPost,
    };
  }

  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      PostTime: map['PostTime'],
      PostUserId: map['PostUserId'],
      PostBreed: map['PostBreed'],
      PostTopic: map['PostTopic'],
      PostLike: map['PostLike'],
      PostComment: map['PostComment'],
      PostData: map['PostData'],
      PostTitle: map['PostTitle'],
      PostImageUrl: map['PostImageUrl'],
      PostID: map['PostID'],
      TokenUserPost: map['TokenUserPost'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PostModel.fromJson(String source) => PostModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PostModel(PostTime: $PostTime, PostUserId: $PostUserId, PostBreed: $PostBreed, PostTopic: $PostTopic, PostLike: $PostLike, PostComment: $PostComment, PostData: $PostData, PostTitle: $PostTitle, PostImageUrl: $PostImageUrl, PostID: $PostID, TokenUserPost: $TokenUserPost)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is PostModel &&
      other.PostTime == PostTime &&
      other.PostUserId == PostUserId &&
      other.PostBreed == PostBreed &&
      other.PostTopic == PostTopic &&
      other.PostLike == PostLike &&
      other.PostComment == PostComment &&
      other.PostData == PostData &&
      other.PostTitle == PostTitle &&
      other.PostImageUrl == PostImageUrl &&
      other.PostID == PostID &&
      other.TokenUserPost == TokenUserPost;
  }

  @override
  int get hashCode {
    return PostTime.hashCode ^
      PostUserId.hashCode ^
      PostBreed.hashCode ^
      PostTopic.hashCode ^
      PostLike.hashCode ^
      PostComment.hashCode ^
      PostData.hashCode ^
      PostTitle.hashCode ^
      PostImageUrl.hashCode ^
      PostID.hashCode ^
      TokenUserPost.hashCode;
  }
}
