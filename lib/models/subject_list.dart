class SubjectList {
  int subId;
  String subjectName;
  String subjectLogo;
  String subColor;
  String subTextColor;

  SubjectList({
    this.subId,
    this.subjectName,
    this.subjectLogo,
    this.subColor,
    this.subTextColor,
  });

  factory SubjectList.fromJson(Map<String, dynamic> jsonDe) {
   // String image='http://projects.creatise.in/school_app'+jsonDe['schools'][0]['cover_image'];
    String image='http://projects.creatise.in/school_app'+jsonDe['logo'];
    return SubjectList(
      subId: jsonDe['id'],
      subjectName: jsonDe['name'],
      subjectLogo:image,
     //  jsonDe['logo'],
    subColor: jsonDe['back_ground_color'],
    subTextColor: jsonDe['text_color'],
    );
  }


}


