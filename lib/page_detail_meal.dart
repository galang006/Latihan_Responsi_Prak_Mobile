import 'package:latihan_responsi/detail_meal_model.dart';
import 'package:latihan_responsi/load_data_source.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PageDetailMeal extends StatefulWidget {
  final String idMeal;
  const PageDetailMeal({Key? key, required this.idMeal}) : super(key: key);
  @override
  State<PageDetailMeal> createState() => _PageDetailMealState();
}

class _PageDetailMealState extends State<PageDetailMeal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Meal Detail",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Color(0xFFF7EFF1),
        surfaceTintColor: Color(0xFFF7EFF1),
        centerTitle: true,
      ),
      body: _buildListMealsBody(),
    );
  }

  Widget _buildListMealsBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadDetailMeal(widget.idMeal),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            DetailMealModel detailMealModel =
                DetailMealModel.fromJson(snapshot.data);
            return _buildSuccessSection(detailMealModel);
          }
          return _buildLoadingSection();
        },
      ),
    );
  }

  Widget _buildErrorSection() {
    return Text("Error");
  }

  Widget _buildLoadingSection() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildSuccessSection(DetailMealModel data) {
    DetailMeals meal = data.meals![0];
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  width: 200,
                  child: Image.network(meal.strMealThumb!),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                  child: Column(
                children: [
                  Text(meal.strMeal!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center,)
                ],
              )),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Category: " + meal.strCategory!),
                  SizedBox(
                    width: 50,
                  ),
                  Text("Area: " + meal.strArea!),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              IngredientsSection(
                ingredients: [
                  if (meal.strIngredient1 != null) meal.strIngredient1!,
                  if (meal.strIngredient2 != null) meal.strIngredient2!,
                  if (meal.strIngredient3 != null) meal.strIngredient3!,
                  if (meal.strIngredient4 != null) meal.strIngredient4!,
                  if (meal.strIngredient5 != null) meal.strIngredient5!,
                  if (meal.strIngredient6 != null) meal.strIngredient6!,
                  if (meal.strIngredient7 != null) meal.strIngredient7!,
                  if (meal.strIngredient8 != null) meal.strIngredient8!,
                  if (meal.strIngredient9 != null) meal.strIngredient9!,
                  if (meal.strIngredient10 != null) meal.strIngredient10!,
                  if (meal.strIngredient11 != null) meal.strIngredient11!,
                  if (meal.strIngredient12 != null) meal.strIngredient12!,
                  if (meal.strIngredient13 != null) meal.strIngredient13!,
                  if (meal.strIngredient14 != null) meal.strIngredient14!,
                  if (meal.strIngredient15 != null) meal.strIngredient15!,
                  if (meal.strIngredient16 != null) meal.strIngredient16!,
                  if (meal.strIngredient17 != null) meal.strIngredient17!,
                  if (meal.strIngredient18 != null) meal.strIngredient18!,
                  if (meal.strIngredient19 != null) meal.strIngredient19!,
                  if (meal.strIngredient20 != null) meal.strIngredient20!,
                ],
              ),
              SizedBox(
                height: 10,
              ),
              // Instructions
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10), // Tambahkan jarak horizontal di sini
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Instructions" ,style: TextStyle(fontWeight: FontWeight.bold),),
                      SizedBox(
                        height: 5,
                      ),
                      Text(meal.strInstructions!, textAlign: TextAlign.justify,),
                    ],
                ),
              ),

              SizedBox(
                height: 10,
              ),
              // Watch Tutorial button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (meal.strYoutube != "") {
                          launchURL(meal.strYoutube!);
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text("Link YouTube Tidak Tersedia"),
                                content: Text("Maaf, link YouTube tidak tersedia untuk saat ini."),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("OK"),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFF7EFF1),
                        foregroundColor: Color(0xFFF7EFF1)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.play_arrow, color: Color(0xFF994422)),
                          Text('Watch Tutorial', style: TextStyle(color: Color(0xFF994422)),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class IngredientsSection extends StatelessWidget {
  final List<String> ingredients;

  IngredientsSection({required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Ingredients:', style: TextStyle(fontWeight: FontWeight.bold),),
          SizedBox(
            height: 5,
          ),
          for (var ingredient in ingredients)
            if (ingredient != "") Text('• $ingredient'),
        ],
      ),
    );
  }
}

Future<void> launchURL(String url) async {
  final Uri _url = Uri.parse(url);
  if (!await launchUrl(_url)) {
    throw "Couldn't launch url";
  }
}
