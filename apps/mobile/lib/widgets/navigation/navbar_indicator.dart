import 'package:flutter/material.dart';
import 'package:mobile/theme/theme_extensions.dart';
import 'package:mobile/widgets/navigation/navbar_tokens.dart';

/// Destaque do item ativo: um halo luminoso que **viaja** entre as posições.
///
/// Não é uma barrinha nem um ponto que some de um slot e aparece no outro. O
/// halo percorre fisicamente a distância, e é isso que faz os quatro destinos
/// lerem como um sistema só em vez de quatro botões independentes — quando o
/// destaque atravessa a barra, o olho entende que existe *uma* seleção se
/// movendo.
///
/// É só a cápsula: uma superfície acesa em `ambar` que desliza por baixo do
/// ícone. Antes havia também um halo radial e um traço de marcador embaixo;
/// os dois saíram a pedido — o destaque agora é cor de fundo e nada mais, o
/// que também deixa a leitura mais calma numa barra que já tem vidro, grão e
/// um botão luminoso no meio.
class NavbarIndicator extends StatelessWidget {
  /// Posição contínua entre slots. Pode ultrapassar os limites durante o
  /// overshoot da mola — o desenho lida com isso naturalmente.
  final double position;

  /// Largura de cada slot de destino.
  final double slotWidth;

  /// Vão do botão central, que empurra os destinos depois dele.
  final double centerGap;

  /// Margem interna da fileira. O halo precisa começar de onde os itens
  /// começam: sem isso, a luz do primeiro e do último destino bate na curva
  /// da pill e é cortada pelo recorte, virando um retângulo de aresta viva em
  /// vez de uma luz difusa.
  final double leadingInset;

  /// Índice a partir do qual os destinos ficam depois do vão.
  final int middleIndex;

  /// Intensidade, de 0 a 1 — animada na entrada da navbar.
  final double intensity;

  const NavbarIndicator({
    super.key,
    required this.position,
    required this.slotWidth,
    required this.centerGap,
    required this.middleIndex,
    this.leadingInset = 0,
    this.intensity = 1,
  });

  @override
  Widget build(BuildContext context) {
    if (slotWidth <= 0 || intensity <= 0) return const SizedBox.shrink();

    return IgnorePointer(
      child: CustomPaint(
        size: Size(double.infinity, NavbarTokens.height),
        painter: _IndicatorPainter(
          position: position,
          slotWidth: slotWidth,
          centerGap: centerGap,
          leadingInset: leadingInset,
          middleIndex: middleIndex,
          intensity: intensity,
          accent: context.colors.ambar,
        ),
      ),
    );
  }
}

class _IndicatorPainter extends CustomPainter {
  final double position;
  final double slotWidth;
  final double centerGap;
  final double leadingInset;
  final int middleIndex;
  final double intensity;
  final Color accent;

  const _IndicatorPainter({
    required this.position,
    required this.slotWidth,
    required this.centerGap,
    required this.leadingInset,
    required this.middleIndex,
    required this.intensity,
    required this.accent,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (slotWidth <= 0) return;

    // Destinos depois do vão central estão deslocados pela largura dele. O
    // deslocamento acompanha a travessia em vez de saltar no meio dela, senão
    // o halo "teleportaria" ao cruzar o botão central.
    final crossing = (position - (middleIndex - 0.5)).clamp(0.0, 1.0);
    final shift = centerGap * crossing;

    final left = leadingInset + position * slotWidth + shift;
    final centerX = left + slotWidth / 2;
    // Sobe em relação ao centro: quem a cápsula precisa envolver é o ícone,
    // que fica acima do rótulo.
    final centerY = size.height / 2 - 7;

    final capsuleWidth = slotWidth * 0.66;
    const capsuleHeight = 42.0;
    final capsule = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: Offset(centerX, centerY),
        width: capsuleWidth,
        height: capsuleHeight,
      ),
      const Radius.circular(16),
    );

    canvas.drawRRect(
      capsule,
      Paint()..color = accent.withValues(alpha: 0.16 * intensity),
    );
  }

  @override
  bool shouldRepaint(_IndicatorPainter old) =>
      old.position != position ||
      old.slotWidth != slotWidth ||
      old.centerGap != centerGap ||
      old.leadingInset != leadingInset ||
      old.intensity != intensity ||
      old.accent != accent;
}
