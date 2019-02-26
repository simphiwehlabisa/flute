import 'package:flute/model/Product.dart';

class Products {
  final List<Product> products;
  final int totalProducts;
  final int pageNumber;
  final int pageSize;

  Products({this.products, this.totalProducts, this.pageNumber, this.pageSize});

  Products.fromMap(Map<String, dynamic> map)
      : products = new List<Product>.from(map['products'].map((product) => new Product.fromMap(product))),
        totalProducts = map['totalProducts'],
        pageNumber = map['pageNumber'],
        pageSize = map['pageSize'];
}
class NewsCategory{
  final String name;
  final String id;
  final int totalNews;
  final int pageNumber;
  final int pagSize;

  final List<News> news;

  const NewsCategory({
    this.name,
    this.pageNumber,
    this.id,
    this.pagSize,
    this.totalNews,
    this.news
  });

  NewsCategory.fromMap(Map<String, dynamic> map) :
  name = map['name'],
  pageNumber = 1,
  pagSize = 1,
  totalNews = 4,
  id = map['id'],
  news = new List<News>.from(map['news'].map((i) => new News.fromMap(i)));
}