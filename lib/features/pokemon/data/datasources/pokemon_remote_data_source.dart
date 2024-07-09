import 'dart:convert';

import 'package:http/http.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../core/params/params.dart';
import '../models/pokemon_model.dart';

abstract class PokemonRemoteDataSource {
  Future<PokemonModel> getPokemon({required PokemonParams params});
}

class PokemonRemoteDataSourceImpl implements PokemonRemoteDataSource {
  PokemonRemoteDataSourceImpl();

  @override
  Future<PokemonModel> getPokemon({required PokemonParams params}) async {
    final response =
        await get(Uri.parse('https://pokeapi.co/api/v2/pokemon/${params.id}'));
    final data = jsonDecode(response.body);

    if (data != null) {
      return PokemonModel.fromJson(data);
    } else {
      throw ServerException();
    }
  }
}
