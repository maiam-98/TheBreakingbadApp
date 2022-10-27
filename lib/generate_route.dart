import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/business_logic/characters_cubit.dart';
import 'package:movies_app/constants/string.dart';
import 'package:movies_app/data/models/characters_model.dart';
import 'package:movies_app/data/repository/characters_repository.dart';
import 'package:movies_app/data/web_services/characters_web_services.dart';
import 'package:movies_app/presentation/screens/characters_details.dart';
import 'package:movies_app/presentation/screens/characters_screen.dart';

class AppRoute {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRoute() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) => charactersCubit,
                child: const CharactersScreen()));

      case charactersDetailsScreen:
        final characterModel = settings.arguments as CharacterModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CharactersCubit(charactersRepository),
            child: CharacterDetailsScreen(
              characterModel: characterModel,
            ),
          ),
        );
    }
  }
}
