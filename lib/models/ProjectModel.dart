class ProjectModel {
  String projectid;
  String? publisherid;
  String? accessid;
  String? admin;
  String? projecttitle;
  String? date;
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