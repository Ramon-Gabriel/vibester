import 'package:flutter/material.dart';
import 'package:mobile/models/place/place_model.dart';
import 'package:mobile/providers/place/place_list_provider.dart';
import 'package:mobile/screens/events/event_list_screen.dart';
import 'package:mobile/screens/highlights/property_highlights_screen.dart';
import 'package:mobile/screens/places/place_reviews_screen.dart';
import 'package:mobile/service/places/place_service.dart';
import 'package:mobile/theme/app_spacing.dart';
import 'package:mobile/theme/theme_extensions.dart';
import 'package:mobile/utils/event_time.dart';
import 'package:mobile/utils/hero_tags.dart';
import 'package:mobile/widgets/common/vibester_image.dart';
import 'package:mobile/widgets/common/vibester_skeleton.dart';
import 'package:mobile/widgets/common/vibester_state.dart';
import 'package:mobile/widgets/common/vibester_tag.dart';
import 'package:mobile/widgets/graffiti/grain.dart';
import 'package:mobile/widgets/indicators/movement_indicator.dart';
import 'package:mobile/widgets/motion/vibester_pressable.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// Detalhe do estabelecimento.
///
/// Duas coisas saíram da versão anterior por serem dado inventado, e não
/// escolha de layout:
///
/// * O banner era uma **URL fixa de banco de imagens** (uma foto genérica de
///   DJ) usada para todo estabelecimento do app. Agora usa `banner` e, na
///   falta dele, a foto de perfil; sem nenhuma das duas, a superfície com
///   grão do `VibesterImage`.
/// * A barra de estatísticas exibia **"12k seguidores"** literalmente
///   escrito no código, igual para todos. Foi substituída por números que a
///   API realmente devolve: avaliação, quantidade de avaliações e movimento.
///
/// O resto é composição: o movimento — a informação que só o Vibester tem —
/// sobe para o cartaz, junto do nome, em vez de ficar perdido numa linha do
/// meio da página.
class PlaceDetailScreen extends StatefulWidget {
  final String placeId;

  const PlaceDetailScreen({super.key, required this.placeId});

  @override
  State<PlaceDetailScreen> createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen>
    with SingleTickerProviderStateMixin {
  // Criado no initState, não com `late final` inicializado na declaração: nos
  // caminhos de carregamento e de erro o build nunca chega a tocar no
  // controller, então a inicialização preguiçosa só aconteceria no dispose —
  // e criar um Ticker a partir de um elemento já desativado dispara "Looking
  // up a deactivated widget's ancestor is unsafe". Na prática: abrir um lugar
  // sem rede e voltar quebrava a tela.
  late final TabController _tabController;
  final PlaceService _placeService = PlaceService();
  late Future<PlaceModel> _placeFuture = _placeService.getPlaceById(
    widget.placeId,
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _reload() {
    setState(() {
      _placeFuture = _placeService.getPlaceById(widget.placeId);
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _abrirNoMapa(PlaceModel place) async {
    final destino = place.latitude != null && place.longitude != null
        ? '${place.latitude},${place.longitude}'
        : Uri.encodeComponent('${place.nome} ${place.endereco}');

    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$destino',
    );

    final aberto = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!aberto && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Não foi possível abrir o mapa')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      backgroundColor: colors.noturno,
      body: FutureBuilder<PlaceModel>(
        future: _placeFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const _PlaceSkeleton();
          }

          if (snapshot.hasError) {
            return SafeArea(
              child: VibesterState.error(
                message:
                    'Não foi possível carregar esse lugar. Confere sua '
                    'conexão e tenta de novo.',
                onAction: _reload,
              ),
            );
          }

          return _buildContent(context, snapshot.data!);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, PlaceModel place) {
    final colors = context.colors;
    final provider = context.watch<PlaceListProvider>();
    final saved =
        provider.places
            .where((p) => p.nome == place.nome)
            .map((p) => p.isFavorite)
            .firstOrNull ??
        place.isFavorite;

    return NestedScrollView(
      headerSliverBuilder: (context, _) => [
        SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _PlaceHero(
                place: place,
                onShare: () => SharePlus.instance.share(
                  ShareParams(
                    text: [
                      place.nome,
                      if (place.endereco.isNotEmpty) place.endereco,
                      'Visto no Vibester',
                    ].join('\n'),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.screen,
                  AppSpacing.lg,
                  AppSpacing.screen,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (place.bio.isNotEmpty) ...[
                      Text(
                        place.bio,
                        style: context.typography.bodyLarge.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],

                    _PlaceNumbers(place: place),
                    const SizedBox(height: AppSpacing.lg),

                    Row(
                      children: [
                        Expanded(
                          child: _PlaceAction(
                            icon: saved
                                ? Icons.person_add_disabled_outlined
                                : Icons.person_add_alt_1_rounded,
                            label: saved ? 'SEGUINDO' : 'SEGUIR',
                            active: saved,
                            onTap: () => provider.toggleFavorite(place.nome),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: _PlaceAction(
                            icon: Icons.near_me_outlined,
                            label: 'COMO CHEGAR',
                            onTap: () => _abrirNoMapa(place),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
            ],
          ),
        ),

        SliverPersistentHeader(
          pinned: true,
          delegate: _StickyTabBarDelegate(
            color: colors.noturno,
            child: TabBar(
              controller: _tabController,
              unselectedLabelColor: colors.textDisabled,
              labelColor: colors.textPrimary,
              dividerColor: colors.hairline,
              indicatorColor: colors.ambar,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: AppStroke.marker,
              labelStyle: context.typography.monoMicro,
              unselectedLabelStyle: context.typography.monoMicro,
              tabs: const [
                Tab(text: 'ROLANDO'),
                Tab(text: 'EVENTOS'),
                Tab(text: 'O QUE FALAM'),
              ],
            ),
          ),
        ),
      ],
      body: TabBarView(
        controller: _tabController,
        children: [
          PropertyHighlightsScreen(placeId: place.id),
          const EventListScreen(),
          PlaceReviewsScreen(place: place),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------

class _PlaceHero extends StatelessWidget {
  final PlaceModel place;
  final VoidCallback onShare;

  const _PlaceHero({required this.place, required this.onShare});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final type = context.typography;
    final distance = formatDistance(place.distancia);

    final banner = place.bannerImage.isNotEmpty
        ? place.bannerImage
        : place.profileImage;

    return SizedBox(
      height: 340,
      child: Stack(
        fit: StackFit.expand,
        children: [
          VibesterImage(
            source: banner,
            placeholderIcon: Icons.storefront_outlined,
          ),
          const Grain(opacity: 0.07, density: 0.45),
          DecoratedBox(decoration: BoxDecoration(gradient: colors.photoScrim)),

          Positioned(
            top: MediaQuery.of(context).padding.top + AppSpacing.sm,
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            child: Row(
              children: [
                _HeroAction(
                  icon: Icons.arrow_back_rounded,
                  label: 'Voltar',
                  onTap: () => Navigator.maybePop(context),
                ),
                const Spacer(),
                _HeroAction(
                  icon: Icons.ios_share_rounded,
                  label: 'Compartilhar',
                  onTap: onShare,
                ),
              ],
            ),
          ),

          Positioned(
            left: AppSpacing.screen,
            right: AppSpacing.screen,
            bottom: AppSpacing.lg,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Foto de perfil como selo quadrado colado sobre o banner —
                // não um avatar circular flutuando meio pra dentro, meio pra
                // fora, que era o que exigia o `Positioned(bottom: -25)`.
                Hero(
                  tag: placeImageHeroTag(place),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppRadius.sm),
                      topRight: Radius.circular(AppRadius.sm),
                      bottomRight: Radius.circular(AppRadius.sm),
                    ),
                    child: SizedBox(
                      width: 64,
                      height: 64,
                      child: VibesterImage(
                        source: place.profileImage,
                        placeholderIcon: Icons.storefront_outlined,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Wrap(
                        spacing: AppSpacing.sm,
                        runSpacing: AppSpacing.xs,
                        children: [
                          if (place.categoria.isNotEmpty)
                            VibesterTag(place.categoria),
                          if (distance.isNotEmpty)
                            VibesterTag(distance, icon: Icons.near_me_outlined),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        place.nome,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: type.displayMedium.copyWith(color: Colors.white),
                      ),
                      if (place.nivelMovimento > 0) ...[
                        const SizedBox(height: AppSpacing.sm),
                        MovimentoIndicator(nivel: place.nivelMovimento),
                      ],
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

class _HeroAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _HeroAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: VibesterPressable(
        onTap: onTap,
        borderRadius: AppRadius.pillAll,
        child: Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: context.colors.scrim.withValues(alpha: 0.55),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
          ),
          child: Icon(icon, size: 20, color: Colors.white),
        ),
      ),
    );
  }
}

/// Números reais do estabelecimento, em DM Mono. Cada célula só aparece se a
/// API mandou o dado — uma linha de zeros diria menos que a ausência dela.
class _PlaceNumbers extends StatelessWidget {
  final PlaceModel place;

  const _PlaceNumbers({required this.place});

  @override
  Widget build(BuildContext context) {
    final cells = <(String, String)>[
      if (place.avaliacao > 0)
        (place.avaliacao.toStringAsFixed(1).replaceAll('.', ','), 'NOTA MÉDIA'),
      if (place.qtdAvaliacoes > 0) ('${place.qtdAvaliacoes}', 'AVALIAÇÕES'),
      if (place.nivelPrecoMedio.isNotEmpty)
        (place.nivelPrecoMedio.toUpperCase(), 'PREÇO'),
    ];

    if (cells.isEmpty) return const SizedBox.shrink();

    final colors = context.colors;

    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: colors.hairline),
          bottom: BorderSide(color: colors.hairline),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
      child: Row(
        children: [
          for (final (i, cell) in cells.indexed) ...[
            if (i > 0) Container(width: 1, height: 34, color: colors.hairline),
            Expanded(
              child: Column(
                children: [
                  Text(
                    cell.$1,
                    style: context.typography.monoDisplay.copyWith(
                      color: colors.textPrimary,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    cell.$2,
                    style: context.typography.monoMicro.copyWith(
                      color: colors.textDisabled,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PlaceAction extends StatelessWidget {
  final IconData? icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  const _PlaceAction({
    required this.icon,
    required this.label,
    required this.onTap,
    this.active = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final foreground = active ? colors.onAmbar : colors.textPrimary;

    return Semantics(
      button: true,
      selected: active,
      label: label,
      child: VibesterPressable(
        onTap: onTap,
        borderRadius: AppRadius.pillAll,
        child: Container(
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: active ? colors.ambar : Colors.transparent,
            borderRadius: AppRadius.pillAll,
            border: Border.all(
              color: active ? colors.ambar : colors.outline,
              width: AppStroke.hairline,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 17, color: foreground),
              const SizedBox(width: AppSpacing.sm),
              Text(
                label,
                style: context.typography.monoMicro.copyWith(color: foreground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PlaceSkeleton extends StatelessWidget {
  const _PlaceSkeleton();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VibesterSkeleton(height: 340, borderRadius: BorderRadius.zero),
        Padding(
          padding: EdgeInsets.all(AppSpacing.screen),
          child: VibesterSkeletonLines(lines: 3),
        ),
      ],
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;
  final Color color;

  const _StickyTabBarDelegate({required this.child, required this.color});

  @override
  double get minExtent => child.preferredSize.height;

  @override
  double get maxExtent => child.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlaps) =>
      ColoredBox(color: color, child: child);

  @override
  bool shouldRebuild(_StickyTabBarDelegate old) =>
      old.child != child || old.color != color;
}
