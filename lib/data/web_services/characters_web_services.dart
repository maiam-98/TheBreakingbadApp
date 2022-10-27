import 'package:dio/dio.dart';
import 'package:movies_app/constants/string.dart';
import 'package:movies_app/data/models/characters_model.dart';

class CharactersWebServices {
  Dio? dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: 20 * 1000, //20 seconds
      receiveTimeout: 20 * 1000,
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio!.get('characters');
      return response.data;
    } catch (error) {
      print(error.toString());
      return [];
    }
  }

  Future<List<dynamic>> getCharQuote(charName) async {
    try {
      Response response = await dio!.get('quote', queryParameters: {'author' : charName}, );
      return response.data;
    } catch (error) {
      print(error.toString());
      return [];
    }
  }

}
