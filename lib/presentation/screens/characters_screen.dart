import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:movies_app/business_logic/characters_cubit.dart';
import 'package:movies_app/constants/my_colors.dart';

import '../../data/models/characters_model.dart';
import '../widgets/show_characters.dart';

var textSearchControl = TextEditingController();
List<CharacterModel>? searchForItem;
bool isSearched = false;

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildSearchField() {
    return TextField(
      controller: textSearchControl,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Find a character...',
        hintStyle: TextStyle(
          color: MyColors.myGrey,
          fontSize: 16,
        ),
      ),
      style: const TextStyle(
        color: MyColors.myGrey,
        fontSize: 16,
      ),
      onChanged: (searchedCharacters) {
        addSearchForItemToAllCharacters(searchedCharacters);
      },
    );
  }

  void addSearchForItemToAllCharacters(String searchedCharacters) {
    searchForItem = allCharacters!
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacters))
        .toList();
    setState(() {});
  }

  List<Widget> buildActionAppBar() {
    if (isSearched) {
      return [
        IconButton(
          onPressed: () {
            cleanSearchText();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: MyColors.myGrey,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: () {
            startSearch();
          },
          icon: const Icon(
            Icons.search,
            color: MyColors.myGrey,
          ),
        ),
      ];
    }
  }

  void startSearch() {
    ModalRoute.of(context)!.addLocalHistoryEntry(
      LocalHistoryEntry(
        onRemove: stopSearch,
      ),
    );
    setState(() {
      isSearched = true;
    });
  }

  void stopSearch() {
    cleanSearchText();
    setState(() {
      isSearched = false;
    });
  }

  void cleanSearchText() {
    textSearchControl.clear();
  }

  Widget buildAppBarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(
          color: MyColors.myGrey,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          height: 1.5),
    );
  }

  Widget buildNoInternet() {
    return Center(
      child: Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Can\'t connect... Check your Internet',
              style: TextStyle(
                fontSize: 20,
                color: MyColors.myGrey,
              ),
            ),
            Image.asset('assets/images/warning.png'),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: isSearched ? buildSearchField() : buildAppBarTitle(),
        leading: isSearched
            ? const BackButton(
                color: MyColors.myGrey,
              )
            : null,
        actions: buildActionAppBar(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;

          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternet();
          }
        },
        child: showLoadedIndicator(),
      ),
    );
  }
}
