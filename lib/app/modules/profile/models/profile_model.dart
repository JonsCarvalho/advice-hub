class ProfileModel {
  final String avatarUrl;
  final String name;
  final String bio;
  final int followers;
  final int following;

  ProfileModel(
      {this.avatarUrl, this.name, this.bio, this.followers, this.following});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      avatarUrl: json['avatar_url'],
      name: json['name'],
      bio: json['bio'],
      followers: json['followers'],
      following: json['following'],
    );
  }

  Map<String, dynamic> toJson() => {};
}
