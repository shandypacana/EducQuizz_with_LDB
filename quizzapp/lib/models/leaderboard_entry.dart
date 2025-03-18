class LeaderboardEntry {
  final String userName;
  final String profileImage;
  final int score;
  final String category;

  LeaderboardEntry({
    required this.userName,
    required this.profileImage,
    required this.score,
    required this.category,
  });

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'profileImage': profileImage,
      'score': score,
      'category': category,
    };
  }

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntry(
      userName: json['userName'],
      profileImage: json['profileImage'],
      score: json['score'],
      category: json['category'],
    );
  }
}