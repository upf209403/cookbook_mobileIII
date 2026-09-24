class Meal {
  final String id;
  final String name;
  final String imageUrl;
  final String category;
  final String area;
  final bool custom;
  final bool favorite;

  Meal({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.category,
    required this.area,
    this.custom = false,
    this.favorite = false
  });
}
