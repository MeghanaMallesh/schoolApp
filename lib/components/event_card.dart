import 'package:flutter/material.dart';
import 'package:schoolapp/Screens/event_detailpage.dart';
import 'package:schoolapp/models/student_dairy.dart';

class EventCard extends StatefulWidget {
  final StudentDairy _eventlist;
  EventCard(this._eventlist);

  @override
  EventCardState createState() => EventCardState(_eventlist);
}

class EventCardState extends State<EventCard> {
  bool attachment = false;

  final StudentDairy elist;
  EventCardState(this.elist);

  hexcolor(String colorhexcode) {
    String colornew = '' + colorhexcode;
    colornew = colornew.replaceAll('#', '0xff');
    int colorint = int.parse(colornew);
    return colorint;
  }

  @override
  Widget build(BuildContext context) {
    double d_width = MediaQuery.of(context).size.width * 1;
    double c_width = MediaQuery.of(context).size.width * 0.7;
    return Column(
      children: <Widget>[
        SizedBox(
          height: 5,
        ),
        InkWell(
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(
                    //                   <--- left side
                    color: Color(hexcolor(elist.memoType.toString())),
                    width: 3.0,
                  ),
                ),
              ),
              //  width: 340,
              child: Card(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              width: c_width,
                              child: Text(
                                elist.title,
                                textAlign: TextAlign.left,
                                maxLines: null,
                                overflow: TextOverflow.clip,
                                softWrap: true,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w400),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 17,
                              width: 47,
                              decoration: new BoxDecoration(
                                color:
                                    Color(hexcolor(elist.memoType.toString())),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Text(
                                elist.memoFor,
                                //   'Holiday',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              elist.date,
                              //      '05 Tue, 2019',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black54),
                            ),
                            elist.attachmentCount != 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        elist.attachmentCount.toString(),
                                        //  '2',
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black54),
                                      ),
                                      //  SizedBox(width: 1,),
                                      Icon(
                                        Icons.attach_file,
                                        size: 13,
                                      ),
                                    ],
                                  )
                                : Container(),
                            //        :Container()
                          ],
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          width: d_width,
                          child: Text(
                            elist.description,
                            //    address1,
                            //     'No.16 halalli, 8th Cross, Main road, Mysore Road , Bangalore-560067.',
                            textAlign: TextAlign.left,
                            maxLines: null,
                            overflow: TextOverflow.clip,
                            softWrap: true,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          onTap: () {
            //      Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(eventId: elist.id),
              ),
            );
          },
        ),
      ],
    );
  }
}
