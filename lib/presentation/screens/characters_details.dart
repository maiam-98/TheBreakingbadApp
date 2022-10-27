import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/business_logic/characters_cubit.dart';
import 'package:movies_app/constants/my_colors.dart';
import 'package:movies_app/data/models/characters_model.dart';
import 'package:movies_app/data/models/quote_model.dart';

import '../widgets/show_characters.dart';

class CharacterDetailsScreen extends StatelessWidget {
  CharacterModel characterModel;

  CharacterDetailsScreen({Key? key, required this.characterModel})
      : super(key: key);

  Widget buildSliverAppBar() {
    return SliverAppBar(
      backgroundColor: MyColors.myGrey,
      pinned: true,
      expandedHeight: 600,
      flexibleSpace: Hero(
        tag: characterModel.charId,
        child: FlexibleSpaceBar(
          title: Text(
            characterModel.nickname,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: MyColors.myWhite,
              fontSize: 18,
            ),
          ),
          background: Image.network(
            characterModel.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      text: TextSpan(children: [
        TextSpan(
          text: title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: MyColors.myWhite,
          ),
        ),
        TextSpan(
          text: value,
          style: const TextStyle(
            fontSize: 14,
            color: MyColors.myWhite,
          ),
        ),
      ]),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      endIndent: endIndent,
      thickness: 2,
      height: 30,
      color: MyColors.myYellow,
    );
  }

  Widget quoteRandomAreLoaded(CharactersState state) {
    if (state is CharacterQuotesLoaded) {
      return displayQuoteRandomOrEmpty(state);
    } else {
      return showLoadedIndicator();
    }
  }

  Widget displayQuoteRandomOrEmpty(state) {
    final quote = (state).quotes;
    var quoteRandom = Random().nextInt(quote.length - 1);
    if (quote.length != 0) {
      return Center(
        child: DefaultTextStyle(
          style: const TextStyle(
            fontSize: 20.0,
          ),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(quote[quoteRandom].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getCharQuote(characterModel.name);
    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsetsDirectional.fromSTEB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  color: MyColors.myGrey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo(' Job : ', characterModel.job.join(' / ')),
                      buildDivider(330),
                      characterInfo('Appeared in : ',
                          characterModel.categoryForTwoSeries),
                      buildDivider(250),
                      characterInfo('Seasons : ',
                          characterModel.appearanceOfSeason.join(' / ')),
                      buildDivider(280),
                      characterInfo(
                          'Status : ', characterModel.statusIfDeadOrLive),
                      buildDivider(300),
                      characterModel.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : characterInfo(
                              'Better Call Soul Seasons : ',
                              characterModel.betterCallSaulAppearance
                                  .join(' / ')),
                      characterModel.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : buildDivider(150),
                      characterInfo(
                          'Actor/Actress : ', characterModel.actorName),
                      buildDivider(235),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<CharactersCubit, CharactersState>(
                          builder: (context, state) {
                        return quoteRandomAreLoaded(state);
                      }),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 500,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
