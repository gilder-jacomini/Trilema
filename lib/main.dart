import 'package:flutter/material.dart';
import 'package:trilema/data/temas_padrao.dart';
import 'package:trilema/models/tema.dart';
import 'package:trilema/repositories/tema_repository.dart';
import 'package:trilema/widgets/trilema_card.dart';
import 'package:trilema/screens/novo_trilema_page.dart';

void main() {
  runApp(const TrilemaApp());
}

class TrilemaApp extends StatelessWidget {
  const TrilemaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TRILEMA',
      theme: ThemeData(colorSchemeSeed: Colors.deepPurple, useMaterial3: true),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),

            const Icon(Icons.balance, size: 90, color: Colors.deepPurple),

            const SizedBox(height: 12),

            const Text(
              'TRILEMA',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              'Toda escolha tem um custo.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),

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
                      onTap: () {
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
                                    color: Colors.deepPurple.shade100,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    '${tema.trilemas.length}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
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
                                    color: Colors.grey.shade700,
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NovoTrilemaPage(),
                      ),
                    );
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.tema.nome)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            '${widget.tema.emoji} ${widget.tema.nome}',
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          ...widget.tema.trilemas.map(
            (trilema) => TrilemaCard(trilema: trilema),
          ),
        ],
      ),
    );
  }
}
