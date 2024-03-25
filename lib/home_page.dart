import 'package:flutter/material.dart';
import 'package:newsapp2/models/model.dart';
import 'package:newsapp2/screens/news_details.dart';
import 'package:newsapp2/services/service.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late Future<List<Article>> _futureArticles;

  @override
  void initState() {
    super.initState();
    _futureArticles = fetchArticles('5e7954da5a2446538c722b594e8b5df7');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(224, 33, 149, 243),
        title: Center(
          child: Text(
            'News Articles',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: FutureBuilder<List<Article>>(
        future: _futureArticles,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final article = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NewsDetailsScreen(article: article),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4.0,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (article.urlToImage.isNotEmpty)
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  article.urlToImage,
                                  width: double.infinity,
                                  height: 200.0,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    // Fallback to default image
                                    return Image.asset(
                                      'assets/img/one.png',
                                      width: double.infinity,
                                      height: 200.0,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                ),
                              ),
                            SizedBox(height: 12.0),
                            Text(
                              article.title,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              article.description,
                              style: TextStyle(fontSize: 16.0),
                            ),
                            SizedBox(height: 8.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'By ${article.author}',
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                                Text(
                                  formatDate(article.publishedAt),
                                  style: TextStyle(fontStyle: FontStyle.italic),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  String formatDate(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }
}
