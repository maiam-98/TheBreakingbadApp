import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:movies_app/data/models/quote_model.dart';

import '../data/models/characters_model.dart';
import '../data/repository/characters_repository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {

  CharactersRepository charactersRepository;
   List<CharacterModel> characters = [];

  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<CharacterModel> getAllCharacters(){
     charactersRepository.getAllCharacters().then((characters) {
       emit(CharactersLoaded(characters));
       this.characters = characters;
     }).catchError((error){
       emit(CharactersError());
     });
    return characters;
  }

  void getCharQuote(String charName){
    charactersRepository.getCharQuote(charName).then((quotes) {
      emit(CharacterQuotesLoaded(quotes));
    });
  }

}
