class TestListModel {
  int questionId;
  String testQuestion;
  String testOption;
  String testOption2;
  String testOption3;
  String testOption4;
  String answer;
  int id;
  int durationInSec;
  int totalQuestion;
  int subject;
  int optionId;
  int optionId1;
  int optionId2;
  int optionId3;
  String isAnswer;
  String isAnswer1;
  String isAnswer2;
  String isAnswer3;
  int marksAllotted;

  TestListModel({
    this.questionId,
    this.testQuestion,
    this.optionId,
    this.optionId1,
    this.optionId2,
    this.optionId3,
    this.testOption,
    this.answer,
    this.testOption2,
    this.testOption3,
    this.testOption4,
    this.id,
    this.durationInSec,
    this.totalQuestion,
    this.subject,
    this.isAnswer,
    this.isAnswer1,
    this.isAnswer2,
    this.isAnswer3,
    this.marksAllotted,
  });

  factory TestListModel.fromJson(Map<String, dynamic> jsonDe) {
    //  String image='http://projects.creatise.in/school_app'+jsonDe['schools'][0]['cover_image'];
    return TestListModel(
      questionId: jsonDe['question_id'],
      testQuestion: jsonDe['question_text'],
      marksAllotted: jsonDe['marks_allotted'],
      testOption: jsonDe['options'][0]['option_text'],
      testOption2: jsonDe['options'][1]['option_text'],
      testOption3: jsonDe['options'][2]['option_text'],
      testOption4: jsonDe['options'][3]['option_text'],
      answer: jsonDe['options'][0]['is_answer'],
      durationInSec: jsonDe['test']['duration_in_sec'],
      totalQuestion: jsonDe['test']['questions_count'],
      //  subject : jsonDe['subject']['subject_name'],
      id: jsonDe['id'],
      optionId: jsonDe['options'][0]['id'],
      optionId1: jsonDe['options'][1]['id'],
      optionId2: jsonDe['options'][2]['id'],
      optionId3: jsonDe['options'][3]['id'],
      isAnswer: jsonDe['options'][0]['is_answer'],
      isAnswer1: jsonDe['options'][1]['is_answer'],
      isAnswer2: jsonDe['options'][2]['is_answer'],
      isAnswer3: jsonDe['options'][3]['is_answer'],
    );
  }
}
