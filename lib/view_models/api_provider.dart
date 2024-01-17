// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rickandmortyapp/models/episode_model.dart';
import '../models/character_model.dart';

class ApiProvider with ChangeNotifier {
  final url = 'rickandmortyapi.com';
  List<Character> characters = [];
  List<EpisodeModel> episodes = [];

  Future<void> getCharacters(int page) async {
    final resutl = await http
        .get(Uri.https(url, "/api/character", {'page': page.toString()}));
    final response = characterModelFromJson(resutl.body);
    characters.addAll(response.results!);
    notifyListeners();
  }

  Future<List<EpisodeModel>> getEpisodes(Character character) async {
    episodes = [];
    for (var i = 0; i < character.episode!.length; i++) {
      final result = await http.get(Uri.parse(character.episode![i]));
      final response = episodeModelFromJson(result.body);
      episodes.add(response);
      notifyListeners();
    }
    return episodes;
  }

  Future<List<Character>> getCharacter(String name) async {
    final result =
        await http.get(Uri.https(url, "/api/character", {'name': name}));
    final response = characterModelFromJson(result.body);
    return response.results!;
  }
}
