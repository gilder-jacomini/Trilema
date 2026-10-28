import 'package:flutter/material.dart';
import 'package:trilema/data/temas_padrao.dart';
import 'package:trilema/models/tema.dart';
import 'package:trilema/models/trilema.dart';
import 'package:trilema/repositories/tema_repository.dart';



class NovoTrilemaPage extends StatefulWidget {
  const NovoTrilemaPage({super.key});

  @override
  State<NovoTrilemaPage> createState() => _NovoTrilemaPageState();
}

class _NovoTrilemaPageState extends State<NovoTrilemaPage> {
    Tema? temaSelecionado;

  final tituloController = TextEditingController();
  final opcao1Controller = TextEditingController();
  final opcao2Controller = TextEditingController();
  final opcao3Controller = TextEditingController();

   @override
  void initState() {
    super.initState();

    temaSelecionado = temasPadrao.first;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Trilema'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            DropdownButtonFormField<Tema>(
        value: temaSelecionado,
        decoration: const InputDecoration(
          labelText: 'Tema',
          border: OutlineInputBorder(),
        ),
        items: temasPadrao.map((tema) {
          return DropdownMenuItem<Tema>(
            value: tema,
            child: Text(
              '${tema.emoji} ${tema.nome}',
            ),
          );
        }).toList(),
        onChanged: (Tema? novoTema) {
          setState(() {
            temaSelecionado = novoTema;
          });
        },
      ),

      const SizedBox(height: 16),
            TextField(
              controller: tituloController,
              decoration: const InputDecoration(
                labelText: 'Título',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: opcao1Controller,
              decoration: const InputDecoration(
                labelText: 'Opção 1',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: opcao2Controller,
              decoration: const InputDecoration(
                labelText: 'Opção 2',
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: opcao3Controller,
              decoration: const InputDecoration(
                labelText: 'Opção 3',
              ),
            ),

            const SizedBox(height: 24),

          FilledButton(
           onPressed: () async {

  if (tituloController.text.trim().isEmpty ||
      opcao1Controller.text.trim().isEmpty ||
      opcao2Controller.text.trim().isEmpty ||
      opcao3Controller.text.trim().isEmpty) {

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Preencha todos os campos.',
        ),
      ),
    );

    return;
  }

  final novoTrilema = Trilema(
    titulo: tituloController.text.trim(),
    opcoes: [
      opcao1Controller.text.trim(),
      opcao2Controller.text.trim(),
      opcao3Controller.text.trim(),
    ],
  );

  final indiceTema = TemaRepository.temas.indexWhere(
    (tema) => tema.nome == temaSelecionado!.nome,
  );

  TemaRepository.temas[indiceTema].trilemas
      .add(novoTrilema);
      await TemaRepository.salvar();

  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text(
        'Trilema criado com sucesso!',
      ),
    ),
  );

  Navigator.pop(context);
}, 
  child: const Text('Salvar'),
)
          ],
        ),
      ),
    );
  }
}