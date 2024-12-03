import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../database/db_helper.dart';
// import 'home_screen.dart';
import 'add_recipe_screen.dart';

class RecipeDetailScreen extends StatelessWidget {
  final Recipe recipe;

  RecipeDetailScreen({required this.recipe});

  final DBHelper _dbHelper = DBHelper();

  void _deleteRecipe(BuildContext context) async {
    // Tampilkan dialog konfirmasi
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hapus Resep'),
        content: Text('Apakah Anda yakin ingin menghapus resep ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false), // Tidak jadi hapus
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true), // Konfirmasi hapus
            child: Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await _dbHelper.deleteRecipe(recipe.id!); // Hapus dari database
      Navigator.pop(context); // Kembali ke tampilan sebelumnya
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.name),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddRecipeScreen(recipe: recipe),
                ),
              ).then((_) => Navigator.pop(context));
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteRecipe(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Waktu Persiapan: ${recipe.preparationTime}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Bahan-bahan:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(recipe.ingredients),
            SizedBox(height: 20),
            Text(
              'Langkah-langkah:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(recipe.instructions),
          ],
        ),
      ),
    );
  }
}
