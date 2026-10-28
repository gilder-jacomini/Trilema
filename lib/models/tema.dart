import 'trilema.dart';

class Tema {
  final String nome;
  final String emoji;
  final List<Trilema> trilemas;

  const Tema({
    required this.nome,
    required this.emoji,
    required this.trilemas,
  });

  Map<String, dynamic> toMap() {
    return {
      'nome': nome,
      'emoji': emoji,
      'trilemas': trilemas
          .map((trilema) => trilema.toMap())
          .toList(),
    };
  }

  factory Tema.fromMap(
    Map<String, dynamic> map,
  ) {
    return Tema(
      nome: map['nome'],
      emoji: map['emoji'],
      trilemas: (map['trilemas'] as List)
          .map(
            (item) => Trilema.fromMap(item),
          )
          .toList(),
    );
  }
}