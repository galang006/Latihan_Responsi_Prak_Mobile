import 'package:latihan_responsi/load_data_source.dart';
import 'package:flutter/material.dart';
import 'package:latihan_responsi/meals_model.dart';
import 'package:latihan_responsi/page_detail_meal.dart';

class PageListMeals extends StatefulWidget {
  final String category;
  const PageListMeals({Key? key, required this.category}) : super(key: key);
  @override
  State<PageListMeals> createState() => _PageListMealsState ();
}

class _PageListMealsState extends State<PageListMeals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category + " Meals",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF994422),
        centerTitle: true,
      ),
      body: _buildListMealsBody(),
    );
  }

  Widget _buildListMealsBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadMeals(widget.category),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            MealsModel mealsModel = MealsModel.fromJson(snapshot.data);
            return _buildSuccessSection(mealsModel);
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

  Widget _buildSuccessSection(MealsModel data) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: data.meals!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemMeals(data.meals![index]);
      },
    );
  }

  Widget _buildItemMeals(Meals meals) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PageDetailMeal(
                  idMeal: meals.idMeal!,
                )));
      },
      child: Card(
          color: Color(0xFFF7EFF1),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 200,
                  child: Image.network(meals.strMealThumb!),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10), // Tambahkan jarak horizontal di sini
                      child: Text(
                          meals.strMeal!,
                          textAlign: TextAlign.center, overflow: TextOverflow.ellipsis
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )

      ),
    );
  }
}
