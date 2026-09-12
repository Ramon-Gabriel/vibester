import 'package:flutter/material.dart';
import 'package:mobile/theme/app_motion.dart';
import 'package:mobile/theme/app_spacing.dart';
import 'package:mobile/theme/theme_extensions.dart';

/// Nota em estrelas. Meia estrela quando a média cai no meio.
///
/// Extraído para um widget próprio porque `ReviewCard` e [ReviewIndicator]
/// tinham cada um a sua cópia do mesmo `_buildStars`.
class StarRating extends StatelessWidget {
  final double rating;
  final double size;

  const StarRating({super.key, required this.rating, this.size = 15});

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Nota ${rating.toStringAsFixed(1)} de 5',
      excludeSemantics: true,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 1; i <= 5; i++)
            Padding(
              padding: const EdgeInsets.only(right: 2),
              child: Icon(
                rating >= i
                    ? Icons.star_rounded
                    : rating >= i - 0.5
                    ? Icons.star_half_rounded
                    : Icons.star_outline_rounded,
                size: size,
                color: rating >= i - 0.5
                    ? context.colors.ambar
                    : context.colors.textDisabled,
              ),
            ),
        ],
      ),
    );
  }
}

/// Resumo das avaliações de um estabelecimento: nota média grande à esquerda,
/// distribuição por estrela à direita.
///
/// Saiu do `Card` com fundo `navy` e virou um bloco sobre o próprio fundo,
/// como o restante das telas de detalhe. A nota usa DM Mono — é um número de
/// sistema — e as barras de distribuição crescem com animação curta ao
/// aparecer, dando a leitura de "quanto de cada" antes mesmo de ler os
/// números.
class ReviewIndicator extends StatelessWidget {
  final double avaliacao;
  final int totalReviews;
  final List<double> distribuicao;

  const ReviewIndicator({
    super.key,
    required this.avaliacao,
    this.totalReviews = 0,
    this.distribuicao = const [],
  });

  /// A API pode devolver a distribuição vazia ou incompleta.
  List<double> get _distribuicaoSegura =>
      distribuicao.length == 5 ? distribuicao : const [0, 0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final type = context.typography;
    final dist = _distribuicaoSegura;
    final total = dist.fold<double>(0, (a, b) => a + b);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: colors.hairline)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                avaliacao.toStringAsFixed(1).replaceAll('.', ','),
                style: type.monoDisplay.copyWith(
                  color: colors.textPrimary,
                  fontSize: 44,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              StarRating(rating: avaliacao),
              const SizedBox(height: AppSpacing.xs + 2),
              Text(
                totalReviews == 1 ? '1 AVALIAÇÃO' : '$totalReviews AVALIAÇÕES',
                style: type.monoMicro.copyWith(color: colors.textDisabled),
              ),
            ],
          ),

          const SizedBox(width: AppSpacing.xl),

          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // De 5 para 1, como se lê uma distribuição de notas.
                for (var estrela = 5; estrela >= 1; estrela--)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 10,
                          child: Text(
                            '$estrela',
                            style: type.monoMicro.copyWith(
                              color: colors.textDisabled,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: _DistributionBar(
                            fraction: total <= 0
                                ? 0
                                : dist[estrela - 1] / total,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DistributionBar extends StatelessWidget {
  final double fraction;

  const _DistributionBar({required this.fraction});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: Stack(
        children: [
          Container(height: 6, color: colors.grey.withValues(alpha: 0.16)),
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: fraction.clamp(0.0, 1.0)),
            duration: context.adaptiveMotion(AppMotion.slow),
            curve: AppMotion.enter,
            builder: (context, value, _) => FractionallySizedBox(
              widthFactor: value,
              child: Container(height: 6, color: colors.ambar),
            ),
          ),
        ],
      ),
    );
  }
}
