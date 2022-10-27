import 'package:movies_app/data/models/characters_model.dart';
import 'package:movies_app/data/models/quote_model.dart';
import 'package:movies_app/data/web_services/characters_web_services.dart';

class CharactersRepository {

  CharactersWebServices charactersWebServices;

  CharactersRepository (this.charactersWebServices);

  Future<List<CharacterModel>> getAllCharacters() async{
    var characters = await charactersWebServices.getAllCharacters();
    return characters.map((character) => CharacterModel.fromJson(character)).toList();
  }

  Future<List<QuoteModel>> getCharQuote(String charName) async{
    var quotes = await charactersWebServices.getCharQuote(charName);
    return quotes.map((quote) => QuoteModel.fromJson(quote)).toList();
  }

}