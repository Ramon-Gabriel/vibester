import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile/models/event/event_model.dart';
import 'package:mobile/routes/app_routes.dart';
import 'package:mobile/theme/theme_extensions.dart';
import 'package:mobile/widgets/common/vibester_image.dart';
import 'package:mobile/widgets/motion/vibester_pressable.dart';

/// Card do carrossel "Essa semana".
///
/// É o card da antiga tela de destaques, trazido de volta: imagem em cima,
/// título centralizado embaixo, data com ícone de calendário, moldura em
/// `brasa` de canto bem arredondado. Diferente do [EventPosterCard], aqui o
/// texto fica **fora** da arte — é o que dá o ar de "cartão" em vez de
/// cartaz, e é justamente por isso que ele funciona num `PageView` onde só
/// um aparece por vez.
///
/// Duas dependências do original não existem mais no projeto e foram
/// trocadas pelo equivalente atual:
///
/// - `GoogleFonts.inter(...)` → `context.typography`, que já é Inter com a
///   escala do app e respeita o fator de acessibilidade do sistema;
/// - `CachedNetworkImage` + `AppProgressIndicator` → [VibesterImage], que
///   faz cache, placeholder e estado de erro num widget só.
class WeeklyEvents extends StatelessWidget {
  final EventModel evento;

  const WeeklyEvents({super.key, required this.evento});

  /// Altura da arte. Título curto ganha mais imagem; título longo cede
  /// espaço pro texto, que é o que impede o card de estourar a altura do
  /// carrossel.
  double get _imageHeight => evento.titulo.length < 40 ? 180 : 160;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final type = context.typography;

    return VibesterPressable(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.eventDetail,
        arguments: evento,
      ),
      borderRadius: BorderRadius.circular(30),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: colors.brasa, width: 1.3),
            borderRadius: BorderRadius.circular(30),
          ),
          child: ClipRRect(
            // 1px a menos que a moldura: sem isso a arte vaza por cima do
            // traço no arredondado.
            borderRadius: BorderRadius.circular(29),
            child: ColoredBox(
              color: colors.navy,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: _imageHeight,
                    width: double.infinity,
                    child: VibesterImage(
                      source: evento.imageUrl,
                      placeholderIcon: Icons.local_activity_outlined,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
                    child: Column(
                      children: [
                        Text(
                          evento.titulo,
                          textAlign: TextAlign.center,
                          // O original não limitava linhas, e título comprido
                          // estourava a altura do carrossel.
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: type.headlineSmall.copyWith(
                            color: colors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: colors.ambar,
                              size: 22,
                            ),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                DateFormat(
                                  'EEE dd MMM  HH:mm',
                                  'pt_BR',
                                ).format(evento.dataDoEvento).toUpperCase(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: type.monoSmall.copyWith(
                                  color: colors.textMuted,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}