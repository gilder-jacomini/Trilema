class Trilema {
  final String titulo;
  final List<String> opcoes;

  const Trilema({
    required this.titulo,
    required this.opcoes,
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'opcoes': opcoes,
    };
  }

  factory Trilema.fromMap(
    Map<String, dynamic> map,
  ) {
    return Trilema(
      titulo: map['titulo'],
      opcoes: List<String>.from(
        map['opcoes'],
      ),
    );
  }
}