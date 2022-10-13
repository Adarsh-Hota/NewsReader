// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:newsreader/bloc/get_news_bloc.dart';
import 'package:newsreader/bloc/select_options_bloc.dart';
import 'package:newsreader/modals/news_modal.dart';
import 'package:newsreader/modals/news_list.dart';
import 'package:newsreader/news_reader/news_card.dart';
import 'package:newsreader/utils.dart';

class NewsReader extends StatefulWidget {
  const NewsReader({Key? key}) : super(key: key);

  @override
  State<NewsReader> createState() => _NewsReaderState();
}

class _NewsReaderState extends State<NewsReader> {
  String countryLabel = 'us';
  String categoryLabel = 'general';
  late GetNewsBloc getNewsBloc;
  late SelectControllerBloc selectControllerBloc;

  @override
  void initState() {
    super.initState();
    getNewsBloc = GetNewsBloc();
    getNewsBloc.getNews('us', 'general');
    selectControllerBloc = SelectControllerBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Appbar
      appBar: AppBar(
          backgroundColor: Colors.yellow,
          title: Text(
            'Newsreader',
            style: textStyle(25, Colors.black, FontWeight.w700),
          ),
          actions: [
            StreamBuilder<Object>(
                stream: selectControllerBloc.countryStream,
                initialData: selectControllerBloc.defaultCountry,
                builder: (context, snapshot) {
                  return DropdownButton(
                      value: snapshot.data,
                      items: countryCodes
                          .map((code) => DropdownMenuItem(
                              value: code,
                              child: Text(
                                code,
                                style: textStyle(
                                    20,
                                    snapshot.data == code
                                        ? Colors.black
                                        : Colors.grey,
                                    FontWeight.w600),
                              )))
                          .toList(),
                      onChanged: ((dynamic code) {
                        selectControllerBloc.selectCountry(code);
                        countryLabel = code;
                        getNewsBloc.getNews(code, categoryLabel);
                      }));
                })
          ]),

      //Body
      body: CustomScrollView(slivers: [
        //Space
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        ),

        //Menu containing different categories
        SliverToBoxAdapter(
          child: StreamBuilder<Object>(
              stream: selectControllerBloc.categoryStream,
              initialData: selectControllerBloc.defaultCategory,
              builder: (context, snapshot) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                      children: categories.map((category) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: InkWell(
                        onTap: () {
                          selectControllerBloc.selectCategory(category);
                          categoryLabel = category;
                          getNewsBloc.getNews(countryLabel, category);
                        },
                        child: Text(category,
                            style: textStyle(
                                20,
                                snapshot.data == category
                                    ? Colors.black
                                    : Colors.grey,
                                FontWeight.w600)),
                      ),
                    );
                  }).toList()),
                );
              }),
        ),

        //Space
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 20,
          ),
        ),

        StreamBuilder<NewsResponse>(
            stream: getNewsBloc.subject.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()));
              }

              List<NewsModal>? newsList = snapshot.data!.news;
              return SliverList(
                  delegate: SliverChildBuilderDelegate(
                (context, index) {
                  NewsModal currentNews = newsList![index];
                  return NewsHeadline(
                    author: currentNews.author,
                    title: currentNews.title,
                    description: currentNews.description,
                    img: currentNews.img,
                    date: currentNews.date,
                    url: currentNews.url,
                  );
                },
                childCount: newsList!.length,
              ));
            }),
      ]),
    );
  }
}
