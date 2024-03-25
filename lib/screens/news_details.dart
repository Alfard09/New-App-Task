import 'package:flutter/material.dart';
import 'package:newsapp2/models/model.dart';

class NewsDetailsScreen extends StatelessWidget {
  final Article article;

  NewsDetailsScreen({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(194, 33, 149, 243),
        title:
            Text('News Details', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.urlToImage.isNotEmpty)
              Image.network(
                article.urlToImage,
                width: double.infinity,
                height: 200.0,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 12.0),
            Text(
              article.title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'By ${article.author}',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 8.0),
            Text(
              article.content,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
