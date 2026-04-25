class Interest {
  final String id;
  final String label;
  final String emoji;
  bool selected;

  Interest({
    required this.id,
    required this.label,
    required this.emoji,
    this.selected = false,
  });
}

final List<Interest> defaultInterests = [
  Interest(id: 'bars', label: 'Bares', emoji: '🍺'),
  Interest(id: 'restaurantes', label: 'Restaurantes', emoji: '🍽️'),
  Interest(id: 'cafes', label: 'Baladas', emoji: '🪩'),
  Interest(id: 'sushi', label: 'Games', emoji: '🎮'),
  Interest(id: 'churrasco', label: 'Parques', emoji: '🏃'),
  Interest(id: 'vegano', label: 'Carros', emoji: '🏎️'),
  Interest(id: 'sobremesas', label: 'Shows', emoji: '🎶'),
];
