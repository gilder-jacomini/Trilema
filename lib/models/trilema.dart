class Trilema {
  String titulo;
  List<String> opcoes;
  bool criadoPeloUsuario;

  Trilema({
    required this.titulo,
    required this.opcoes,
    this.criadoPeloUsuario = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'opcoes': opcoes,
      'criadoPeloUsuario': criadoPeloUsuario,
    };
  }

  factory Trilema.fromMap(Map<String, dynamic> map) {
    return Trilema(
      titulo: map['titulo'],
      opcoes: List<String>.from(map['opcoes']),
      criadoPeloUsuario: map['criadoPeloUsuario'] ?? false,
    );
  }
}
