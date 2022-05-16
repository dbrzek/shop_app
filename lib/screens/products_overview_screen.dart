import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

class ProductsOverviewScreen extends StatelessWidget {
  //const ProductsOverviewScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //drawer: ,
      appBar: AppBar(
        title: Text('My Shop'),
      ),
      body: ProductsGrid(),
    );
  }
}


