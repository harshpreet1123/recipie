import "package:dio/dio.dart";

class MealDBApi {
  final Dio _dio =
      Dio(BaseOptions(baseUrl: 'https://www.themealdb.com/api/json/v1/1/'));

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    try {
      final response = await _dio.get('categories.php');
      return List<Map<String, dynamic>>.from(response.data['categories']);
    } catch (e) {
      print('Error $e');
      return [];
    }
  }

  Future<List<Map<String,dynamic>>> fetchRecipieList(String category) async{
    try{
      final response = await _dio.get('filter.php?c=$category');
      return List<Map<String,dynamic>>.from(response.data['meals']);
    }catch(e){
      print("Error while getting Recipie List: $e");
      return [];
    }
  }
}
