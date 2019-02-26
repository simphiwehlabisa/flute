class Product {
  final String productId;
  final String productName;
  final String shortDescription;
  final String longDescription;
  final String price;
  final String productImage;
  final double reviewRating;
  final int reviewCount;
  final bool inStock;

  const Product({
    this.productId,
    this.productName,
    this.shortDescription,
    this.longDescription,
    this.price,
    this.productImage,
    this.reviewRating,
    this.reviewCount,
    this.inStock
  });

  Product.fromMap(Map<String, dynamic>  map) :
    productId = map['productId'],
    productName = map['productName'],
    shortDescription = map['shortDescription'],
    longDescription = map['longDescription'],
    price = map['price'],
    productImage = map['productImage'],
    reviewRating = map['reviewRating'],
    reviewCount = map['reviewCount'],
    inStock = map['inStock'];
}



class News{
  final String itemID;
  final String id;
  final String title;
  final String link;
  final String date;
  final String content;
  final String image;
  final String thumbnail;

  const News({
    this.itemID,
    this.id,
    this.title,
    this.link,
    this.date,
    this.content,
    this.image,
    this.thumbnail,
  });

  News.fromMap(Map<String, dynamic> json) :
    itemID = json['itemID'].toString(),
    id = json['id'].toString(),
    title = json['title'],
    link = json ['link'],
    date = json['date'],
    content = json['content'],
    image = json['image'],
    thumbnail = json['thumbnail']
  ;
  Map<String, dynamic> toJson() => {

  };
}