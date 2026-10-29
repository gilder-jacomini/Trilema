import 'package:flutter/material.dart';

class TrilemaBrand extends StatelessWidget {
  const TrilemaBrand({
    super.key,
    this.width = 260,
    this.showSlogan = true,
  });

  final double width;
  final bool showSlogan;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo-trilema.png',
      width: width,
      fit: BoxFit.contain,
      semanticLabel: showSlogan
          ? 'TRILEMA — Escolha dois. Abra mão de um.'
          : 'TRILEMA',
    );
  }
}
