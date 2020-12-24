class SchListModel {
  int id;
  int userId;
  String schoolName;
  String coverImage;
  String address;
  int schoolId;

  SchListModel(
      {this.id,
      this.userId,
      this.coverImage,
      this.schoolName,
      this.address,
      this.schoolId});

  factory SchListModel.fromJson(Map<String, dynamic> jsonDe) {
    //  String image='http://projects.creatise.in/school_app'+jsonDe['schools'][0]['cover_image'];
    return SchListModel(
      id: jsonDe['id'],
      schoolId: jsonDe['school_id'],
      schoolName: jsonDe['schools'][0]['name'],
      address: jsonDe['schools'][0]['address'],
      coverImage: jsonDe['schools'][0]['cover_image'],
    );
  }
  // getList(){

}
