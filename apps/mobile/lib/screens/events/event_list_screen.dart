import 'package:flutter/material.dart';
import 'package:mobile/models/event/event_model.dart';
import 'package:mobile/providers/events/events_list_provider.dart';
import 'package:mobile/theme/app_spacing.dart';
import 'package:mobile/theme/theme_extensions.dart';
import 'package:mobile/utils/event_time.dart';
import 'package:mobile/widgets/cards/event/event_poster_card.dart';
import 'package:mobile/widgets/common/screen_header.dart';
import 'package:mobile/widgets/common/vibester_skeleton.dart';
import 'package:mobile/widgets/common/vibester_state.dart';
import 'package:mobile/widgets/motion/staggered_entrance.dart';
import 'package:provider/provider.dart';

/// Agenda completa de eventos.
///
/// Serve em dois contextos — como tela cheia (rota `/event-list`, vinda do
/// "ver tudo" das seções da Home) e como aba dentro do detalhe do
/// estabelecimento —, por isso o cabeçalho é opcional: dentro de uma aba,
/// um título de tela repetiria o que a aba já disse.
///
/// A lista é agrupada por dia, com a data como marcador em DM Mono: numa
/// agenda, o que o usuário procura primeiro é o dia, não o nome do evento.
class EventListScreen extends StatefulWidget {
  final bool showHeader;

  const EventListScreen({super.key, this.showHeader = false});

  @override
  State<EventListScreen> createState() => _EventListScreenState();
}

class _EventListScreenState extends State<EventListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EventsListProvider>().fetchEvents();
    });
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final provider = context.watch<EventsListProvider>();

    final events = provider.events.where((e) => e.isUpcoming).toList()
      ..sort((a, b) => a.dataDoEvento.compareTo(b.dataDoEvento));

    final body = RefreshIndicator(
      color: colors.ambar,
      backgroundColor: colors.surface,
      onRefresh: () =>
          context.read<EventsListProvider>().fetchEvents(force: true),
      child: _buildList(context, provider, events),
    );

    return Scaffold(
      backgroundColor: colors.noturno,
      body: widget.showHeader
          ? SafeArea(
              bottom: false,
              child: Column(
                children: [
                  const ScreenHeader(
                    title: 'A agenda',
                    eyebrow: 'TUDO QUE VEM POR AÍ',
                  ),
                  Expanded(child: body),
                ],
              ),
            )
          : body,
    );
  }

  Widget _buildList(
    BuildContext context,
    EventsListProvider provider,
    List<EventModel> events,
  ) {
    if (provider.isLoading && provider.events.isEmpty) {
      return ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.screen),
        itemCount: 5,
        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.lg),
        itemBuilder: (_, _) => const VibesterSkeleton(height: 76),
      );
    }

    if (provider.error != null && events.isEmpty) {
      return ListView(
        children: [
          VibesterState.error(
            message: provider.error!,
            onAction: () =>
                context.read<EventsListProvider>().fetchEvents(force: true),
          ),
        ],
      );
    }

    if (events.isEmpty) {
      return ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: const [
          VibesterState(
            headline: 'Agenda vazia',
            message:
                'Nenhum evento marcado por enquanto. Puxa pra atualizar em '
                'alguns minutos.',
            icon: Icons.event_busy_outlined,
          ),
        ],
      );
    }

    // Agrupa por dia mantendo a ordem cronológica.
    final grouped = <String, List<EventModel>>{};
    for (final event in events) {
      grouped.putIfAbsent(event.dayLabel, () => []).add(event);
    }

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screen,
        AppSpacing.lg,
        AppSpacing.screen,
        AppSpacing.dockGap,
      ),
      children: [
        for (final entry in grouped.entries) ...[
          Padding(
            padding: const EdgeInsets.only(
              top: AppSpacing.lg,
              bottom: AppSpacing.sm,
            ),
            child: Text(
              entry.key,
              style: context.typography.monoEyebrow.copyWith(
                color: context.colors.ambar,
              ),
            ),
          ),
          for (final (i, event) in entry.value.indexed)
            StaggeredEntrance(
              index: i,
              child: EventPosterCard(
                event: event,
                variant: EventCardVariant.wide,
                hero: false,
              ),
            ),
        ],
      ],
    );
  }
}
