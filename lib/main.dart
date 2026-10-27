import 'package:flutter/material.dart';
import 'package:trilema/data/temas_padrao.dart';
import 'package:trilema/models/tema.dart';


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
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
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

            const Icon(
              Icons.balance,
              size: 90,
              color: Colors.deepPurple,
            ),

            const SizedBox(height: 12),

            const Text(
              'TRILEMA',
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Toda escolha tem um custo.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 30),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Temas',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
  child: ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 16),
    itemCount: temasPadrao.length,
    itemBuilder: (context, index) {

      final Tema tema = temasPadrao[index];

      return Card(
        elevation: 2,
        child: ListTile(
          leading: Text(
            tema.emoji,
            style: const TextStyle(fontSize: 28),
          ),
          title: Text(
            tema.nome,
          ),
          subtitle: Text(
            '${tema.trilemas.length} trilemas',
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TemaPage(
                  tema: tema,
                ),
              ),
            );
          },
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
                  label:
                      const Text('Criar Novo Trilema'),
                  onPressed: () {},
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

  const TemaPage({
    super.key,
    required this.tema,
  });

  @override
  State<TemaPage> createState() => _TemaPageState();
}

class _TemaPageState extends State<TemaPage> {
  final List<bool> ativos = [false, false, false];
  final List<int> fila = [];

  final List<String> opcoes = [
    'Ter dinheiro',
    'Ter tempo livre',
    'Ter saúde',
  ];

  void alterarSwitch(int index, bool valor) {
    setState(() {
      if (valor) {
        ativos[index] = true;

        fila.remove(index);
        fila.add(index);

        if (fila.length > 2) {
          int remover = fila.removeAt(0);
          ativos[remover] = false;
        }
      } else {
        ativos[index] = false;
        fila.remove(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalAtivos = ativos.where((v) => v).length;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tema.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            Text(
              'Ativos: $totalAtivos/2',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            for (int i = 0; i < opcoes.length; i++)
              Card(
                child: SwitchListTile(
                  title: Text(opcoes[i]),
                  value: ativos[i],
                  onChanged: (valor) {
                    alterarSwitch(i, valor);
                  },
                ),
              ),

            const SizedBox(height: 30),

            const Divider(),

            const Text(
              'Sua Escolha',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            for (int i = 0; i < opcoes.length; i++)
              Text(
                '${ativos[i] ? '✅' : '❌'} ${opcoes[i]}',
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}