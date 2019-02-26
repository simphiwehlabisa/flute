import 'dart:async';

import 'package:flute/cache/Cache.dart';
import 'package:flute/cache/MemCache.dart';
import 'package:flute/model/Product.dart';
import 'package:flute/repository/CachingRepository.dart';
import 'package:flutter/material.dart';

final ThemeData _kTheme = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.teal,
  accentColor: Colors.redAccent,
);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Walmart coding challenge',
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
      ),
      home: Flute(),
    );
  }
}

class Flute extends StatefulWidget {
  @override
  createState() => FluteState();
}

class FluteState extends State<Flute> {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  static final Cache _cache = MemCache<News>();

  static final _repo = CachingRepository(pageSize: 10, cache: _cache);

  void onProduct(News news) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Need to pull something to know at least how many products do we have
    _repo.getProduct(0).asStream().listen(onProduct);

    return Scaffold(
      appBar: AppBar(
        title: Text('caching'),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.favorite_border), onPressed: _pushSaved)
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();

        final index = i ~/ 2;
        return _buildProductRow(_repo.getProduct(index));
      },
    );
  }

  Widget _buildProductRow(Future<News> productFuture) {
    if (productFuture == null) {
      return Text("error loading item");
    } else {
      return new FutureBuilder<News>(
        future: productFuture,
        builder: (BuildContext context, AsyncSnapshot<News> snapshot) {
          if (snapshot.hasData) {
            return _buildProductCard(snapshot.data);
          } else {
            return Text("");
          }
        },
      );
    }
  }

  void showProductDetails(BuildContext context, News product) {
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          settings: const RouteSettings(name: '/flute/product'),
          builder: (BuildContext context) {
            return Theme(
              data: _kTheme.copyWith(platform: Theme.of(context).platform),
              child: _buildProductDetailsPage(product),
            );
          },
        ));
  }

  Widget _buildProductDetailsPage(News product) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Image.network(product.thumbnail),
              Flexible(
                child: Text(
                  product.content,
                  textAlign: TextAlign.right,
                  maxLines: 3,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                      fontSize: 24.0),
                ),
              ),
              Expanded(
                flex: 10,
                child: SingleChildScrollView(
                  child: RichText(
                    text: TextSpan(
                      text: product.content,
                      style: TextStyle(color: Colors.black87, fontSize: 14.0),
                    ),
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  Widget _buildProductCard(News product) {
    return GestureDetector(
      onTap: () {
        showProductDetails(context, product);
      },
      child: Row(children: [
        Container(
          height: 64.0,
          width: 64.0,
          margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Image.network(product.thumbnail),
        ),
        Expanded(
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Flexible(
              child: Text(
                product.title,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ]),
        ),
        new Container(
          margin: const EdgeInsets.only(left: 8.0),
          child: Text(
            product.content,
            textAlign: TextAlign.end,
          ),
        ),
      ]),
    );
  }

  var _saved = Set<News>();

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (product) {
              return ListTile(
                title: Text(
                  product.title,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile
              .divideTiles(
                context: context,
                tiles: tiles,
              )
              .toList();

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}
