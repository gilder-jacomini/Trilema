import 'package:trilema/data/temas_padrao.dart';
import 'package:trilema/models/tema.dart';

class TemaRepository {
  static final List<Tema> temas = temasPadrao.map(
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
}