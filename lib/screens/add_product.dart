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
    categoriesDropDown = getCategoriesDropDown();
    //_currentCategory = categoriesDropDown[0].value;
  }

  getCategoriesDropDown() {
    List<DropdownMenuItem<String>> items = new List();

    for (int i = 0; i < categories.length; i++) {
      setState(() {
        categoriesDropDown.insert(
            0,
            DropdownMenuItem(
              child: Text(categories[i]['category']),
              value: categories[i]['category'],
            ));
      });
    }
    print('getCategoriesDropDown(): categories = ' + items.length.toString());
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
            Visibility(
              visible: _currentCategory != null || _currentCategory == '',
              // child: Text(
              //   _currentCategory ?? 'null',
              //   style: TextStyle(color: Colors.red),
              // ),
              child: InkWell(
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            _currentCategory ?? 'null',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          color: Colors.white,
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  autofocus: false,
                  decoration: InputDecoration(hintText: 'Add category'),
                  style: DefaultTextStyle.of(context)
                      .style
                      .copyWith(fontStyle: FontStyle.normal, fontSize: 20.0),
                  //decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                suggestionsCallback: (pattern) async {
                  return await _categoryService.getSuggestions(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    leading: Icon(Icons.category),
                    title: Text(suggestion['category']),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  setState(() {
                    _currentCategory = suggestion['category'];
                  });
                },
              ),
            ),

// * for add Bands
            Visibility(
              visible: _currentBrand != null || _currentBrand == '',
              // child: Text(
              //   _currentBrand ?? 'null',
              //   style: TextStyle(color: Colors.red),
              // ),
              child: InkWell(
                child: Material(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            _currentBrand ?? 'null',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.close),
                          color: Colors.white,
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TypeAheadField(
                textFieldConfiguration: TextFieldConfiguration(
                  autofocus: false,
                  decoration: InputDecoration(hintText: 'Add Bands'),
                  style: DefaultTextStyle.of(context)
                      .style
                      .copyWith(fontStyle: FontStyle.normal, fontSize: 20.0),
                  //decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                suggestionsCallback: (pattern) async {
                  return await _brandService.getSuggestions(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    leading: Icon(Icons.category),
                    title: Text(suggestion['bands']),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  setState(() {
                    _currentCategory = suggestion['bands'];
                  });
                },
              ),
            ),
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
      print('_getCategories(): categories = ' + categories.length.toString());
    });
  }

  changeSelectedCategory(String selectedCategory) {
    setState(() {
      _currentCategory = selectedCategory;
    });
  }
}
