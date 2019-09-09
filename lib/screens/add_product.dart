import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.close,
          color: Colors.black,
        ),
        title: Text(
          'Add product',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: ListView(
        children: <Widget>[
          OutlineButton(
            borderSide:
                BorderSide(color: Colors.grey.withOpacity(0.8), width: 1.0),
            onPressed: () {},
            child: Icon(
              Icons.add,
              color: Colors.grey,
            ),
          )
        ],
      ),
    );
  }
}
