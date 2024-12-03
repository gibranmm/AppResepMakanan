class Recipe {
  int? id;
  String name;
  String preparationTime;
  String ingredients;
  String instructions;

  Recipe({
    this.id,
    required this.name,
    required this.preparationTime,
    required this.ingredients,
    required this.instructions,
  });

  // Convert Resep ke Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'preparation_time': preparationTime,
      'ingredients': ingredients,
      'instructions': instructions,
    };
  }

  // Convert Map ke Resep
  factory Recipe.fromMap(Map<String, dynamic> map) {
    return Recipe(
      id: map['id'],
      name: map['name'],
      preparationTime: map['preparation_time'],
      ingredients: map['ingredients'],
      instructions: map['instructions'],
    );
  }
}
