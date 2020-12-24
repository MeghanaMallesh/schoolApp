class StudentListModel {
  int id;
  int userId;
  String studentFName;
  String studentLName;
  String coverImage;
  String schoolName;
  String className;
  String sectionName;

  StudentListModel({
    this.id,
    this.userId,
    this.coverImage,
    this.studentFName,
    this.studentLName,
    this.schoolName,
    this.className,
    this.sectionName,
  });

  factory StudentListModel.fromJson(Map<String, dynamic> jsonDe) {
    return StudentListModel(
        id: jsonDe['student_bio_id'],
        studentFName: jsonDe['student']['first_name'],
        studentLName: jsonDe['student']['last_name'],
        schoolName: jsonDe['school']['name'],
        className: jsonDe['class']['class_name'],
        coverImage: jsonDe['student']['photo'],
        sectionName: jsonDe['section']['section_name']);
  }
}
