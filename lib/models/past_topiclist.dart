class PastTopicModel {
  int id;
  String topicName;
  int testScore;
  int totalMarks;


  PastTopicModel({
    this.id,
    this.topicName,
    this.testScore,
    this.totalMarks,
   
  });

  factory PastTopicModel.fromJson(Map<String, dynamic> jsonDe) {
    //  String image='http://projects.creatise.in/school_app'+jsonDe['schools'][0]['cover_image'];
    return PastTopicModel(
      id: jsonDe['id'],
      topicName: jsonDe['tests'][0]['test_name'],
      testScore: jsonDe['test_score'],
      totalMarks:jsonDe['tests'][0]['total_marks_allotted'],
     
    );
  }
}
