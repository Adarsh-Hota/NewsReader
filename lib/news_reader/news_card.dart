import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:newsreader/news_reader/view_news_screen.dart';
import 'package:newsreader/utils.dart';
import 'package:intl/intl.dart';

class NewsHeadline extends StatelessWidget {
  final String author;
  final String title;
  final String description;
  final String img;
  final String date;
  final String url;
  final FlutterTts flutterTts = FlutterTts();

  //Constructor
  NewsHeadline(
      {Key? key,
      required this.author,
      required this.title,
      required this.description,
      required this.img,
      required this.date,
      required this.url})
      : super(key: key);

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1);
    await flutterTts.setVolume(1);
    await flutterTts.speak(text);
  }

  Future<void> _stop() async {
    await flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 10, right: 5, bottom: 10),
      child:

          //News card
          Card(
        elevation: 5,
        child:

            //Row
            Row(children: [
          //Image
          img == ""
              ? SizedBox(
                  width: MediaQuery.of(context).size.width * 0.33,
                  height: 140,
                  child: const Image(
                    image:
                        AssetImage('assets/images/resource_not_available.png'),
                    fit: BoxFit.cover,
                  ),
                )
              : Image(
                  width: MediaQuery.of(context).size.width * 0.33,
                  height: 140,
                  image: NetworkImage(img),
                  fit: BoxFit.fill,
                ),

          //Content
          Flexible(
            fit: FlexFit.loose,
            child: Padding(
              padding: const EdgeInsets.only(
                  left: 10, top: 12, right: 12, bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //News headline
                  Flexible(
                    fit: FlexFit.loose,
                    child: Text(
                      title,
                      overflow: TextOverflow.fade,
                      style: textStyle(16, Colors.grey, FontWeight.bold),
                    ),
                  ),

                  const Flexible(
                    fit: FlexFit.loose,
                    child: SizedBox(
                      height: 8,
                    ),
                  ),

                  //Author name and published date
                  Flexible(
                    fit: FlexFit.loose,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //Author name
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            author,
                            overflow: TextOverflow.ellipsis,
                            style: textStyle(14, Colors.grey, FontWeight.bold),
                          ),
                        ),

                        //Published data
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            date == ''
                                ? ''
                                : DateFormat.yMd().format(DateTime.parse(date)),
                            overflow: TextOverflow.ellipsis,
                            style: textStyle(14, Colors.grey, FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),

                  //Spcae
                  const Flexible(
                    fit: FlexFit.loose,
                    child: SizedBox(
                      height: 8,
                    ),
                  ),

                  //Buttons
                  Flexible(
                    fit: FlexFit.loose,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          //Play button
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () => _speak(description),
                                child: const Icon(
                                  Icons.play_arrow_sharp,
                                  size: 40,
                                  color: Colors.yellow,
                                ),
                              ),

                              //Stop button
                              InkWell(
                                onTap: () => _stop(),
                                child: const Icon(
                                  Icons.stop,
                                  size: 40,
                                  color: Colors.redAccent,
                                ),
                              ),
                            ],
                          ),

                          //View button
                          SizedBox(
                            width: 70,
                            height: 32,
                            child: TextButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ViewNewsScreen(url: url),
                                ),
                              ),
                              style: TextButton.styleFrom(
                                  backgroundColor: Colors.yellow),
                              child: Text(
                                'View',
                                style: textStyle(
                                    15, Colors.black, FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
