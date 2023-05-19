import 'package:product_list/data/model/product_list_dto.dart';
import 'package:product_list/domain/entities/product_list.dart';

class DataMapper {
  ProductList mapProductDtoToProduct(ProductListDto product) {
    return ProductList(
      products: mapProductListDtoToProduct(product.products),
      total: product.total,
      skip: product.skip,
      limit: product.limit,
    );
  }

  List<Product> mapProductListDtoToProduct(List<ProductDto> listProduct) {
    return listProduct.map((response) {
      return Product(
        id: response.id,
        title: response.title,
        description: response.description,
        price: response.price,
        discountPercentage: response.discountPercentage,
        rating: response.rating,
        stock: response.stock,
        brand: response.brand,
        category: response.category,
        thumbnail: response.thumbnail,
      );
    }).toList();
  }
}
