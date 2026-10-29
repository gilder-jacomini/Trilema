import 'package:flutter/material.dart';
import 'package:trilema/models/tema.dart';
import 'package:trilema/models/trilema.dart';
import 'package:trilema/repositories/tema_repository.dart';
import 'package:trilema/services/firebase_service.dart';

class NovoTrilemaPage extends StatefulWidget {
  final Trilema? trilemaParaEditar;

  const NovoTrilemaPage({super.key, this.trilemaParaEditar});

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

    temaSelecionado = TemaRepository.temas.first;

    if (widget.trilemaParaEditar != null) {
      temaSelecionado = buscarTemaDoTrilema(widget.trilemaParaEditar!);
    }

    if (widget.trilemaParaEditar != null) {
      tituloController.text = widget.trilemaParaEditar!.titulo;

      opcao1Controller.text = widget.trilemaParaEditar!.opcoes[0];

      opcao2Controller.text = widget.trilemaParaEditar!.opcoes[1];

      opcao3Controller.text = widget.trilemaParaEditar!.opcoes[2];
    }
  }

  Tema? buscarTemaDoTrilema(Trilema trilema) {
    for (final tema in TemaRepository.temas) {
      if (tema.trilemas.contains(trilema)) {
        return tema;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.trilemaParaEditar == null ? 'Novo Trilema' : 'Editar Trilema',
        ),
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
              items: TemaRepository.temas.map((tema) {
                return DropdownMenuItem<Tema>(
                  value: tema,
                  child: Text('${tema.emoji} ${tema.nome}'),
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
              decoration: const InputDecoration(labelText: 'Título'),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: opcao1Controller,
              decoration: const InputDecoration(labelText: 'Opção 1'),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: opcao2Controller,
              decoration: const InputDecoration(labelText: 'Opção 2'),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: opcao3Controller,
              decoration: const InputDecoration(labelText: 'Opção 3'),
            ),

            const SizedBox(height: 24),

            FilledButton(
              onPressed: () async {
                if (tituloController.text.trim().isEmpty ||
                    opcao1Controller.text.trim().isEmpty ||
                    opcao2Controller.text.trim().isEmpty ||
                    opcao3Controller.text.trim().isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Preencha todos os campos.')),
                  );

                  return;
                }

                final novoTrilema = Trilema(
                  titulo: tituloController.text.trim(),
                  criadoPeloUsuario: true,
                  opcoes: [
                    opcao1Controller.text.trim(),
                    opcao2Controller.text.trim(),
                    opcao3Controller.text.trim(),
                  ],
                );

                final indiceTema = TemaRepository.temas.indexWhere(
                  (tema) => tema.nome == temaSelecionado!.nome,
                );

                if (widget.trilemaParaEditar == null) {
                  TemaRepository.temas[indiceTema].trilemas.add(novoTrilema);
                } else {
                  widget.trilemaParaEditar!.titulo = tituloController.text
                      .trim();

                  widget.trilemaParaEditar!.opcoes = [
                    opcao1Controller.text.trim(),
                    opcao2Controller.text.trim(),
                    opcao3Controller.text.trim(),
                  ];
                }

                await TemaRepository.salvar();

                if (widget.trilemaParaEditar == null) {
                  await TrilemaFirebaseService.enviarTrilemaCriado(
                    tema: temaSelecionado!.nome,
                    titulo: tituloController.text.trim(),
                    opcoes: [
                      opcao1Controller.text.trim(),
                      opcao2Controller.text.trim(),
                      opcao3Controller.text.trim(),
                    ],
                  );
                }

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      widget.trilemaParaEditar == null
                          ? 'Trilema criado com sucesso!'
                          : 'Trilema atualizado com sucesso!',
                    ),
                  ),
                );

                Navigator.pop(context);
              },
              child: Text(
                widget.trilemaParaEditar == null ? 'Salvar' : 'Atualizar',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
