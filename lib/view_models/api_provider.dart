// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/character_model.dart';

class ApiProvider with ChangeNotifier {
  final url = 'rickandmortyapi.com';
  List<Character> characters = [];

  Future<void> getCharacters(int page) async {
    final resutl = await http
        .get(Uri.https(url, "/api/character", {'page': page.toString()}));
    final response = characterModelFromJson(resutl.body);
    characters.addAll(response.results!);
    notifyListeners();
  }
}
