import 'dart:async';

import 'package:giphy_client/giphy_client.dart';
import 'package:giphy_flutter/giphy_client_provider.dart';

import 'bloc_base.dart';

class GiphyBloc implements BlocBase {
  StreamController<List<GiphyGif>> _gifListController = StreamController<List<GiphyGif>>.broadcast();
  StreamSink<List<GiphyGif>> get _inAddGifsSink => _gifListController.sink;
  Stream<List<GiphyGif>> get outGifList => _gifListController.stream; //streambuilder

  StreamController<String> _addSearchWordController = StreamController<String>();
  StreamSink<String> get addSearchWordExternal => _addSearchWordController.sink;

  GiphyBloc() {

    _getTrendingGifs();

    _addSearchWordController.stream.listen(_handleGifSearch);
  }

  _getTrendingGifs() {
    print('nihao, poluchaem trendingy');
    GiphyClientProvider.giphyClientProvider.giphyClient.trending(limit: 22).then((result) {
      print('tip poluchili ' + result.data.length.toString());
      _inAddGifsSink.add(result.data);
    });
  }


  _handleGifSearch(String searchWord) {
    print('nihao, hendlim serch');
    GiphyClientProvider.giphyClientProvider.giphyClient.search(searchWord, limit: 15).then((result) => _inAddGifsSink.add(result.data));
  }


  @override
  void dispose(){
    _gifListController.close();
    _addSearchWordController.close();
  }
}
