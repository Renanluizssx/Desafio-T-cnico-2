import 'package:flutter/material.dart';
import 'services/api_service.dart' as api;
import 'book/book.dart' as mybook;

class BookListScreen extends StatefulWidget {
  @override
  _BookListScreenState createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final api.ApiService apiService =
      api.ApiService("https://escribo.com/books.json");
  late Future<List<mybook.Book>> books;

  @override
  void initState() {
    super.initState();
    books = apiService.fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estante Virtual'),
      ),
      body: FutureBuilder<List<mybook.Book>>(
        future: books,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erro ao carregar os livros: ${snapshot.error}');
          } else {
            List<mybook.Book> bookList = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: bookList.length,
              itemBuilder: (context, index) {
                return _buildBookTile(bookList[index]);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildBookTile(mybook.Book book) {
    return Card(
      child: Column(
        children: [
          Image.network(
            book.coverUrl,
            height: 150.0,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              book.title,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BookListScreen(),
    );
  }
}
