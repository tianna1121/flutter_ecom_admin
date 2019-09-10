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
    super.initState();
    _getCategories();
    _getBrands();
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

  List<DropdownMenuItem<String>> getBrandsDropDown() {
    List<DropdownMenuItem<String>> items = new List();

    for (int i = 0; i < brands.length; i++) {
      setState(() {
        items.insert(
            0,
            DropdownMenuItem(
              child: Text(brands[i].data['brand']),
              value: brands[i].data['brand'],
            ));
      });
    }
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
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Category',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                DropdownButton(
                  items: categoriesDropDown,
                  onChanged: changeSelectedCategory,
                  value: _currentCategory,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Brand',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                DropdownButton(
                  items: brandsDropDown,
                  onChanged: changeSelectedCategory,
                  value: _currentBrand,
                ),
              ],
            ),
// * Set The Quantity
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextFormField(
                controller: productNameController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Quantity'),
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please input the size';
                  }
                },
              ),
            ),
// * Choose the Size
            Row(
              children: <Widget>[
                Checkbox(
                  value: false,
                  onChanged: null,
                ),
                Text('XS'),
                Checkbox(
                  value: false,
                  onChanged: null,
                ),
                Text('S'),
                Checkbox(
                  value: false,
                  onChanged: null,
                ),
                Text('M'),
                Checkbox(
                  value: false,
                  onChanged: null,
                ),
                Text('L'),
                Checkbox(
                  value: false,
                  onChanged: null,
                ),
                Text('XL'),
                Checkbox(
                  value: false,
                  onChanged: null,
                ),
                Text('XXL'),
              ],
            ),
// * Choose the Size
            Row(
              children: <Widget>[
                Checkbox(
                  value: false,
                  onChanged: null,
                ),
                Text('28'),
                Checkbox(
                  value: false,
                  onChanged: null,
                ),
                Text('30'),
                Checkbox(
                  value: false,
                  onChanged: null,
                ),
                Text('32'),
                Checkbox(
                  value: false,
                  onChanged: null,
                ),
                Text('34'),
                Checkbox(
                  value: false,
                  onChanged: null,
                ),
                Text('36'),
                Checkbox(
                  value: false,
                  onChanged: null,
                ),
                Text('38'),
              ],
            ),
            Row(
              children: <Widget>[
                Checkbox(
                  value: false,
                  onChanged: null,
                ),
                Text('40'),
                Checkbox(
                  value: false,
                  onChanged: null,
                ),
                Text('42'),
                Checkbox(
                  value: false,
                  onChanged: null,
                ),
                Text('44'),
                Checkbox(
                  value: false,
                  onChanged: null,
                ),
                Text('46'),
              ],
            ),
            FlatButton(
              color: Colors.red,
              textColor: Colors.white,
              child: Text('add brand'),
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

  void _getBrands() async {
    List<DocumentSnapshot> data = await _brandService.getBrands();
    //print(data.length);
    setState(() {
      brands = data;
      brandsDropDown = getBrandsDropDown();
      _currentBrand = brands[0].data['brand'];
    });
  }

  changeSelectedBrand(String selectedBrand) {
    setState(() {
      _currentBrand = selectedBrand;
    });
  }
}
