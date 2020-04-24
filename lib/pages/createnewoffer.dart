import 'dart:io';
import 'package:dob/scoped-models/products.dart';
import 'package:dob/widgets/date_time_field.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:image_picker/image_picker.dart';

class CreateNewOffer extends StatefulWidget {
  // final Product product;
  // CreateNewOffer({@required this.product});

  @override
  _CreateNewOfferState createState() => _CreateNewOfferState();
}

class _CreateNewOfferState extends State<CreateNewOffer> {
  double get getDeviceWidth => MediaQuery.of(context).size.width;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  File _image;
  final _descriptionFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  int days, hours;
  final BasicDateTimeField startingDate = BasicDateTimeField(true);
  final BasicDateTimeField endingDate = BasicDateTimeField(false);
  final Map<String, dynamic> _formData = {
    'title': null,
    'description': null,
    'price': null,
  };

  Widget _buildTitleTextField() {
    return TextFormField(
      focusNode: _titleFocusNode,
      decoration: InputDecoration(labelText: 'Product Title'),
      validator: (String value) {
        if (value.isEmpty || value.length < 5) {
          return 'Title is required and should be 5+ characters long.';
        }
      },
      onSaved: (String value) {
        _formData['title'] = value;
      },
      onTap: () {
        setState(() {});
      },
    );
  }

  Widget _buildDescriptionTextField() {
    return TextFormField(
      focusNode: _descriptionFocusNode,
      maxLines: 4,
      decoration: InputDecoration(labelText: 'Product Description'),
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty || value.length < 10) {
          return 'Description is required and should be 10+ characters long.';
        }
      },
      onSaved: (String value) {
        _formData['description'] = value;
      },
      onTap: () {
        setState(() {});
      },
    );
  }

  Widget _buildPriceTextField() {
    return TextFormField(
      focusNode: _priceFocusNode,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: 'Product Price'),
      validator: (String value) {
        // if (value.trim().length <= 0) {
        if (value.isEmpty ||
            !RegExp(r'^(?:[1-9]\d*|0)?(?:\.\d+)?$').hasMatch(value)) {
          return 'Price is required and should be a number.';
        }
      },
      onSaved: (String value) {
        _formData['price'] = double.parse(value);
      },
      onTap: () {
        setState(() {});
      },
    );
  }

  Widget _buildsubmitButton() {
    return ScopedModelDescendant<Products>(
        builder: (BuildContext context, Widget child, Products model) {
      return Container(
        width: 180,
        height: 40,
        child: FlatButton.icon(
          icon: Icon(
            Icons.save,
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          color: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          onPressed: () {
            if (_image == null) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text("Please Upload All Details"),
                ),
              );
            } else {
              _submitForm(model.add_products);
              Navigator.pop(context);
            }
          }, // _submitForm(model.add_products),
          label: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Submit',
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
          ),
        ),
      );
    });
  }

  void _submitForm(Function addProduct) {
    if (!_formKey.currentState.validate()) {
      print("validation error");
      return;
    }
    _formKey.currentState.save();
    days = endingDate.getDateTime.difference(startingDate.getDateTime).inDays;
    hours =
        (endingDate.getDateTime.difference(startingDate.getDateTime).inHours) %
            24;
    print(days.toString() + '    ' + hours.toString());
    print("Form SUbmitted");
    addProduct(_formData['title'], _formData['description'], _formData['price'],
        _image, days, hours);
  }

  @override
  Widget build(BuildContext context) {
    final double _deviceWidth = MediaQuery.of(context).size.width;

    Future getImageCamera() async {
      var image = await ImagePicker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = image;
        Navigator.pop(context);
        _image != null
            ? Flushbar(
                borderRadius: 8,
                message: "Image Uploaded Sucessfully",
                duration: Duration(seconds: 3),
              ).show(context)
            : null;
      });
    }

    Future getImageGallery() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        Navigator.pop(context);
        _image != null
            ? Flushbar(
                borderRadius: 8,
                message: "Image Uploaded Sucessfully",
                duration: Duration(seconds: 3),
              ).show(context)
            : null;
      });
    }

    Future<void> dialogueBox() async {
      return showDialog<void>(
        context: context,
        barrierDismissible:
            false, // user must tap button otherwise dialog doesn't close
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            backgroundColor: Colors.white95,
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("Choose your source"),
                  SizedBox(height: 30.0),
                  Container(
                    height: 45,
                    child: InkWell(
                      onTap: getImageCamera,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.camera),
                          SizedBox(
                            width: 30,
                          ),
                          Text("Camera")
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  Container(
                    height: 45,
                    child: InkWell(
                      onTap: getImageGallery,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Icon(Icons.photo_album),
                          SizedBox(width: 30),
                          Text("Gallery")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "New Offer",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          setState(() {});
        },
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "Enter the Offer Details",
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.2),
                        ),
                      ),
                      SizedBox(height: 30),
                      _buildTitleTextField(),
                      _buildDescriptionTextField(),
                      _buildPriceTextField(),
                      SizedBox(
                        height: 40.0,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: 180,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2.0,
                                color: Theme.of(context).primaryColor),
                          ),
                          child: FlatButton.icon(
                            onPressed: dialogueBox,
                            icon: Icon(Icons.photo_camera),
                            label: Text("Upload an Image"),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Your Offer Period",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "From",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.2),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: startingDate,
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Text(
                          "To",
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.2),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: endingDate,
                      ),
                      SizedBox(height: 20),
                      _buildsubmitButton()
                    ],
                  ),
                ),
              ),
              // if (_titleFocusNode.hasFocus ||
              //     _priceFocusNode.hasFocus ||
              //     _descriptionFocusNode.hasFocus)
              //   Align(
              //     alignment: Alignment.bottomCenter,
              //     child: Visibility(
              //       visible: false,
              //       child: _buildsubmitButton(),
              //     ),
              //   )
              // else
              //   Positioned.fill(
              //     bottom: 30.0,
              //     child: Align(
              //       alignment: Alignment.bottomCenter,
              //       child: Visibility(
              //         visible: true,
              //         child: _buildsubmitButton(),
              //       ),
              //     ),
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
