part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoaded extends CharactersState {
   final List<CharacterModel> characters;

   CharactersLoaded(this.characters);
}

class CharactersError extends CharactersState{}

class CharacterQuotesLoaded extends CharactersState {
   final List<QuoteModel> quotes;

   CharacterQuotesLoaded(this.quotes);
}