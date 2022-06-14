class AttendanceTrans {
  int? id;
  int? userId;
  String? attendanceType;
  String? long;
  String? lat;
  String? startedAt;
  String? endedAt;
  String? createdAt;
  String? updatedAt;

  AttendanceTrans({
    this.id,
    this.userId,
    this.attendanceType,
    this.long,
    this.lat,
    this.startedAt,
    this.endedAt,
    this.createdAt,
    this.updatedAt,
  });

  AttendanceTrans.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    userId = json['user_id'];
    long = json['longtitude'];
    lat = json['latitude'];
    startedAt = json['startedAt'];
    endedAt = json['endedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['user_id'] = userId;
    data['longtitude'] = long;
    data['latitude'] = lat;
    data['startedAt'] = startedAt;
    data['endedAt'] = endedAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
