import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:inview_notifier_list/inview_notifier_list.dart';
import 'package:flutter/services.dart' as rootBundle;

import './data/Product.dart';
import './videoPlayer.dart';

class VideoList extends StatefulWidget {
  const VideoList({Key? key}) : super(key: key);

  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  List<ProductDataModel> item = [];
  var scr = false;

  Future<void> readJson() async {
    final String response =
        await rootBundle.rootBundle.loadString('lib/data/dataset.json');
    final data = await json.decode(response) as List<dynamic>;
    setState(() {
      item = data.map((e) => ProductDataModel.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    readJson();
    return Stack(fit: StackFit.expand, children: <Widget>[
      InViewNotifierList(
        scrollDirection: Axis.vertical,
        initialInViewIds: ['0'],
        isInViewPortCondition:
            (double deltaTop, double deltaBottom, double viewPortDimension) {
          return deltaTop < (0.5 * viewPortDimension) &&
              deltaBottom > (0.5 * viewPortDimension);
        },
        itemCount: item.length,
        builder: (BuildContext context, int index) {
          return Container(
            width: double.infinity,
            height: 300.0,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: 15.0),
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return InViewNotifierWidget(
                  id: '$index',
                  builder:
                      (BuildContext context, bool isInView, Widget? child) {
                    return VideoPlay(
                      url: item[index].videoUrl.toString(),
                      play: isInView,
                      name: item[index].title.toString(),
                      covPic: item[index].coverPicture.toString(),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
      Align(
        alignment: Alignment.center,
        child: Container(
          height: 1.0,
          color: Colors.redAccent,
        ),
      )
    ]);
  }
}
