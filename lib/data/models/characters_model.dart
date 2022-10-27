class CharacterModel {
  late int charId;
  late String name;
  late String birthday;
  late List<dynamic> job;
  late String image;
  late String statusIfDeadOrLive;
  late String nickname;
  late List<dynamic> appearanceOfSeason;
  late String actorName;
  late String categoryForTwoSeries;
  late List<dynamic> betterCallSaulAppearance;

  CharacterModel.fromJson(Map<String, dynamic> json) {
    charId = json['char_id'];
    name = json['name'];
    birthday = json['birthday'];
    job = json['occupation'];
    image = json['img'];
    statusIfDeadOrLive = json['status'];
    nickname = json['nickname'];
    appearanceOfSeason = json['appearance'];
    actorName = json['portrayed'];
    categoryForTwoSeries = json['category'];
    betterCallSaulAppearance = json['better_call_saul_appearance'];
  }
}
