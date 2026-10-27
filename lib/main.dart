import 'package:flutter/material.dart';

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
      appBar: AppBar(
        title: const Text('TRILEMA'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.balance,
                size: 90,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 24),

              const Text(
                'TRILEMA',
                style: TextStyle(
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Escolha dois. Abra mão de um.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const TemaPage(),
                    ),
                  );
                },
                child: const Text('Começar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TemaPage extends StatefulWidget {
  const TemaPage({super.key});

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
        title: const Text('Vida Adulta'),
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