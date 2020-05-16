import 'dart:io';
import 'package:dob/bloc/register_bloc/register_bloc.dart';
import 'package:dob/data/AuthRepository.dart';
import 'package:dob/pages/outletscreen.dart';
import 'package:dob/pages/register/registerbutton.dart';
import 'package:dob/widgets/categoriesDropdown.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SignUpDetails extends StatefulWidget {
  final String email, password, phoneNum;
  final AuthRepository authRepository;
  SignUpDetails(
      {this.email, this.password, this.phoneNum, this.authRepository});
  @override
  _SignUpDetailsState createState() => _SignUpDetailsState();
}

class _SignUpDetailsState extends State<SignUpDetails> {
  TextEditingController _merchantNameController = TextEditingController();

  TextEditingController _descriptionController = TextEditingController();

  TextEditingController _addressController = TextEditingController();

  TextEditingController _websiteController = TextEditingController();

  List<Categories> _categories = Categories.getCompanies();
  List<DropdownMenuItem<Categories>> _dropdownMenuItems;
  Categories _selectedCategory;
  File _logoImage;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_categories);
    _selectedCategory = _dropdownMenuItems[0].value;
    super.initState();
  }

  onChangeDropdownItem(Categories selectedCategory) {
    setState(() {
      _selectedCategory = selectedCategory;
    });
  }

  List<DropdownMenuItem<Categories>> buildDropdownMenuItems(List _categories) {
    List<DropdownMenuItem<Categories>> items = List();
    for (Categories category in _categories) {
      items.add(
        DropdownMenuItem(
          value: category,
          child: Text(category.name),
        ),
      );
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      floatingActionButton: FlatButton.icon(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider<RegisterBloc>(
                    create: (context) =>
                        RegisterBloc(authRepository: widget.authRepository),
                    child: OutletScreen(
                      email: widget.email,
                      password: widget.password,
                      phoneNum: widget.phoneNum,
                    ))),
          );
        },
        icon: Icon(Icons.arrow_forward_ios),
        label: Text("Continue"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Form(
          child: ListView(
            children: <Widget>[
              Center(
                child: Text(
                  "Merchant Details",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.person),
                  labelText: 'Merchant Name',
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autovalidate: true,
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.description),
                  labelText: 'Description of your shop',
                ),
                maxLines: 4,
                keyboardType: TextInputType.number,
                autocorrect: false,
                autovalidate: true,
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.shopping_basket),
                  labelText: 'Store\'s address',
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autovalidate: true,
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(
                  icon: Icon(Icons.web),
                  labelText: 'Website Url (Optional)',
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autovalidate: true,
              ),
              SizedBox(height: 30.0),
              Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Select your Store's Category"),
                      SizedBox(
                        height: 15.0,
                      ),
                      DropdownButton(
                        value: _selectedCategory,
                        items: _dropdownMenuItems,
                        onChanged: onChangeDropdownItem,
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                      // Text('Selected: ${_selectedCategory.name}'),
                      // SizedBox(
                      //   height: 15.0,
                      // ),
                      Container(
                        width: 180,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                              width: 2.0,
                              color: Theme.of(context).primaryColor),
                        ),
                        child: FlatButton.icon(
                          onPressed: getImageGallery,
                          icon: Icon(Icons.photo_camera),
                          label: Text("Upload Your Logo"),
                        ),
                      ),
                      SizedBox(
                        height: 15.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getImageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _logoImage = image;
      Navigator.pop(context);
      _logoImage != null
          ? Flushbar(
              borderRadius: 8,
              message: "Image Uploaded Sucessfully",
              duration: Duration(seconds: 3),
            ).show(context)
          : null;
    });
  }
}
