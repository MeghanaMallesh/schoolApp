class StudentDairy {
  int id;
  String title;
  String date;
  String description;
  int attachmentCount;
  String memoFor;
  String memoType;
  String schoolName;
  List attachments;

  StudentDairy(
      {this.id,
      this.date,
      this.description,
      this.title,
      this.attachmentCount,
      this.memoFor,
      this.memoType,
      this.attachments,
      this.schoolName});

  factory StudentDairy.fromJson(Map<String, dynamic> jsonDe) {
    int attachmentCount =
        (jsonDe['attachment'].length > 0) ? jsonDe['attachment'].length : 0;
    print(attachmentCount);
    //  String clr=(jsonDe[1]['memo_type']['color_code']);
    print(jsonDe['attachment']);
    return StudentDairy(
        id: jsonDe['id'],
        title: jsonDe['title'],
        description: jsonDe['description'],
        date: jsonDe['date'],
        attachmentCount: attachmentCount,
        attachments: ['attchment'],
        memoFor: jsonDe['memo_for'],
        memoType: jsonDe['memo_type']['color_code']);
  }
}
