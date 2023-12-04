import 'dart:convert';
import 'package:http/http.dart' as http;
import '../book/book.dart';

class ApiService {
  final String apiUrl;

  ApiService(this.apiUrl);

  Future<List<Book>> fetchBooks() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        List<Book> books = data.map((json) => Book.fromJson(json)).toList();
        return books;
      } else {
        throw Exception('API retornou status ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro na solicitação HTTP: $e');
    }
  }
}
