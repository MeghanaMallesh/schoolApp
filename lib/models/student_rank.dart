class StudentRankModel {
  int id;
  String studentName;
  int studentPhoto;
  int testScore;

  StudentRankModel(
      {this.id, this.studentName, this.studentPhoto, this.testScore});

  factory StudentRankModel.fromJson(Map<String, dynamic> jsonDe) {
    return StudentRankModel(
      id: jsonDe['id'],
      studentName: jsonDe['students'][0]['first_name'],
      studentPhoto: jsonDe['students'][0]['photo'],
      testScore: jsonDe['test_score'],
    );
  }
}
