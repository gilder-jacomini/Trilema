import 'package:flutter/material.dart';
import 'package:trilema/data/temas_padrao.dart';
import 'package:trilema/models/tema.dart';
import 'package:trilema/repositories/tema_repository.dart';
import 'package:trilema/widgets/trilema_card.dart';
import 'package:trilema/screens/novo_trilema_page.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

import 'package:trilema/services/firebase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await TemaRepository.carregar();

  runApp(const TrilemaApp());
}

class TrilemaApp extends StatelessWidget {
  const TrilemaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TRILEMA',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0D0D0D),

        colorScheme: ColorScheme.dark(primary: Colors.yellow.shade700),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final int totalTrilemas = TemaRepository.temas.fold(
      0,
      (total, tema) => total + tema.trilemas.length,
    );
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),

            Image.asset('assets/images/logo-trilema.png', height: 160),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$totalTrilemas trilemas disponíveis',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            const SizedBox(height: 8),

            const SizedBox(height: 30),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Temas',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: TemaRepository.temas.length,
                itemBuilder: (context, index) {
                  final Tema tema = TemaRepository.temas[index];

                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () async {
                        try {
                          await TrilemaFirebaseService.registrarTemaAcessado(
                            tema.nome,
                          );
                        } catch (e) {
                          print('ERRO FIREBASE: $e');
                        }

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => TemaPage(tema: tema),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  tema.emoji,
                                  style: const TextStyle(fontSize: 30),
                                ),

                                const SizedBox(width: 12),

                                Expanded(
                                  child: Text(
                                    tema.nome,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '${tema.trilemas.length}',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),

                                const Icon(Icons.arrow_forward_ios, size: 16),
                              ],
                            ),

                            const SizedBox(height: 12),

                            ...tema.trilemas.map(
                              (trilema) => Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  '• ${trilema.opcoes.join(" × ")}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: Colors.grey.shade300,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Criar Novo Trilema'),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NovoTrilemaPage(),
                      ),
                    );

                    setState(() {});
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TemaPage extends StatefulWidget {
  final Tema tema;

  const TemaPage({super.key, required this.tema});

  @override
  State<TemaPage> createState() => _TemaPageState();
}

class _TemaPageState extends State<TemaPage> {
  Tema get temaAtual {
    return TemaRepository.temas.firstWhere(
      (tema) => tema.nome == widget.tema.nome,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(temaAtual.nome)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '${temaAtual.emoji} ${widget.tema.nome}',
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          ...temaAtual.trilemas.map(
            (trilema) => TrilemaCard(
              trilema: trilema,

              onExcluir: () async {
                temaAtual.trilemas.remove(trilema);

                await TemaRepository.salvar();

                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }
}
