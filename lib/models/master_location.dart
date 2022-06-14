class MasterLocation {
  int? id;
  String? desc;
  String? long;
  String? lat;
  bool? isActive;
  String? createdAt;
  String? updatedAt;

  MasterLocation({
    this.id,
    this.desc,
    this.long,
    this.lat,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  MasterLocation.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    desc = json['desc'];
    long = json['longtitude'];
    lat = json['latitude'];
    isActive = json['isActive'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['desc'] = desc;
    data['longtitude'] = long;
    data['latitude'] = lat;
    data['isActive'] = isActive;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
