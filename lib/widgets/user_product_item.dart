import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String title;

  UserProductItem({
    this.id,
    this.imageUrl,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Products>(context, listen: false);
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
            ),
            IconButton(
              icon: Icon(Icons.delete),
              color: Theme.of(context).errorColor,
              onPressed: () {
                Future returnData = showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: Row(
                          children: <Widget>[
                            Icon(Icons.warning),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text('Are you sure')
                          ],
                        ),
                        content: Text('Do you want to remoe the item'),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('No'),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                          ),
                          FlatButton(
                            child: Text('Yes'),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                          )
                        ],
                      );
                    });

                returnData.then((val) {
                  if (val) {
                    product.deleteProduct(id);
                  }
                }).catchError((err) {});
              },
            )
          ],
        ),
      ),
    );
  }
}
