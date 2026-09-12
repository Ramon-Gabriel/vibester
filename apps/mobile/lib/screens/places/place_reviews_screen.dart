import 'package:flutter/material.dart';
import 'package:mobile/models/place/place_model.dart';
import 'package:mobile/theme/app_spacing.dart';
import 'package:mobile/theme/theme_extensions.dart';
import 'package:mobile/widgets/common/vibester_state.dart';
import 'package:mobile/widgets/indicators/review_indicator.dart';

/// O que falam do estabelecimento.
///
/// **Atenção ao que foi removido:** esta tela exibia seis avaliações escritas
/// diretamente no código — nomes de pessoas ("Fernanda Portela", "Rafael
/// Mendonça"…), notas e comentários inventados — iguais para todo
/// estabelecimento do app, acompanhadas de três botões de filtro que não
/// filtravam nada. Prova social fabricada é exatamente o que o briefing
/// proíbe, e num produto de descoberta ela também é o tipo de coisa que
/// destrói a confiança do usuário no dia em que ele percebe.
///
/// O que ficou é o que a API realmente entrega: a nota média, a quantidade de
/// avaliações e a distribuição por estrela (`averageRating`, `reviewCount`,
/// `ratingDistribution` em `PlaceModel`). A lista de comentários individuais
/// volta quando existir endpoint que a forneça.
class PlaceReviewsScreen extends StatelessWidget {
  final PlaceModel place;

  const PlaceReviewsScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    final temAvaliacoes = place.qtdAvaliacoes > 0 || place.avaliacao > 0;

    return Scaffold(
      backgroundColor: context.colors.noturno,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          AppSpacing.lg,
          AppSpacing.screen,
          AppSpacing.dockGap,
        ),
        children: [
          if (temAvaliacoes)
            ReviewIndicator(
              avaliacao: place.avaliacao,
              distribuicao: place.distribuicao,
              totalReviews: place.qtdAvaliacoes,
            ),

          const SizedBox(height: AppSpacing.xl),

          VibesterState(
            headline: temAvaliacoes ? 'Sem comentários' : 'Ninguém falou nada',
            message: temAvaliacoes
                ? 'A nota acima é a média real de quem já avaliou. Os '
                      'comentários individuais aparecem aqui em breve.'
                : 'Esse lugar ainda não recebeu avaliações. Vai lá e conta '
                      'como foi.',
            icon: Icons.rate_review_outlined,
          ),
        ],
      ),
    );
  }
}
