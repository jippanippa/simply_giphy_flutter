import 'package:flutter/material.dart';
import 'package:giphy_client/giphy_client.dart';

import 'bloc_base.dart';
import 'bloc_giphy.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const MaterialColor simplyGiphyColor =
      const MaterialColor(0xFF241B6D, const <int, Color>{
    50: const Color(0xFF241B6D),
    100: const Color(0xFF242B6D),
    200: const Color(0xFF243B6D),
    300: const Color(0xFF244B6D),
    400: const Color(0xFF245B6D),
    500: const Color(0xFF246B6D),
    600: const Color(0xFF247B6D),
    700: const Color(0xFF248B6D),
    800: const Color(0xFF249B6D),
    900: const Color(0xFF249B6D),
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Simply Giphy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: simplyGiphyColor,
        ),
        home: BlocProvider<GiphyBloc>(
          bloc: GiphyBloc(),
          child: SimplyGiphyHomePage(),
        ));
  }
}


class SimplyGiphyHomePage extends StatefulWidget {
  SimplyGiphyHomePage({Key key}) : super(key: key);

  @override
  _SimplyGiphyHomePageState createState() {
    return _SimplyGiphyHomePageState();
  }
}

class _SimplyGiphyHomePageState extends State<SimplyGiphyHomePage> {
  TextEditingController _textSearchController = TextEditingController();

  GiphyBloc giphyBloc;

  @override
  void initState() {
    super.initState();
    giphyBloc = BlocProvider.of<GiphyBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text('Simply '),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.5),
              child: Image.asset('assets/giphy_logo_original.png'),
            )
          ],
        ),
      ),
      body: Center(
        child: StreamBuilder<List<GiphyGif>>(
            stream: giphyBloc.outGifList,
            initialData: [],
            builder:
                (BuildContext context, AsyncSnapshot<List<GiphyGif>> snapshot) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
//                      TextField(
//                        controller: _textSearchController,
//                        decoration: InputDecoration(labelText: 'Поиск'),
//                      ),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          children: snapshot.data.map((giphyGif) {
                            return Image.network(giphyGif.images.previewGif.url,
                                fit: BoxFit.cover);
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                );
            }),
      ),
    );
  }
}
