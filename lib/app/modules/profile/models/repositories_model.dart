class RepositoriesModel {
  final String name;
  final String description;
  final String language;
  final int stargazersCount;
  final int forksCount;

  RepositoriesModel(
      {this.name,
      this.description,
      this.language,
      this.stargazersCount,
      this.forksCount});

  factory RepositoriesModel.fromJson(Map<String, dynamic> json) {
    return RepositoriesModel(
      name: json['name'],
      description: json['description'],
      language: json['language'],
      stargazersCount: json['stargazers_count'],
      forksCount: json['forks_count'],
    );
  }

  Map<String, dynamic> toJson() => {};
}
