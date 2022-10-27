import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/characters_cubit.dart';
import '../../constants/my_colors.dart';
import '../../data/models/characters_model.dart';
import '../screens/characters_screen.dart';
import 'characters_item.dart';

List<CharacterModel>? allCharacters;

Widget buildBlocWidget() {
  return BlocBuilder<CharactersCubit, CharactersState>(
    builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters;
        return buildLoadedListWidget();
      } else {
        return showLoadedIndicator();
      }
    },
  );
}

Widget showLoadedIndicator() {
  return const Center(
    child: CircularProgressIndicator(
      color: MyColors.myYellow,
    ),
  );
}

Widget buildLoadedListWidget() {
  return SingleChildScrollView(
    child: Container(
      color: MyColors.myGrey,
      child: Column(
        children: [
          buildCharactersList(),
        ],
      ),
    ),
  );
}

Widget buildCharactersList() {
  return GridView.builder(
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 1,
      childAspectRatio: 2 / 3,
      mainAxisSpacing: 1,
    ),
    physics: const BouncingScrollPhysics(),
    shrinkWrap: true,
    itemCount: textSearchControl.text.isEmpty ? allCharacters?.length : searchForItem?.length,
    itemBuilder: (context, index) {
      return CharacterItem(
        characterModel: textSearchControl.text.isEmpty ? allCharacters![index] : searchForItem![index],
      );
    },
  );
}
