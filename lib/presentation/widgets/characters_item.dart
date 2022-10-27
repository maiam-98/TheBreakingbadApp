import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/constants/my_colors.dart';
import 'package:movies_app/constants/string.dart';
import 'package:movies_app/data/models/characters_model.dart';

class CharacterItem extends StatelessWidget {
  final CharacterModel characterModel;

  const CharacterItem({Key? key, required this.characterModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(8),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, charactersDetailsScreen, arguments: characterModel),
        child: GridTile(
          footer: Hero(
            tag: characterModel.charId,
            child: Container(
              alignment: Alignment.bottomCenter,
              color: Colors.black45,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Text(
                characterModel.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: MyColors.myWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          child: Container(
            color: Colors.white,
            child: characterModel.image.isNotEmpty
                ? FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading.gif',
                    placeholderFit: BoxFit.contain,
                    image: characterModel.image,
                    fit: BoxFit.cover,
                  )
                : Image.asset(
                    'assets/images/anonymous_person.jpg',
                  ),
          ),
        ),
      ),
    );
  }
}
