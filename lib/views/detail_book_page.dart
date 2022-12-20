import 'package:book_app/controllers/book_controller.dart';
import 'package:book_app/views/image_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailBookPage extends StatefulWidget {
  const DetailBookPage({super.key, required this.isbn});
  final String isbn;

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  BookController? controller;

  @override
  void initState() {
    // ignore: todo
    //TODO: implement initState
    super.initState();
    controller = Provider.of<BookController>(context, listen: false);
    controller!.fatchDetailBookApi(widget.isbn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: Consumer<BookController>(builder: (context, controller, child) {
        return controller.detailBook == null
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => ImageViewScreen(
                                    imageUrl: controller.detailBook!.image!)),
                              ),
                            );
                          }),
                          child: Image.network(
                            controller.detailBook!.image!,
                            height: 150,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.detailBook!.title!,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  controller.detailBook!.authors!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: List.generate(
                                      5,
                                      (index) => Icon(
                                            Icons.star,
                                            color: index >
                                                    int.parse(controller
                                                        .detailBook!.rating!)
                                                ? Colors.yellow
                                                : Colors.grey,
                                          )),
                                ),
                                Text(
                                  controller.detailBook!.subtitle!,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  controller.detailBook!.price!,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              //fixedSize: Size(double.infinity,50),
                              ),
                          onPressed: () async {
                            // ignore: prefer_typing_uninitialized_variables
                            var controller;
                            Uri uri = Uri.parse(controller.detailBook!.url!);
                            try {
                              (await canLaunchUrl(uri))
                                  ? launchUrl(uri)
                                  // ignore: avoid_print
                                  : print("tidak berhasil navigasi");
                            } catch (e) {
                              (e);
                            }
                          },
                          child: const Text("BUY")),
                    ),
                    const SizedBox(height: 20),
                    Text(controller.detailBook!.desc!),
                    const SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text("Year:${controller.detailBook!.year!}"),
                        Text("ISBN${controller.detailBook!.isbn13!}"),
                        Text("${controller.detailBook!.pages!}page"),
                        Text("Publisher:${controller.detailBook!.publisher!}"),
                        Text("Language:${controller.detailBook!.language!}"),
                        //Text(detailBook!.rating!),
                      ],
                    ),
                    const Divider(),
                    controller.similiarBooks == null
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            height: 180,
                            child: ListView.builder(
                              //shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  controller.similiarBooks!.books!.length,
                              //physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                final current =
                                    controller.similiarBooks!.books![index];
                                return SizedBox(
                                  width: 100,
                                  child: Column(
                                    children: [
                                      Image.network(
                                        current.image!,
                                        height: 80,
                                      ),
                                      Text(
                                        current.title!,
                                        maxLines: 3,
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                  ],
                ),
              );
      }),
    );
  }

  canLaunchUrl(Uri uri) {}

  launchUrl(Uri uri) {}
}
