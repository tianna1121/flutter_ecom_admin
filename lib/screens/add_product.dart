import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecom_admin/db/brand.dart';
import 'package:flutter_ecom_admin/db/category.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController productNameController = TextEditingController();
  List<DocumentSnapshot> brands = <DocumentSnapshot>[];
  List<DocumentSnapshot> categories = <DocumentSnapshot>[];
  List<DropdownMenuItem<String>> categoriesDropDown =
      <DropdownMenuItem<String>>[];
  List<DropdownMenuItem<String>> brandsDropDown = <DropdownMenuItem<String>>[];
  String _currentCategory;
  String _currentBrand;
  CategoryService _categoryService = CategoryService();
  BrandService _brandService = BrandService();

  @override
  void initState() {
    //   super.initState();
    _getCategories();
    //_getBrands();
    //_currentCategory = categoriesDropDown[0].value;
  }

  List<DropdownMenuItem<String>> getCategoriesDropDown() {
    List<DropdownMenuItem<String>> items = new List();

    for (int i = 0; i < categories.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
              child: Text(categories[i].data['category']),
              value: categories[i].data['category'],
            ));
      });
    }
    print('getCategoriesDropDown(): categories = ' + items.length.toString());
    return items;
  }

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
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.8)),
                      onPressed: () {},
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(14.0, 70.0, 14.0, 70.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.8)),
                      onPressed: () {},
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(14.0, 70.0, 14.0, 70.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OutlineButton(
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.8)),
                      onPressed: () {},
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(14.0, 70.0, 14.0, 70.0),
                        child: Icon(
                          Icons.add,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Enter a product name with 10 characters at maximun',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: productNameController,
                decoration: InputDecoration(hintText: 'Product Name'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'You must input product name';
                  } else if (value.length > 10) {
                    return 'Product name cant have more than 10 letters';
                  }
                },
              ),
            ),
            // * Select Category
            DropdownButton(
              items: categoriesDropDown,
              onChanged: changeSelectedCategory,
              value: _currentCategory,
            ),
            FlatButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Text('add product'),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  void _getCategories() async {
    List<DocumentSnapshot> data = await _categoryService.getCategories();
    print(data.length);
    setState(() {
      categories = data;
      categoriesDropDown = getCategoriesDropDown();
      _currentCategory = categories[0].data['category'];
    });
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() {
      _currentCategory = selectedCategory;
    });
  }
}
