class RecipeModel {
  late String recipeId;
  late String title;
  late String description;
  late String ingredients;
  late int dt;

  RecipeModel({
    required this.recipeId,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.dt,
  });

  static RecipeModel fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      recipeId: map['recipeId'],
      title: map['title'],
      description: map['description'],
      ingredients: map['ingredients'],
      dt: map['dt'],
    );
  }
}
