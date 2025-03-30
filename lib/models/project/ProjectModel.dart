
import 'package:hive/hive.dart';

part 'ProjectModel.g.dart';

@HiveType(typeId: 1)
class ProjectModel {
  @HiveField(0)
  String projectid;
  @HiveField(1)
  String? publisherid;
  @HiveField(2)
  String? accessid;
  @HiveField(3)
  String? admin;
  @HiveField(4)
  String? projecttitle;
  @HiveField(5)
  String? date;
  @HiveField(6)
  String? image;

  ProjectModel({
    required this.projectid,
    this.publisherid,
    this.accessid,
    this.admin,
    this.projecttitle,
    this.date,
    this.image,
  });

  // Manual copyWith method
  ProjectModel copyWith({
    String? projectid,
    String? publisherid,
    String? accessid,
    String? admin,
    String? projecttitle,
    String? date,
    String? image,
  }) {
    return ProjectModel(
      projectid: projectid ?? this.projectid,
      publisherid: publisherid ?? this.publisherid,
      accessid: accessid ?? this.accessid,
      admin: admin ?? this.admin,
      projecttitle: projecttitle ?? this.projecttitle,
      date: date ?? this.date,
      image: image ?? this.image,
    );
  }

  factory ProjectModel.fromJson(Map<String, dynamic> json) {
    return ProjectModel(
      projectid: json['projectid'] as String,
      publisherid: json['publisherid'] as String?,
      accessid: json['accessid'] as String?,
      admin: json['admin'] as String?,
      projecttitle: json['projecttitle'] as String?,
      date: json['date'] as String?,
      image: json['image'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'projectid': projectid,
      'publisherid': publisherid,
      'accessid': accessid,
      'admin': admin,
      'projecttitle': projecttitle,
      'date': date,
      'image': image,
    };
  }
}