import 'package:latihan_responsi/categories_model.dart';
import 'package:latihan_responsi/load_data_source.dart';
import 'package:flutter/material.dart';
import 'package:latihan_responsi/page_list_meals.dart';

class PageListCategories extends StatefulWidget {
  const PageListCategories({Key? key}) : super(key: key);
  @override
  State<PageListCategories> createState() => _PageListCategoriesState();
}

class _PageListCategoriesState extends State<PageListCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Meal Categories",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xFF994422),
        centerTitle: true,
      ),
      body: _buildListCategoryBody(),
    );
  }

  Widget _buildListCategoryBody() {
    return Container(
      child: FutureBuilder(
        future: ApiDataSource.instance.loadCategories(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.hasError) {
            // Jika data ada error maka akan ditampilkan hasil error
            return _buildErrorSection();
          }
          if (snapshot.hasData) {
            // Jika data ada dan berhasil maka akan ditampilkan hasil datanya
            CategoriesModel categoriesModel = CategoriesModel.fromJson(snapshot.data);
            return _buildSuccessSection(categoriesModel);
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

  Widget _buildSuccessSection(CategoriesModel data) {
    return ListView.builder(
      itemCount: data.categories!.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildItemCategory(data.categories![index]);
      },
    );
  }

  Widget _buildItemCategory(Categories category) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PageListMeals(
                      category: category.strCategory!,
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
                child: Image.network(category.strCategoryThumb!),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(category.strCategory!, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10), 
                    child: Text(
                      category.strCategoryDescription!,
                      textAlign: TextAlign.justify,
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
