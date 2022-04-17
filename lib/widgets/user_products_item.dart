import 'package:flutter/material.dart';
import 'package:online_shop/providers/products_provider.dart';
import 'package:online_shop/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProductsItem extends StatelessWidget {
  // const UserProductsItem({ Key? key }) : super(key: key);
  final String id;
  final String title;
  final String imgUrl;
  UserProductsItem({
    required this.id,
    required this.title,
    required this.imgUrl,
  });

  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imgUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: MediaQuery.of(context).size.width * 0.3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProductScreen.routeName);
              },
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).primaryColor,
              ),
            ),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<ProductsProvider>(context).removeItem(id);
                } catch (error) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text("Couldn't delete!")));
                }
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
