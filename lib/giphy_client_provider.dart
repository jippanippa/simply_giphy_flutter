import 'dart:io';

import 'package:giphy_client/giphy_client.dart';
import 'package:path/path.dart';

class GiphyClientProvider {
  GiphyClientProvider._();

  static final GiphyClientProvider giphyClientProvider = GiphyClientProvider._();

  GiphyClient _giphyClient;
//  Database _database;

//  Future<GiphyClient> get database async {
  GiphyClient get giphyClient {

//    if (_giphyClient != null) return _giphyClient;
//    else {
//      _giphyClient = new GiphyClient(apiKey: 'JHZIUHfUnGI3EXFJtdqtPn12vQm8AOJa');
//
//    }
//
    if(_giphyClient == null) {
      _giphyClient = GiphyClient(apiKey: 'JHZIUHfUnGI3EXFJtdqtPn12vQm8AOJa');
    }

    return _giphyClient;

  }
}
