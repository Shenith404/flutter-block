import 'package:flutter/material.dart';
import 'package:flutterblock/features/home/models/home_product_data.dart';

class ProductTile extends StatefulWidget {
  final ProductDataModel productDataModel;
  const ProductTile({super.key, required this.productDataModel});

  @override
  State<ProductTile> createState() => _ProductTileState();
}

class _ProductTileState extends State<ProductTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(15),
      decoration: BoxDecoration(),
      child: Column(
        children: [
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.productDataModel.imageUrl),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {
                      debugPrint('Failed to load image: $exception');
                    })),
          ),
          Text(widget.productDataModel.name),
          Text(widget.productDataModel.description),
          Text("${widget.productDataModel.price}\$"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.favorite),
                  color: Colors.red,
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.shopping_cart)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
