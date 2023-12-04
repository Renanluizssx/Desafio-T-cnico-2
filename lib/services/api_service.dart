import 'dart:convert';
import 'package:http/http.dart' as http;
import '../book/book.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class ApiService {
  final String apiUrl;

  ApiService(this.apiUrl);

  Future<List<Book>> fetchBooks() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      List<Book> books = data.map((json) => Book.fromJson(json)).toList();
      return books;
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<void> downloadBook(
      String url, String title, BuildContext context) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final directory = await getExternalStorageDirectory();
      final filePath = '${directory!.path}/$title.epub';

      File file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      // O arquivo foi baixado e salvo no dispositivo
      print('Livro baixado e salvo em: $filePath');
    } else {
      throw Exception('Falha ao baixar o livro');
    }
  }
}
