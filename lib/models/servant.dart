class Servant {
  final int id;
  final String name;
  final String className;
  final String face;
  bool isFavorite;

  Servant({
    required this.id,
    required this.name,
    required this.className,
    required this.face,
    this.isFavorite = false,
  });

  factory Servant.fromJson(Map<String, dynamic> json) {
    return Servant(
      id: json['id'],
      name: json['name'],
      className: json['className'],
      face: json['face'] ?? '',
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}

class ServantDetail {
  final int id;
  final String name;
  final String className;
  final int rarity;
  final Map<String, String> ascensions;
  final String gender;
  final List<String> traits;
  final List<Skill> skills;
  final List<Skill> classPassives;
  final List<NoblePhantasm> noblePhantasms;

  ServantDetail({
    required this.id,
    required this.name,
    required this.className,
    required this.rarity,
    required this.ascensions,
    required this.gender,
    required this.traits,
    required this.skills,
    required this.classPassives,
    required this.noblePhantasms,
  });

  factory ServantDetail.fromJson(Map<String, dynamic> json) {
    return ServantDetail(
      id: json['id'],
      name: json['name'],
      className: json['className'],
      rarity: json['rarity'],
      ascensions: Map<String, String>.from(
          json['extraAssets']['charaGraph']['ascension']),
      gender: json['gender'],
      traits: List<String>.from(json['traits'].map((trait) => trait['name'])),
      skills: List<Skill>.from(
          json['skills'].map((skill) => Skill.fromJson(skill))),
      classPassives: List<Skill>.from(
          json['classPassive'].map((skill) => Skill.fromJson(skill))),
      noblePhantasms: List<NoblePhantasm>.from(
          json['noblePhantasms'].map((np) => NoblePhantasm.fromJson(np))),
    );
  }
}

class Skill {
  final String name;
  final String detail;
  final String icon;

  Skill({
    required this.name,
    required this.detail,
    required this.icon,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      name: json['name'],
      detail: json['detail'],
      icon: json['icon'],
    );
  }
}

class NoblePhantasm {
  final String name;
  final String rank;
  final String icon;
  final String type;
  final String detail;

  NoblePhantasm({
    required this.name,
    required this.rank,
    required this.icon,
    required this.type,
    required this.detail,
  });

  factory NoblePhantasm.fromJson(Map<String, dynamic> json) {
    return NoblePhantasm(
      name: json['name'],
      rank: json['rank'],
      icon: json['icon'],
      type: json['type'],
      detail: json['detail'],
    );
  }
}
