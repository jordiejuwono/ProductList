class ProductTable {
  int id;
  String title;
  String description;
  int price;
  String brand;
  String category;
  String thumbnail;
  int total;

  ProductTable({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.total,
  });

  factory ProductTable.fromJson(Map<String, dynamic> json) => ProductTable(
      id: json["id"],
      title: json["title"],
      description: json["description"],
      price: json["price"],
      brand: json["brand"],
      category: json["category"],
      thumbnail: json["thumbnail"],
      total: json["total"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "price": price,
        "brand": brand,
        "category": category,
        "thumbnail": thumbnail,
        "total": total,
      };
}
