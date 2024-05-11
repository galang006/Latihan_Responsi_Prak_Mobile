import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  // Future<Map<String, dynamic>> loadUsers() {
  //   return BaseNetwork.get("users");
  // }
  //
  // Future<Map<String, dynamic>> loadDetailUser(int idDiterima){
  //   String id = idDiterima.toString();
  //   return BaseNetwork.get("users/$id");
  // }

  Future<Map<String, dynamic>> loadCategories() {
    return BaseNetwork.get("categories.php");
  }

  Future<Map<String, dynamic>> loadMeals(String category){
    return BaseNetwork.get("filter.php?c=$category");
  }

  Future<Map<String, dynamic>> loadDetailMeal(String idMeal){
    return BaseNetwork.get("lookup.php?i=$idMeal");
  }
}