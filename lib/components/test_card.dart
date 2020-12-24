import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape_small.dart';
import 'package:schoolapp/models/quiz_test.dart';
import 'dart:core';
import 'package:schoolapp/screens/quiz_questions2.dart';

class TestCard extends StatefulWidget {
  final TestListModel _testlist;

  TestCard(this._testlist);

  @override
  _TestCardState createState() => _TestCardState(_testlist);
}

class _TestCardState extends State<TestCard> {
  final TestListModel tlist;
  var unescape = new HtmlUnescape();

  _TestCardState(this.tlist);
  bool click = true;
  bool click2 = true;
  bool click3 = true;
  bool click4 = true;
  bool _loading = false;

  hexcolor(String colorhexcode) {
    String colornew = '0xff' + colorhexcode;
    colornew = colornew.replaceAll('#', '');
    int colorint = int.parse(colornew);
    return colorint;
  }

  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                !_loading
                    ? Container(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Card(
                            elevation: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .70,
                                    child: Text(
                                      unescape.convert(tlist.testQuestion),
                                      textAlign: TextAlign.left,
                                      maxLines: null,
                                      overflow: TextOverflow.clip,
                                      softWrap: true,
                                      style: TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 13,
                                  ),
                                  InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('a)'),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .63,
                                                child: (Text(
                                                  unescape.convert(
                                                    tlist.testOption,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                  maxLines: null,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Icon(
                                            Icons.check_circle,
                                            color: click
                                                ? Colors.grey
                                                : Color(hexcolor('#113F67')),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      qnState.answerOption(
                                        questionId: tlist.id,
                                        optionId: tlist.optionId,
                                        isCorrectAns: tlist.isAnswer,
                                        answerPoints: tlist.marksAllotted,
                                        //   },
                                      );
                                      setState(() {
                                        click = false;
                                        click2 = true;
                                        click3 = true;
                                        click4 = true;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  InkWell(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 5, bottom: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            //   Text('b)' + '  ' + 'Chlorophyll'),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text('b)'),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      .63,
                                                  child: Text(
                                                    unescape.convert(
                                                        tlist.testOption2),
                                                    //   Option2,
                                                    //   'Chlorophyll',
                                                    textAlign: TextAlign.left,
                                                    maxLines: null,
                                                    softWrap: true,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),

                                            SizedBox(
                                              width: 8,
                                            ),
                                            Icon(
                                              Icons.check_circle,
                                              color: click2
                                                  ? Colors.grey
                                                  : Color(hexcolor('#113F67')),
                                            ),
                                          ],
                                        ),
                                      ),
                                      onTap: () {
                                        qnState.answerOption(
                                          questionId: tlist.id,
                                          optionId: tlist.optionId1,
                                          isCorrectAns: tlist.isAnswer1,
                                          answerPoints: tlist.marksAllotted,
                                          //   },
                                        );
                                        setState(() {
                                          click = true;
                                          click2 = false;
                                          click3 = true;
                                          click4 = true;
                                        });
                                      }),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('c)'),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .63,
                                                child: Text(
                                                  unescape.convert(
                                                      tlist.testOption3),
                                                  //     Option3,
                                                  //   'Carotenoid',

                                                  textAlign: TextAlign.left,
                                                  maxLines: null,
                                                  //   overflow: TextOverflow.clip,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Icon(
                                            Icons.check_circle,
                                            color: click3
                                                ? Colors.grey
                                                : Color(hexcolor('#113F67')),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      qnState.answerOption(
                                        questionId: tlist.id,
                                        optionId: tlist.optionId2,
                                        isCorrectAns: tlist.isAnswer2,
                                        answerPoints: tlist.marksAllotted,
                                        //   },
                                      );
                                      setState(() {
                                        click3 = false;
                                        click2 = true;
                                        click4 = true;
                                        click = true;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  InkWell(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 5, bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('d)'),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    .63,
                                                child: Text(
                                                  unescape.convert(
                                                      tlist.testOption4),
                                                  //   Option4,
                                                  //    'Carotenoid',
                                                  textAlign: TextAlign.left,
                                                  maxLines: null,
                                                  softWrap: true,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 8,
                                          ),
                                          Icon(
                                            Icons.check_circle,
                                            color: click4
                                                ? Colors.grey
                                                : Color(hexcolor('#113F67')),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      qnState.answerOption(
                                        questionId: tlist.id,
                                        optionId: tlist.optionId3,
                                        isCorrectAns: tlist.isAnswer3,
                                        answerPoints: 10,
                                        //   },
                                      );
                                      setState(() {
                                        click4 = false;
                                        click3 = true;
                                        click2 = true;
                                        click = true;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ))
                    : Container(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
