
import 'package:book_app/controllers/book_controller.dart';
import 'package:book_app/views/detail_book_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookPageList extends StatefulWidget {
  const BookPageList({super.key});

  @override
  State<BookPageList> createState() => _BookListAppState();
}

class _BookListAppState extends State<BookPageList> {
  BookController? bookController;

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    bookController = Provider.of<BookController>(context, listen: false);
    bookController!.fatchBookApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Catalogue"),
      ),
      body: Consumer<BookController>(
        child: const Center(child: CircularProgressIndicator()),
        builder: (context, controller, child) => Container(
            child: bookController == null
                ? child
                : ListView.builder(
                    itemCount: bookController!.bookList!.books!.length,
                    itemBuilder: ((context, index) {
                      final currentBook =
                          bookController!.bookList!.books![index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailBookPage(
                                isbn: currentBook.isbn13!,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Image.network(
                              currentBook.image!,
                              height: 100,
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(currentBook.title!),
                                    Text(currentBook.subtitle!),
                                    Align(
                                        alignment: Alignment.topRight,
                                        child: Text(currentBook.price!)),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }))),
      ),
    );
  }
}
