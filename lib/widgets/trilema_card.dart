import 'package:flutter/material.dart';
import 'package:trilema/screens/novo_trilema_page.dart';

import '../models/trilema.dart';

class TrilemaCard extends StatefulWidget {
  final Trilema trilema;

  final VoidCallback? onExcluir;

  const TrilemaCard({super.key, required this.trilema, this.onExcluir});

  @override
  State<TrilemaCard> createState() => _TrilemaCardState();
}

class _TrilemaCardState extends State<TrilemaCard> {
  late List<bool> ativos;
  final List<int> fila = [];

  @override
  void initState() {
    super.initState();

    ativos = List.generate(widget.trilema.opcoes.length, (_) => false);
  }

  void alterarSwitch(int index, bool valor) {
    setState(() {
      if (valor) {
        ativos[index] = true;

        fila.remove(index);
        fila.add(index);

        if (fila.length > 2) {
          final remover = fila.removeAt(0);
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
    final totalAtivos = ativos.where((e) => e).length;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    widget.trilema.titulo,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ),

                if (widget.trilema.criadoPeloUsuario)
                  //if (true)
                  PopupMenuButton<String>(
                    onSelected: (value) async {
                      if (value == 'excluir') {
                        widget.onExcluir?.call();
                      }

                      if (value == 'editar') {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => NovoTrilemaPage(
                              trilemaParaEditar: widget.trilema,
                            ),
                          ),
                        );

                        setState(() {});
                      }
                    },
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'editar',
                        child: Text('Editar'),
                      ),

                      const PopupMenuItem(
                        value: 'excluir',
                        child: Text('Excluir'),
                      ),
                    ],
                  ),
              ],
            ),

            const SizedBox(height: 8),

            for (int i = 0; i < widget.trilema.opcoes.length; i++)
              SwitchListTile(
                title: Text(widget.trilema.opcoes[i]),
                value: ativos[i],
                onChanged: (valor) {
                  alterarSwitch(i, valor);
                },
              ),
          ],
        ),
      ),
    );
  }
}
