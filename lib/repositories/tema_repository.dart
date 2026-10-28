import 'dart:convert';

import 'package:trilema/data/temas_padrao.dart';
import 'package:trilema/models/tema.dart';
import 'package:trilema/services/storage_service.dart';

class TemaRepository {

  static List<Tema> temas = temasPadrao.map(
    (tema) {
      return Tema(
        nome: tema.nome,
        emoji: tema.emoji,
        trilemas: List.from(
          tema.trilemas,
        ),
      );
    },
  ).toList();

  static Future<void> salvar() async {

    final lista = temas
        .map((tema) => tema.toMap())
        .toList();

    final json = jsonEncode(lista);

    await StorageService.salvarJson(
      json,
    );
  }

  static Future<void> carregar() async {

    final json =
        await StorageService.carregarJson();

    if (json == null) {
      return;
    }

    final dados =
        jsonDecode(json) as List;

    temas = dados.map(
      (item) {
        return Tema.fromMap(item);
      },
    ).toList();
  }
}