import 'package:cloud_firestore/cloud_firestore.dart';

class TrilemaFirebaseService {
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future<void> registrarTemaAcessado(String tema) async {
    await firestore.collection('temas_acessados').add({
      'tema': tema,
      'dataAcesso': DateTime.now(),
    });
  }

  static Future<void> enviarTrilemaCriado({
    required String tema,
    required String titulo,
    required List<String> opcoes,
  }) async {
    await firestore.collection('trilemas_usuario').add({
      'tema': tema,
      'titulo': titulo,
      'opcoes': opcoes,
      'dataCriacao': DateTime.now(),

      'versaoApp': '1.0.0',
      'origem': 'android',
      'aprovado': false,
    });
  }
}
