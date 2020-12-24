class TopicListModel {
  int id;
  String topicName;
  int totalQuestions;
  int totalMarks;
  String endDate;
  int testId;

  TopicListModel({
    this.id,
    this.topicName,
    this.endDate,
    this.totalMarks,
    this.totalQuestions,
    this.testId,
  });

  factory TopicListModel.fromJson(Map<String, dynamic> jsonDe) {
    //  String image='http://projects.creatise.in/school_app'+jsonDe['schools'][0]['cover_image'];
    return TopicListModel(
      id: jsonDe['id'],
      topicName: jsonDe['test_name'],
      totalQuestions: jsonDe['questions_count'],
      totalMarks: jsonDe['total_marks_allotted'],
      endDate: jsonDe['end_date'],
      testId: jsonDe['questions'][0]['test_id'],
    );
  }
}
