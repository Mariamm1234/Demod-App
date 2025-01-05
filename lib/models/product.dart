class ProductDto{
     final  int id;
final String name;
final String description;
final double price;
final String message;

ProductDto({
  required this.description,
  required this.id,
  required this.message,
  required this.name,
  required this.price
});
 factory ProductDto.fromJson(Map<String, dynamic> json) {
    return ProductDto(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
        message: json['message'],
    );}
}