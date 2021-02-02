import 'package:customeappbar/models/model.dart';
import 'package:http/http.dart' as http;

Future<List<CategoryModel>> fetchCategories() async {
  const url = "https://test.t-i-s.jp/api/home";

  final response = await http.get(url);
  print("${response.body}");
  final categories = CategoriesFromJson(response.body);

  print(categories);
  return categories;
}
