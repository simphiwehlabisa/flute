import 'dart:async';
import 'package:flute/model/Product.dart';

abstract class Repository {
  Future<News> getProduct(int index);
 // Future<News> getNews(int index);
}