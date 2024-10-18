part of "models.dart";

/// Structure
class Category{
  const Category({
    required this.id,
    required this.title,
    this.color = Colors.orange
});
  final String id;
  final String title;
  final Color color;
}