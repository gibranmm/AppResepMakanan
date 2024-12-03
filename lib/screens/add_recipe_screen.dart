import 'package:flutter/material.dart';
import '../database/db_helper.dart';
import '../models/recipe.dart';

class AddRecipeScreen extends StatefulWidget {
  final Recipe? recipe;
  AddRecipeScreen({this.recipe});

  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _timeController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _instructionsController = TextEditingController();

  final DBHelper _dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
    if (widget.recipe != null) {
      _nameController.text = widget.recipe!.name;
      _timeController.text = widget.recipe!.preparationTime;
      _ingredientsController.text = widget.recipe!.ingredients;
      _instructionsController.text = widget.recipe!.instructions;
    }
  }

  void _saveRecipe() async {
    if (_formKey.currentState!.validate()) {
      final recipe = Recipe(
        id: widget.recipe?.id,
        name: _nameController.text,
        preparationTime: _timeController.text,
        ingredients: _ingredientsController.text,
        instructions: _instructionsController.text,
      );

      if (widget.recipe == null) {
        await _dbHelper.insertRecipe(recipe);
      } else {
        await _dbHelper.updateRecipe(recipe);
      }

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recipe == null ? 'Tambah Resep' : 'Edit Resep'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nama Resep',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Nama tidak boleh kosong' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _timeController,
                  decoration: InputDecoration(
                    labelText: 'Waktu Persiapan',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Waktu tidak boleh kosong' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _ingredientsController,
                  decoration: InputDecoration(
                    labelText: 'Bahan-bahan',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                  validator: (value) => value!.isEmpty ? 'Bahan tidak boleh kosong' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _instructionsController,
                  decoration: InputDecoration(
                    labelText: 'Langkah-langkah',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 4,
                  validator: (value) => value!.isEmpty ? 'Langkah tidak boleh kosong' : null,
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: _saveRecipe,
                  icon: Icon(Icons.save),
                  label: Text('Simpan'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
