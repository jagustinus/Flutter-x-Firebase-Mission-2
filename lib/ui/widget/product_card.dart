import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:learn_flutter/model/model.dart';
import 'package:learn_flutter/ui/page/page.dart';

class ProductCard extends StatelessWidget {
  final Products product;
  ProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        onTap: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return EditPage(product);
          }));
        },
        title: Text(
          product.name,
          style: TextStyle(fontSize: 20),
        ),
        subtitle: Text(
          NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
              .format(double.parse(product.price)),
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(product.image, scale: 40),
          child: Text(
            product.name[0],
            style: TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
